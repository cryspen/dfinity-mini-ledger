pub mod account;
pub mod endpoints;
pub mod hash;
pub mod transaction;

use account::Account;
use candid::{types::number::Nat, CandidType};
use endpoints::{GetTransactionsResponse, Transaction as Tx};
use transaction::{Memo, Operation, Transaction, TransactionInfo, TRIMMED_MEMO};
// use ic_icrc1::endpoints::{
//     ArchivedTransactionRange, GetTransactionsResponse, QueryArchiveFn, Transaction as Tx, Value,
// };
// use ic_icrc1::{Account, Block, LedgerBalances, Transaction};
// use ic_ledger_canister_core::{
//     archive::{ArchiveCanisterWasm, ArchiveOptions},
//     blockchain::Blockchain,
//     ledger::{apply_transaction, block_locations, LedgerData, TransactionInfo},
//     range_utils,
// };
use mini_ledger_core::{
    balances::{BalanceError, Balances, BalancesStore},
    block::{BlockIndex, BlockType, EncodedBlock, HashOf},
    timestamp::TimeStamp,
    tokens::Tokens,
};
use serde::{Deserialize, Serialize};
use serde_bytes::ByteBuf;
use std::collections::{BTreeMap, HashMap, VecDeque};
use std::time::Duration;

use ciborium::tag::Required;
// use ic_ledger_canister_core::ledger::LedgerTransaction;

pub const PERMITTED_DRIFT: Duration = Duration::from_secs(60);

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, Eq)]
pub enum TransferError {
    BadFee { expected_fee: Tokens },
    InsufficientFunds { balance: Tokens },
    TxTooOld { allowed_window_nanos: u64 },
    TxCreatedInFuture { ledger_time: TimeStamp },
    TxThrottled,
    TxDuplicate { duplicate_of: BlockIndex },
}

pub trait LedgerTransaction: Sized {
    type AccountId: std::hash::Hash + Eq;

    /// Constructs a new "burn" transaction that removes the specified `amount` of tokens from the
    /// `from` account.
    fn burn(
        from: Self::AccountId,
        amount: Tokens,
        at: Option<TimeStamp>,
        memo: Option<u64>,
    ) -> Self;

    /// Returns the time at which the transaction was constructed.
    fn created_at_time(&self) -> Option<TimeStamp>;

    /// Returns the hash of this transaction.
    fn hash(&self) -> HashOf<Self>;

    /// Applies this transaction to the balance book.
    fn apply<S>(&self, balances: &mut Balances<Self::AccountId, S>) -> Result<(), BalanceError>
    where
        S: Default + BalancesStore<Self::AccountId>;
}

impl LedgerTransaction for Transaction {
    type AccountId = Account;

    fn burn(
        from: Account,
        amount: Tokens,
        created_at_time: Option<TimeStamp>,
        memo: Option<u64>,
    ) -> Self {
        Self {
            operation: Operation::Burn {
                from,
                amount: amount.get_e8s(),
            },
            created_at_time: created_at_time.map(|t| t.as_nanos_since_unix_epoch()),
            memo: memo.map(Memo::from),
        }
    }

    fn created_at_time(&self) -> Option<TimeStamp> {
        self.created_at_time
            .map(TimeStamp::from_nanos_since_unix_epoch)
    }

    fn hash(&self) -> HashOf<Self> {
        let mut cbor_bytes = vec![];
        ciborium::ser::into_writer(self, &mut cbor_bytes)
            .expect("bug: failed to encode a transaction");
        hash::hash_cbor(&cbor_bytes)
            .map(HashOf::new)
            .unwrap_or_else(|err| {
                panic!(
                    "bug: transaction CBOR {} is not hashable: {}",
                    hex::encode(&cbor_bytes),
                    err
                )
            })
    }

    fn apply<S>(&self, balances: &mut Balances<Self::AccountId, S>) -> Result<(), BalanceError>
    where
        S: Default + BalancesStore<Self::AccountId>,
    {
        match &self.operation {
            Operation::Transfer {
                from,
                to,
                amount,
                fee,
            } => balances.transfer(from, to, Tokens::from_e8s(*amount), Tokens::from_e8s(*fee)),
            Operation::Burn { from, amount } => balances.burn(from, Tokens::from_e8s(*amount)),
            Operation::Mint { to, amount } => balances.mint(to, Tokens::from_e8s(*amount)),
        }
    }
}

