use crate::account::{Account, Subaccount};
use candid::CandidType;
use ic_cdk::export::Principal;
use mini_ledger_core::block::HashOf;
use mini_ledger_core::timestamp::TimeStamp;
use serde::{Deserialize, Serialize};
use serde_bytes::ByteBuf;
use std::fmt;

pub const MAX_MEMO_LENGTH: usize = 32;
/// The memo to use for balances burned during trimming
pub const TRIMMED_MEMO: u64 = u64::MAX;

#[derive(Serialize, Deserialize, Debug)]
pub struct TransactionInfo<TransactionType> {
    pub block_timestamp: TimeStamp,
    pub transaction_hash: HashOf<TransactionType>,
}

pub fn ser_compact_account<S>(acc: &Account, s: S) -> Result<S::Ok, S::Error>
where
    S: serde::ser::Serializer,
{
    CompactAccount::from(acc.clone()).serialize(s)
}

pub fn de_compact_account<'de, D>(d: D) -> Result<Account, D::Error>
where
    D: serde::de::Deserializer<'de>,
{
    use serde::de::Error;
    let compact_account = CompactAccount::deserialize(d)?;
    Account::try_from(compact_account).map_err(D::Error::custom)
}

/// A compact representation of an Account.
///
/// Instead of encoding accounts as structs with named fields,
/// we encode them as tuples with variables number of elements.
/// ```text
/// [bytes] <=> Account { owner: bytes, subaccount : None }
/// [x: bytes, y: bytes] <=> Account { owner: x, subaccount: Some(y) }
/// ```
#[derive(Serialize, Deserialize)]
#[serde(transparent)]
struct CompactAccount(Vec<ByteBuf>);

impl From<Account> for CompactAccount {
    fn from(acc: Account) -> Self {
        let mut components = vec![ByteBuf::from(acc.owner.as_slice().to_vec())];
        if let Some(sub) = acc.subaccount {
            components.push(ByteBuf::from(sub.to_vec()))
        }
        CompactAccount(components)
    }
}

impl TryFrom<CompactAccount> for Account {
    type Error = String;
    fn try_from(compact: CompactAccount) -> Result<Account, String> {
        let elems = compact.0;
        if elems.is_empty() {
            return Err("account tuple must have at least one element".to_string());
        }
        if elems.len() > 2 {
            return Err(format!(
                "account tuple must have at most two elements, got {}",
                elems.len()
            ));
        }

        let principal =
            Principal::try_from(&elems[0][..]).map_err(|e| format!("invalid principal: {}", e))?;
        let subaccount = if elems.len() > 1 {
            Some(Subaccount::try_from(&elems[1][..]).map_err(|_| {
                format!(
                    "invalid subaccount: expected 32 bytes, got {}",
                    elems[1].len()
                )
            })?)
        } else {
            None
        };

        Ok(Account {
            owner: principal,
            subaccount,
        })
    }
}

#[derive(Serialize, Deserialize, Clone, Hash, Debug, PartialEq, Eq, PartialOrd, Ord)]
#[serde(tag = "op")]
pub enum Operation {
    #[serde(rename = "mint")]
    Mint {
        #[serde(serialize_with = "ser_compact_account")]
        #[serde(deserialize_with = "de_compact_account")]
        to: Account,
        #[serde(rename = "amt")]
        amount: u64,
    },
    #[serde(rename = "xfer")]
    Transfer {
        #[serde(serialize_with = "ser_compact_account")]
        #[serde(deserialize_with = "de_compact_account")]
        from: Account,
        #[serde(serialize_with = "ser_compact_account")]
        #[serde(deserialize_with = "de_compact_account")]
        to: Account,
        #[serde(rename = "amt")]
        amount: u64,
        fee: u64,
    },
    #[serde(rename = "burn")]
    Burn {
        #[serde(serialize_with = "ser_compact_account")]
        #[serde(deserialize_with = "de_compact_account")]
        from: Account,
        #[serde(rename = "amt")]
        amount: u64,
    },
}

#[derive(Debug, PartialEq, Eq)]
pub struct MemoTooLarge(usize);

impl fmt::Display for MemoTooLarge {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "Memo field is {} bytes long, max allowed length is {}",
            self.0, MAX_MEMO_LENGTH
        )
    }
}

#[derive(
    Serialize, Deserialize, CandidType, Clone, Hash, Debug, PartialEq, Eq, PartialOrd, Ord, Default,
)]
#[serde(transparent)]
pub struct Memo(#[serde(deserialize_with = "deserialize_memo_bytes")] ByteBuf);

fn deserialize_memo_bytes<'de, D>(d: D) -> Result<ByteBuf, D::Error>
where
    D: serde::de::Deserializer<'de>,
{
    use serde::de::Error;
    let bytes = ByteBuf::deserialize(d)?;
    let memo = Memo::try_from(bytes).map_err(D::Error::custom)?;
    Ok(memo.into())
}

impl From<[u8; MAX_MEMO_LENGTH]> for Memo {
    fn from(memo: [u8; MAX_MEMO_LENGTH]) -> Self {
        Self(ByteBuf::from(memo.to_vec()))
    }
}

impl From<u64> for Memo {
    fn from(num: u64) -> Self {
        Self(ByteBuf::from(num.to_be_bytes().to_vec()))
    }
}

impl TryFrom<ByteBuf> for Memo {
    type Error = MemoTooLarge;

    fn try_from(b: ByteBuf) -> Result<Self, MemoTooLarge> {
        if b.len() > MAX_MEMO_LENGTH {
            return Err(MemoTooLarge(b.len()));
        }
        Ok(Self(b))
    }
}

impl TryFrom<Vec<u8>> for Memo {
    type Error = MemoTooLarge;

    fn try_from(v: Vec<u8>) -> Result<Self, MemoTooLarge> {
        Self::try_from(ByteBuf::from(v))
    }
}

impl From<Memo> for ByteBuf {
    fn from(memo: Memo) -> Self {
        memo.0
    }
}

#[derive(Serialize, Deserialize, Clone, Hash, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub struct Transaction {
    #[serde(flatten)]
    pub operation: Operation,

    #[serde(default)]
    #[serde(skip_serializing_if = "Option::is_none")]
    #[serde(rename = "ts")]
    pub created_at_time: Option<u64>,

    #[serde(default)]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub memo: Option<Memo>,
}