/// Stores a chain of transactions with their metadata
#[derive(Serialize, Deserialize, Debug)]
#[serde(bound = "")]
pub struct Blockchain {
    pub blocks: Vec<EncodedBlock>,
    pub last_hash: Option<HashOf<EncodedBlock>>,

    /// The timestamp of the most recent block. Must be monotonically
    /// non-decreasing.
    pub last_timestamp: TimeStamp,

    /// How many blocks have been sent to the archive
    pub num_archived_blocks: u64,
}

impl Default for Blockchain {
    fn default() -> Self {
        Self {
            blocks: vec![],
            last_hash: None,
            last_timestamp: TimeStamp::from_nanos_since_unix_epoch(0),
            num_archived_blocks: 0,
        }
    }
}

impl Blockchain {
    pub fn chain_length(&self) -> BlockIndex {
        self.blocks.len() as u64
    }

    pub fn add_block<B>(&mut self, block: B) -> Result<BlockIndex, String>
    where
        B: BlockType,
    {
        if block.parent_hash() != self.last_hash {
            return Err("Cannot apply block because its parent hash doesn't match.".to_string());
        }
        if block.timestamp() < self.last_timestamp {
            return Err(
                "Cannot apply block because its timestamp is older than the previous tip."
                    .to_owned(),
            );
        }
        self.last_timestamp = block.timestamp();
        let encoded_block = block.encode();
        self.last_hash = Some(B::block_hash(&encoded_block));
        self.blocks.push(encoded_block);
        Ok(self.chain_length().checked_sub(1).unwrap())
    }

    /// Returns the slice of blocks stored locally.
    ///
    /// # Panic
    ///
    /// This function panics if the specified range is not a subset of locally available blocks.
    pub fn block_slice(&self, local_blocks: std::ops::Range<u64>) -> &[EncodedBlock] {
        &self.blocks[local_blocks.start as usize..local_blocks.end as usize]
    }
}

pub trait LedgerData {
    type AccountId: std::hash::Hash + Ord + Eq + Clone;
    type Block: BlockType<Transaction = Self::Transaction>;
    type Transaction: LedgerTransaction<AccountId = Self::AccountId> + Ord + Clone;

    // Purge configuration

    /// How long the ledger needs to remembered transactions to detect duplicates.
    fn transaction_window(&self) -> Duration;

    /// Maximum number of transactions that this ledger will accept
    /// within the [transaction_window].
    fn max_transactions_in_window(&self) -> usize;

    /// The maximum number of transactions that we attempt to purge in one go.
    fn max_transactions_to_purge(&self) -> usize;

    /// The maximum size of the balances map.
    fn max_number_of_accounts(&self) -> usize;

    /// How many accounts with lowest balances to purge when the number of accounts exceeds
    /// [LedgerData::max_number_of_accounts].
    fn accounts_overflow_trim_quantity(&self) -> usize;

    // Token configuration

    /// Token name (e.g., Bitcoin).
    fn token_name(&self) -> &str;

    /// Token symbol (e.g., BTC).
    fn token_symbol(&self) -> &str;

    // Ledger data structures

    fn balances(&self) -> &Balances<Self::AccountId, HashMap<Self::AccountId, Tokens>>;
    fn balances_mut(&mut self) -> &mut Balances<Self::AccountId, HashMap<Self::AccountId, Tokens>>;

    fn blockchain(&self) -> &Blockchain;
    fn blockchain_mut(&mut self) -> &mut Blockchain;

    fn transactions_by_hash(&self) -> &BTreeMap<HashOf<Self::Transaction>, BlockIndex>;
    fn transactions_by_hash_mut(&mut self) -> &mut BTreeMap<HashOf<Self::Transaction>, BlockIndex>;

    fn transactions_by_height(&self) -> &VecDeque<TransactionInfo<Self::Transaction>>;
    fn transactions_by_height_mut(&mut self) -> &mut VecDeque<TransactionInfo<Self::Transaction>>;

    /// The callback that the ledger framework calls when it purges a transaction.
    fn on_purged_transaction(&mut self, height: BlockIndex);
}

/// Removes at most [LedgerData::max_transactions_to_purge] transactions older
/// than `now - Ledger::transaction_window` and returns the number of purged
/// transactions.
pub fn purge_old_transactions<L: LedgerData>(ledger: &mut L, now: TimeStamp) -> usize {
    let max_tx_to_purge = ledger.max_transactions_to_purge();
    let mut num_tx_purged = 0usize;

    while let Some(tx_info) = ledger.transactions_by_height().front() {
        if tx_info.block_timestamp + ledger.transaction_window() + PERMITTED_DRIFT >= now {
            // Stop at a sufficiently recent block.
            break;
        }

        let transaction_hash = tx_info.transaction_hash;

        match ledger.transactions_by_hash_mut().remove(&transaction_hash) {
            None => unreachable!(
                concat!(
                    "invariant violation: transaction with hash {} ",
                    "is in transaction_by_height but not in transactions_by_hash"
                ),
                transaction_hash
            ),
            Some(block_height) => ledger.on_purged_transaction(block_height),
        }

        ledger.transactions_by_height_mut().pop_front();

        num_tx_purged += 1;
        if num_tx_purged >= max_tx_to_purge {
            break;
        }
    }
    num_tx_purged
}

// Find the specified number of accounts with lowest balances so that their
// balances can be reclaimed.
fn select_accounts_to_trim<L: LedgerData>(ledger: &L) -> Vec<(Tokens, L::AccountId)> {
    let mut to_trim: std::collections::BinaryHeap<(Tokens, L::AccountId)> =
        std::collections::BinaryHeap::new();

    let num_accounts = ledger.accounts_overflow_trim_quantity();
    let mut iter = ledger.balances().store.iter();

    // Accumulate up to `trim_quantity` accounts
    for (account, balance) in iter.by_ref().take(num_accounts) {
        to_trim.push((*balance, account.clone()));
    }

    for (account, balance) in iter {
        // If any account's balance is lower than the maximum in our set,
        // include that account, and remove the current maximum
        if let Some((greatest_balance, _)) = to_trim.peek() {
            if balance < greatest_balance {
                to_trim.push((*balance, account.clone()));
                to_trim.pop();
            }
        }
    }

    to_trim.into_vec()
}

/// Returns true if the next transaction should be throttled due to high
/// load on the ledger.
fn throttle<L: LedgerData>(ledger: &L, now: TimeStamp) -> bool {
    let num_in_window = ledger.transactions_by_height().len();
    // We admit the first half of max_transactions_in_window freely.
    // After that we start throttling on per-second basis.
    // This way we guarantee that at most max_transactions_in_window will
    // get through within the transaction window.
    if num_in_window >= ledger.max_transactions_in_window() / 2 {
        // max num of transactions allowed per second
        let max_rate = (0.5 * ledger.max_transactions_in_window() as f64
            / ledger.transaction_window().as_secs_f64())
        .ceil() as usize;

        if ledger
            .transactions_by_height()
            .get(num_in_window.saturating_sub(max_rate))
            .map(|tx| tx.block_timestamp)
            .unwrap_or_else(|| TimeStamp::from_nanos_since_unix_epoch(0))
            + Duration::from_secs(1)
            > now
        {
            return true;
        }
    }
    false
}
/// Adds a new block with the specified transaction to the ledger.
pub fn apply_transaction<L: LedgerData>(
    ledger: &mut L,
    transaction: L::Transaction,
    now: TimeStamp,
) -> Result<(BlockIndex, HashOf<EncodedBlock>), TransferError> {
    let num_pruned = purge_old_transactions(ledger, now);

    // If we pruned some transactions, let this one through
    // otherwise throttle if there are too many
    if num_pruned == 0 && throttle(ledger, now) {
        return Err(TransferError::TxThrottled);
    }

    let maybe_time_and_hash = transaction
        .created_at_time()
        .map(|created_at_time| (created_at_time, transaction.hash()));

    if let Some((created_at_time, tx_hash)) = maybe_time_and_hash {
        // The caller requested deduplication.
        if created_at_time + ledger.transaction_window() < now {
            return Err(TransferError::TxTooOld {
                allowed_window_nanos: ledger.transaction_window().as_nanos() as u64,
            });
        }

        if created_at_time > now + PERMITTED_DRIFT {
            return Err(TransferError::TxCreatedInFuture { ledger_time: now });
        }

        if let Some(block_height) = ledger.transactions_by_hash().get(&tx_hash) {
            return Err(TransferError::TxDuplicate {
                duplicate_of: *block_height,
            });
        }
    }

    transaction
        .apply(ledger.balances_mut())
        .map_err(|e| match e {
            BalanceError::InsufficientFunds { balance } => {
                TransferError::InsufficientFunds { balance }
            }
        })?;

    let block = L::Block::from_transaction(ledger.blockchain().last_hash, transaction, now);
    let block_timestamp = block.timestamp();

    let height = ledger
        .blockchain_mut()
        .add_block(block)
        .expect("failed to add block");

    if let Some((_, tx_hash)) = maybe_time_and_hash {
        // The caller requested deduplication, so we have to remember this
        // transaction within the dedup window.
        ledger.transactions_by_hash_mut().insert(tx_hash, height);

        ledger
            .transactions_by_height_mut()
            .push_back(TransactionInfo {
                block_timestamp,
                transaction_hash: tx_hash,
            });
    }

    let to_trim = if ledger.balances().store.len()
        >= ledger.max_number_of_accounts() + ledger.accounts_overflow_trim_quantity()
    {
        select_accounts_to_trim(ledger)
    } else {
        vec![]
    };

    for (balance, account) in to_trim {
        let burn_tx = L::Transaction::burn(account, balance, Some(now), Some(TRIMMED_MEMO));

        burn_tx
            .apply(ledger.balances_mut())
            .expect("failed to burn funds that must have existed");

        let parent_hash = ledger.blockchain().last_hash;

        ledger
            .blockchain_mut()
            .add_block(L::Block::from_transaction(parent_hash, burn_tx, now))
            .unwrap();
    }

    Ok((height, ledger.blockchain().last_hash.unwrap()))
}

// impl LedgerTransaction for Transaction {
//     type AccountId = Account;
//
//     fn burn(
//         from: Account,
//         amount: Tokens,
//         created_at_time: Option<TimeStamp>,
//         memo: Option<u64>,
//     ) -> Self {
//         Self {
//             operation: Operation::Burn {
//                 from,
//                 amount: amount.get_e8s(),
//             },
//             created_at_time: created_at_time.map(|t| t.as_nanos_since_unix_epoch()),
//             memo: memo.map(Memo::from),
//         }
//     }
//
//     fn created_at_time(&self) -> Option<TimeStamp> {
//         self.created_at_time
//             .map(TimeStamp::from_nanos_since_unix_epoch)
//     }
//
//     fn hash(&self) -> HashOf<Self> {
//         let mut cbor_bytes = vec![];
//         ciborium::ser::into_writer(self, &mut cbor_bytes)
//             .expect("bug: failed to encode a transaction");
//         hash::hash_cbor(&cbor_bytes)
//             .map(HashOf::new)
//             .unwrap_or_else(|err| {
//                 panic!(
//                     "bug: transaction CBOR {} is not hashable: {}",
//                     hex::encode(&cbor_bytes),
//                     err
//                 )
//             })
//     }
//
//     fn apply<S>(&self, balances: &mut Balances<Self::AccountId, S>) -> Result<(), BalanceError>
//     where
//         S: Default + BalancesStore<Self::AccountId>,
//     {
//         match &self.operation {
//             Operation::Transfer {
//                 from,
//                 to,
//                 amount,
//                 fee,
//             } => balances.transfer(from, to, Tokens::from_e8s(*amount), Tokens::from_e8s(*fee)),
//             Operation::Burn { from, amount } => balances.burn(from, Tokens::from_e8s(*amount)),
//             Operation::Mint { to, amount } => balances.mint(to, Tokens::from_e8s(*amount)),
//         }
//     }
// }

impl Transaction {
    pub fn mint(
        to: Account,
        amount: Tokens,
        created_at_time: Option<TimeStamp>,
        memo: Option<Memo>,
    ) -> Self {
        Self {
            operation: Operation::Mint {
                to,
                amount: amount.get_e8s(),
            },
            created_at_time: created_at_time.map(|t| t.as_nanos_since_unix_epoch()),
            memo,
        }
    }

    pub fn transfer(
        from: Account,
        to: Account,
        amount: Tokens,
        fee: Tokens,
        created_at_time: Option<TimeStamp>,
        memo: Option<Memo>,
    ) -> Self {
        Self {
            operation: Operation::Transfer {
                from,
                to,
                amount: amount.get_e8s(),
                fee: fee.get_e8s(),
            },
            created_at_time: created_at_time.map(|t| t.as_nanos_since_unix_epoch()),
            memo,
        }
    }
}

#[derive(Serialize, Deserialize, Clone, Hash, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub struct Block {
    #[serde(rename = "phash")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub parent_hash: Option<HashOf<EncodedBlock>>,
    #[serde(rename = "tx")]
    pub transaction: Transaction,
    #[serde(rename = "ts")]
    pub timestamp: u64,
}

type TaggedBlock = Required<Block, 55799>;

impl BlockType for Block {
    type Transaction = Transaction;

    fn encode(self) -> EncodedBlock {
        let mut bytes = vec![];
        let value: TaggedBlock = Required(self);
        ciborium::ser::into_writer(&value, &mut bytes).expect("bug: failed to encode a block");
        EncodedBlock::from_vec(bytes)
    }

    fn decode(encoded_block: EncodedBlock) -> Result<Self, String> {
        let bytes = encoded_block.into_vec();
        let tagged_block: TaggedBlock = ciborium::de::from_reader(&bytes[..])
            .map_err(|e| format!("failed to decode a block: {}", e))?;
        Ok(tagged_block.0)
    }

    fn block_hash(encoded_block: &EncodedBlock) -> HashOf<EncodedBlock> {
        hash::hash_cbor(encoded_block.as_slice())
            .map(HashOf::new)
            .unwrap_or_else(|err| {
                panic!(
                    "bug: encoded block {} is not hashable cbor: {}",
                    hex::encode(encoded_block.as_slice()),
                    err
                )
            })
    }

    fn parent_hash(&self) -> Option<HashOf<EncodedBlock>> {
        self.parent_hash
    }

    fn timestamp(&self) -> TimeStamp {
        TimeStamp::from_nanos_since_unix_epoch(self.timestamp)
    }

    fn from_transaction(
        parent_hash: Option<HashOf<EncodedBlock>>,
        transaction: Self::Transaction,
        timestamp: TimeStamp,
    ) -> Self {
        Self {
            parent_hash,
            transaction,
            timestamp: timestamp.as_nanos_since_unix_epoch(),
        }
    }
}

pub type LedgerBalances = Balances<Account, HashMap<Account, Tokens>>;

const TRANSACTION_WINDOW: Duration = Duration::from_secs(24 * 60 * 60);
const MAX_ACCOUNTS: usize = 28_000_000;
const ACCOUNTS_OVERFLOW_TRIM_QUANTITY: usize = 100_000;
const MAX_TRANSACTIONS_IN_WINDOW: usize = 3_000_000;
const MAX_TRANSACTIONS_TO_PURGE: usize = 100_000;

/// Like [endpoints::Value], but can be serialized to CBOR.
#[derive(Deserialize, Serialize, Clone, Debug)]
pub enum StoredValue {
    NatBytes(ByteBuf),
    IntBytes(ByteBuf),
    Text(String),
    Blob(ByteBuf),
}

// impl From<StoredValue> for Value {
//     fn from(v: StoredValue) -> Self {
//         match v {
//             StoredValue::NatBytes(num_bytes) => Self::Nat(
//                 Nat::decode(&mut &num_bytes[..])
//                     .unwrap_or_else(|e| panic!("bug: invalid Nat encoding {:?}: {}", num_bytes, e)),
//             ),
//             StoredValue::IntBytes(int_bytes) => Self::Int(
//                 Int::decode(&mut &int_bytes[..])
//                     .unwrap_or_else(|e| panic!("bug: invalid Int encoding {:?}: {}", int_bytes, e)),
//             ),
//             StoredValue::Text(text) => Self::Text(text),
//             StoredValue::Blob(bytes) => Self::Blob(bytes),
//         }
//     }
// }
//
// impl From<Value> for StoredValue {
//     fn from(v: Value) -> Self {
//         match v {
//             Value::Nat(num) => {
//                 let mut buf = vec![];
//                 num.encode(&mut buf).expect("bug: failed to encode nat");
//                 Self::NatBytes(ByteBuf::from(buf))
//             }
//             Value::Int(int) => {
//                 let mut buf = vec![];
//                 int.encode(&mut buf).expect("bug: failed to encode nat");
//                 Self::IntBytes(ByteBuf::from(buf))
//             }
//             Value::Text(text) => Self::Text(text),
//             Value::Blob(bytes) => Self::Blob(bytes),
//         }
//     }
// }

#[derive(Deserialize, CandidType, Clone, Debug, PartialEq, Eq)]
pub struct InitArgs {
    pub minting_account: Account,
    pub initial_balances: Vec<(Account, u64)>,
    pub transfer_fee: u64,
    pub token_name: String,
    pub token_symbol: String,
    // pub metadata: Vec<(String, Value)>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Ledger {
    balances: LedgerBalances,
    blockchain: Blockchain,
    minting_account: Account,

    transactions_by_hash: BTreeMap<HashOf<Transaction>, BlockIndex>,
    transactions_by_height: VecDeque<TransactionInfo<Transaction>>,
    transfer_fee: Tokens,

    token_symbol: String,
    token_name: String,
}

impl Ledger {
    pub fn from_init_args(
        InitArgs {
            minting_account,
            initial_balances,
            transfer_fee,
            token_name,
            token_symbol,
        }: InitArgs,
        now: TimeStamp,
    ) -> Self {
        let mut ledger = Self {
            balances: LedgerBalances::default(),
            transactions_by_hash: BTreeMap::new(),
            transactions_by_height: VecDeque::new(),
            blockchain: Blockchain::default(),
            minting_account,
            transfer_fee: Tokens::from_e8s(transfer_fee),
            token_symbol,
            token_name,
        };

        for (account, balance) in initial_balances.into_iter() {
            apply_transaction(
                &mut ledger,
                Transaction::mint(account.clone(), Tokens::from_e8s(balance), Some(now), None),
                now,
            )
            .unwrap_or_else(|err| {
                panic!("failed to mint {} e8s to {}: {:?}", balance, account, err)
            });
        }

        ledger
    }
}

impl LedgerData for Ledger {
    type AccountId = Account;
    type Transaction = Transaction;
    type Block = Block;

    fn transaction_window(&self) -> Duration {
        TRANSACTION_WINDOW
    }

    fn max_transactions_in_window(&self) -> usize {
        MAX_TRANSACTIONS_IN_WINDOW
    }

    fn max_transactions_to_purge(&self) -> usize {
        MAX_TRANSACTIONS_TO_PURGE
    }

    fn max_number_of_accounts(&self) -> usize {
        MAX_ACCOUNTS
    }

    fn accounts_overflow_trim_quantity(&self) -> usize {
        ACCOUNTS_OVERFLOW_TRIM_QUANTITY
    }

    fn token_name(&self) -> &str {
        &self.token_name
    }

    fn token_symbol(&self) -> &str {
        &self.token_symbol
    }

    fn balances(&self) -> &Balances<Self::AccountId, HashMap<Self::AccountId, Tokens>> {
        &self.balances
    }

    fn balances_mut(&mut self) -> &mut Balances<Self::AccountId, HashMap<Self::AccountId, Tokens>> {
        &mut self.balances
    }

    fn blockchain(&self) -> &Blockchain {
        &self.blockchain
    }

    fn blockchain_mut(&mut self) -> &mut Blockchain {
        &mut self.blockchain
    }

    fn transactions_by_hash(&self) -> &BTreeMap<HashOf<Self::Transaction>, BlockIndex> {
        &self.transactions_by_hash
    }

    fn transactions_by_hash_mut(&mut self) -> &mut BTreeMap<HashOf<Self::Transaction>, BlockIndex> {
        &mut self.transactions_by_hash
    }

    fn transactions_by_height(&self) -> &VecDeque<TransactionInfo<Self::Transaction>> {
        &self.transactions_by_height
    }

    fn transactions_by_height_mut(&mut self) -> &mut VecDeque<TransactionInfo<Self::Transaction>> {
        &mut self.transactions_by_height
    }

    fn on_purged_transaction(&mut self, _height: BlockIndex) {}
}

impl Ledger {
    pub fn minting_account(&self) -> &Account {
        &self.minting_account
    }

    pub fn transfer_fee(&self) -> Tokens {
        self.transfer_fee
    }

    /// Returns transactions in the specified range.
    pub fn get_transactions(&self, start: BlockIndex, length: usize) -> GetTransactionsResponse {
        let local_transactions: Vec<Tx> = self
            .blockchain
            .block_slice(start..(start + length as u64))
            .iter()
            .map(|enc_block| -> Tx {
                Block::decode(enc_block.clone())
                    .expect("bug: failed to decode encoded block")
                    .into()
            })
            .collect();

        GetTransactionsResponse {
            first_index: Nat::from(start),
            log_length: Nat::from(self.blockchain.chain_length()),
            transactions: local_transactions,
        }
    }
}

pub trait LedgerAccess {
    type Ledger: LedgerData;

    /// Executes a function on a ledger reference.
    ///
    /// # Panics
    ///
    /// Panics if `f` tries to call `with_ledger` or `with_ledger_mut` recurvively.
    fn with_ledger<R>(f: impl FnOnce(&Self::Ledger) -> R) -> R;

    /// Executes a function on a mutable ledger reference.
    ///
    /// # Panics
    ///
    /// Panics if `f` tries to call `with_ledger` or `with_ledger_mut` recurvively.
    fn with_ledger_mut<R>(f: impl FnOnce(&mut Self::Ledger) -> R) -> R;
}
