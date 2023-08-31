module Mini_ledger
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

let v_PERMITTED_DRIFT: Core.Time.t_Duration = Core.Time.from_secs_under_impl_1 60uL

type t_TransferError =
  | TransferError_BadFee { f_expected_fee:Mini_ledger_core.Tokens.t_Tokens }: t_TransferError
  | TransferError_InsufficientFunds { f_balance:Mini_ledger_core.Tokens.t_Tokens }: t_TransferError
  | TransferError_TxTooOld { f_allowed_window_nanos:u64 }: t_TransferError
  | TransferError_TxCreatedInFuture { f_ledger_time:Mini_ledger_core.Timestamp.t_TimeStamp }: t_TransferError
  | TransferError_TxThrottled : t_TransferError
  | TransferError_TxDuplicate { f_duplicate_of:u64 }: t_TransferError

let v___: Prims.unit = ()

let v___1: Prims.unit = ()

class t_LedgerTransaction (v_Self: Type) = {
  accountId:Type;
  accountId_implements_t_Eq:Core.Cmp.t_Eq _;
  accountId_implements_t_PartialEq:Core.Cmp.t_PartialEq _ _;
  accountId_implements_t_Hash:Core.Hash.t_Hash _;
  accountId_implements_t_Sized:Core.Marker.t_Sized _;
  burn:
      _ ->
      Mini_ledger_core.Tokens.t_Tokens ->
      Core.Option.t_Option Mini_ledger_core.Timestamp.t_TimeStamp ->
      Core.Option.t_Option u64
    -> self;
  created_at_time:self -> Core.Option.t_Option Mini_ledger_core.Timestamp.t_TimeStamp;
  hash:self -> Mini_ledger_core.Block.t_HashOf self;
  apply:self -> l -> (l & Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError)
}

let impl: t_LedgerTransaction Mini_ledger.Transaction.t_Transaction =
  {
    accountId = Mini_ledger.Account.t_Account;
    burn
    =
    (fun
        (from: Mini_ledger.Account.t_Account)
        (amount: Mini_ledger_core.Tokens.t_Tokens)
        (created_at_time: Core.Option.t_Option Mini_ledger_core.Timestamp.t_TimeStamp)
        (memo: Core.Option.t_Option u64)
        ->
        {
          Mini_ledger.Transaction.Transaction.f_operation
          =
          Mini_ledger.Transaction.Operation_Burn
          ({
              Mini_ledger.Transaction.Operation.Burn.f_from = from;
              Mini_ledger.Transaction.Operation.Burn.f_amount
              =
              Mini_ledger_core.Tokens.get_e8s_under_impl amount
            });
          Mini_ledger.Transaction.Transaction.f_created_at_time
          =
          Core.Option.map_under_impl created_at_time
            (fun t -> Mini_ledger_core.Timestamp.as_nanos_since_unix_epoch_under_impl t <: u64);
          Mini_ledger.Transaction.Transaction.f_memo
          =
          Core.Option.map_under_impl memo Core.Convert.From.from
        });
    created_at_time
    =
    (fun (self: Mini_ledger.Transaction.t_Transaction) ->
        Core.Option.map_under_impl self.Mini_ledger.Transaction.Transaction.f_created_at_time
          Mini_ledger_core.Timestamp.from_nanos_since_unix_epoch_under_impl);
    hash
    =
    (fun (self: Mini_ledger.Transaction.t_Transaction) ->
        let cbor_bytes:Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global = Alloc.Vec.new_under_impl in
        let tmp0, out:(Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global &
          Core.Result.t_Result Prims.unit (Ciborium.Ser.Error.t_Error _)) =
          Ciborium.Ser.into_writer self cbor_bytes
        in
        let cbor_bytes:Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global = tmp0 in
        let hoist158:(Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global &
          Core.Result.t_Result Prims.unit (Ciborium.Ser.Error.t_Error _)) =
          out
        in
        let _:Prims.unit =
          Core.Result.expect_under_impl hoist158 "bug: failed to encode a transaction"
        in
        Core.Result.unwrap_or_else_under_impl (Core.Result.map_under_impl (Mini_ledger.Hash.hash_cbor
                  (Core.Ops.Deref.Deref.deref cbor_bytes <: slice u8)
                <:
                Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
              Mini_ledger_core.Block.new_under_impl_2
            <:
            Core.Result.t_Result
              (Mini_ledger_core.Block.t_HashOf Mini_ledger.Transaction.t_Transaction)
              Alloc.String.t_String)
          (fun err ->
              Rust_primitives.Hax.never_to_any (Core.Panicking.panic_fmt (Core.Fmt.new_v1_under_impl_2
                        (Rust_primitives.unsize (let list =
                                ["bug: transaction CBOR "; " is not hashable: "]
                              in
                              FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                              Rust_primitives.Hax.array_of_list list)
                          <:
                          slice string)
                        (Rust_primitives.unsize (let list =
                                [
                                  Core.Fmt.Rt.new_display_under_impl_1 (Hex.encode cbor_bytes
                                      <:
                                      Alloc.String.t_String)
                                  <:
                                  Core.Fmt.Rt.t_Argument;
                                  Core.Fmt.Rt.new_display_under_impl_1 err <: Core.Fmt.Rt.t_Argument
                                ]
                              in
                              FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                              Rust_primitives.Hax.array_of_list list)
                          <:
                          slice Core.Fmt.Rt.t_Argument)
                      <:
                      Core.Fmt.t_Arguments)
                  <:
                  Rust_primitives.Hax.t_Never)
              <:
              Mini_ledger_core.Block.t_HashOf Mini_ledger.Transaction.t_Transaction));
    apply
    =
    fun (self: Mini_ledger.Transaction.t_Transaction) (ledger: l) ->
      let ledger, output:(l &
        (l & Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError)) =
        match self.Mini_ledger.Transaction.Transaction.f_operation with
        | Mini_ledger.Transaction.Operation_Transfer
          { Mini_ledger.Transaction.Operation.Transfer.f_from = from ;
            Mini_ledger.Transaction.Operation.Transfer.f_to = to ;
            Mini_ledger.Transaction.Operation.Transfer.f_amount = amount ;
            Mini_ledger.Transaction.Operation.Transfer.f_fee = fee } ->
          let tmp0, out:(l &
            Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
            Mini_ledger.LedgerData.transfer_balance ledger
              from
              to
              (Mini_ledger_core.Tokens.from_e8s_under_impl amount
                <:
                Mini_ledger_core.Tokens.t_Tokens)
              (Mini_ledger_core.Tokens.from_e8s_under_impl fee <: Mini_ledger_core.Tokens.t_Tokens)
          in
          let ledger:l = tmp0 in
          ledger, out
        | Mini_ledger.Transaction.Operation_Burn
          { Mini_ledger.Transaction.Operation.Burn.f_from = from ;
            Mini_ledger.Transaction.Operation.Burn.f_amount = amount } ->
          let tmp0, out:(l &
            Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
            Mini_ledger.LedgerData.burn_balance ledger
              from
              (Mini_ledger_core.Tokens.from_e8s_under_impl amount
                <:
                Mini_ledger_core.Tokens.t_Tokens)
          in
          let ledger:l = tmp0 in
          ledger, out
        | Mini_ledger.Transaction.Operation_Mint
          { Mini_ledger.Transaction.Operation.Mint.f_to = to ;
            Mini_ledger.Transaction.Operation.Mint.f_amount = amount } ->
          let tmp0, out:(l &
            Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
            Mini_ledger.LedgerData.mint_balance ledger
              to
              (Mini_ledger_core.Tokens.from_e8s_under_impl amount
                <:
                Mini_ledger_core.Tokens.t_Tokens)
          in
          let ledger:l = tmp0 in
          ledger, out
      in
      ledger, output
  }

type t_Blockchain = {
  f_blocks:Alloc.Vec.t_Vec Mini_ledger_core.Block.t_EncodedBlock Alloc.Alloc.t_Global;
  f_last_hash:Core.Option.t_Option
  (Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock);
  f_last_timestamp:Mini_ledger_core.Timestamp.t_TimeStamp;
  f_num_archived_blocks:u64
}

let v___2: Prims.unit = ()

let v___3: Prims.unit = ()

let impl: Core.Default.t_Default t_Blockchain =
  {
    default
    =
    fun  ->
      {
        Mini_ledger.Blockchain.f_blocks = Alloc.Vec.new_under_impl;
        Mini_ledger.Blockchain.f_last_hash = Core.Option.Option_None;
        Mini_ledger.Blockchain.f_last_timestamp
        =
        Mini_ledger_core.Timestamp.from_nanos_since_unix_epoch_under_impl 0uL;
        Mini_ledger.Blockchain.f_num_archived_blocks = 0uL
      }
  }

let chain_length_under_impl_2 (self: t_Blockchain) : u64 =
  cast (Alloc.Vec.len_under_impl_1 self.Mini_ledger.Blockchain.f_blocks)

let add_block_under_impl_2 (self: t_Blockchain) (block: b)
    : (t_Blockchain & Core.Result.t_Result u64 Alloc.String.t_String) =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* _:Prims.unit =
        if
          (Mini_ledger_core.Block.BlockType.parent_hash block
            <:
            Core.Option.t_Option
            (Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock)) <>.
          self.Mini_ledger.Blockchain.f_last_hash
        then
          let* hoist159:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (self,
                Core.Result.Result_Err
                (Alloc.String.ToString.to_string "Cannot apply block because its parent hash doesn't match."

                  <:
                  Alloc.String.t_String))
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist159)
        else Core.Ops.Control_flow.ControlFlow_Continue ()
      in
      let* _:Prims.unit =
        if
          (Mini_ledger_core.Block.BlockType.timestamp block
            <:
            Mini_ledger_core.Timestamp.t_TimeStamp) <.
          self.Mini_ledger.Blockchain.f_last_timestamp
        then
          let* hoist160:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (self,
                Core.Result.Result_Err
                (Alloc.Borrow.ToOwned.to_owned "Cannot apply block because its timestamp is older than the previous tip."

                  <:
                  _))
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist160)
        else Core.Ops.Control_flow.ControlFlow_Continue ()
      in
      Core.Ops.Control_flow.ControlFlow_Continue
      (let self:t_Blockchain =
          {
            self with
            Mini_ledger.Blockchain.f_last_timestamp
            =
            Mini_ledger_core.Block.BlockType.timestamp block
          }
        in
        let encoded_block:Mini_ledger_core.Block.t_EncodedBlock =
          Mini_ledger_core.Block.BlockType.encode block
        in
        let self:t_Blockchain =
          {
            self with
            Mini_ledger.Blockchain.f_last_hash
            =
            Core.Option.Option_Some (Mini_ledger_core.Block.BlockType.block_hash encoded_block)
          }
        in
        let self:t_Blockchain =
          {
            self with
            Mini_ledger.Blockchain.f_blocks
            =
            Alloc.Vec.push_under_impl_1 self.Mini_ledger.Blockchain.f_blocks encoded_block
          }
        in
        let output:Core.Result.t_Result u64 Alloc.String.t_String =
          Core.Result.Result_Ok
          (Core.Option.unwrap_under_impl (Core.Num.checked_sub_under_impl_9 (chain_length_under_impl_2
                      self
                    <:
                    u64)
                  1uL
                <:
                Core.Option.t_Option u64))
        in
        self, output))

let block_slice_under_impl_2 (self: t_Blockchain) (local_blocks: Core.Ops.Range.t_Range u64)
    : slice Mini_ledger_core.Block.t_EncodedBlock =
  self.Mini_ledger.Blockchain.f_blocks.[ {
      Core.Ops.Range.Range.f_start = cast local_blocks.Core.Ops.Range.Range.f_start;
      Core.Ops.Range.Range.f_end = cast local_blocks.Core.Ops.Range.Range.f_end
    } ]

class t_LedgerData (v_Self: Type) = {
  accountId:Type;
  accountId_implements_t_Clone:Core.Clone.t_Clone _;
  accountId_implements_t_Eq:Core.Cmp.t_Eq _;
  accountId_implements_t_PartialEq:Core.Cmp.t_PartialEq _ _;
  accountId_implements_t_Ord:Core.Cmp.t_Ord _;
  accountId_implements_t_PartialOrd:Core.Cmp.t_PartialOrd _ _;
  accountId_implements_t_Hash:Core.Hash.t_Hash _;
  accountId_implements_t_Sized:Core.Marker.t_Sized _;
  block:Type;
  block_implements_t_BlockType:Mini_ledger_core.Block.t_BlockType _;
  block_implements_t_Sized:Core.Marker.t_Sized _;
  transaction:Type;
  transaction_implements_t_Clone:Core.Clone.t_Clone _;
  transaction_implements_t_Ord:Core.Cmp.t_Ord _;
  transaction_implements_t_PartialOrd:Core.Cmp.t_PartialOrd _ _;
  transaction_implements_t_PartialEq:Core.Cmp.t_PartialEq _ _;
  transaction_implements_t_Eq:Core.Cmp.t_Eq _;
  transaction_implements_t_LedgerTransaction:t_LedgerTransaction _;
  transaction_implements_t_Sized:Core.Marker.t_Sized _;
  transaction_window:self -> Core.Time.t_Duration;
  max_transactions_in_window:self -> usize;
  max_transactions_to_purge:self -> usize;
  max_number_of_accounts:self -> usize;
  accounts_overflow_trim_quantity:self -> usize;
  token_name:self -> string;
  token_symbol:self -> string;
  balances:self
    -> Mini_ledger_core.Balances.t_Balances _
        (Std.Collections.Hash.Map.t_HashMap _
            Mini_ledger_core.Tokens.t_Tokens
            Std.Collections.Hash.Map.t_RandomState);
  transfer_balance:
      self ->
      Mini_ledger.Account.t_Account ->
      Mini_ledger.Account.t_Account ->
      Mini_ledger_core.Tokens.t_Tokens ->
      Mini_ledger_core.Tokens.t_Tokens
    -> (self & Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError);
  mint_balance:self -> Mini_ledger.Account.t_Account -> Mini_ledger_core.Tokens.t_Tokens
    -> (self & Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError);
  burn_balance:self -> Mini_ledger.Account.t_Account -> Mini_ledger_core.Tokens.t_Tokens
    -> (self & Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError);
  blockchain:self -> t_Blockchain;
  blockchain_add_block:self -> _ -> (self & Core.Result.t_Result u64 Alloc.String.t_String);
  transactions_by_hash:self
    -> Alloc.Collections.Btree.Map.t_BTreeMap (Mini_ledger_core.Block.t_HashOf _)
        u64
        Alloc.Alloc.t_Global;
  remove_transactions_by_hash:self -> Mini_ledger_core.Block.t_HashOf _
    -> (self & Core.Option.t_Option u64);
  insert_transactions_by_hash:self -> Mini_ledger_core.Block.t_HashOf _ -> u64
    -> (self & Core.Option.t_Option u64);
  transactions_by_height:self
    -> Alloc.Collections.Vec_deque.t_VecDeque (Mini_ledger.Transaction.t_TransactionInfo _)
        Alloc.Alloc.t_Global;
  pop_front_transactions_by_height:self -> self;
  push_back_transactions_by_height:self -> Mini_ledger.Transaction.t_TransactionInfo _ -> self;
  on_purged_transaction:self -> u64 -> self
}

let purge_old_transactions
      (#l: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized l)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: t_LedgerData l)
      (ledger: l)
      (now: Mini_ledger_core.Timestamp.t_TimeStamp)
    : (l & usize) =
  let max_tx_to_purge:usize = Mini_ledger.LedgerData.max_transactions_to_purge ledger in
  let num_tx_purged_out:usize = 0sz in
  let break_loop:bool = false in
  let break_loop, ledger, num_tx_purged_out:(bool & l & usize) =
    Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter ({
              Core.Ops.Range.Range.f_start = 0sz;
              Core.Ops.Range.Range.f_end = max_tx_to_purge
            })
        <:
        _)
      (break_loop, ledger, num_tx_purged_out)
      (fun (break_loop, ledger, num_tx_purged_out) num_tx_purged ->
          if ~.break_loop <: bool
          then
            let num_tx_purged_out:usize = num_tx_purged in
            match
              Alloc.Collections.Vec_deque.front_under_impl_5 (Mini_ledger.LedgerData.transactions_by_height
                    ledger
                  <:
                  Alloc.Collections.Vec_deque.t_VecDeque
                    (Mini_ledger.Transaction.t_TransactionInfo _) Alloc.Alloc.t_Global)
            with
            | Core.Option.Option_Some tx_info ->
              let break_loop:bool =
                if
                  ((tx_info.Mini_ledger.Transaction.TransactionInfo.f_block_timestamp +.
                      (Mini_ledger.LedgerData.transaction_window ledger <: Core.Time.t_Duration)
                      <:
                      _) +.
                    v_PERMITTED_DRIFT
                    <:
                    Mini_ledger_core.Timestamp.t_TimeStamp) >=.
                  now
                then
                  let break_loop:bool = true in
                  break_loop
                else break_loop
              in
              let transaction_hash:Mini_ledger_core.Block.t_HashOf _ =
                tx_info.Mini_ledger.Transaction.TransactionInfo.f_transaction_hash
              in
              let tmp0, out:(l & Core.Option.t_Option u64) =
                Mini_ledger.LedgerData.remove_transactions_by_hash ledger transaction_hash
              in
              let ledger:l = tmp0 in
              let hoist161:(l & Core.Option.t_Option u64) = out in
              let ledger:l =
                match hoist161 with
                | Core.Option.Option_None  -> ledger
                | Core.Option.Option_Some block_height ->
                  Mini_ledger.LedgerData.on_purged_transaction ledger block_height
              in
              let ledger:l = Mini_ledger.LedgerData.pop_front_transactions_by_height ledger in
              break_loop, ledger, num_tx_purged_out
            | _ -> break_loop, ledger, num_tx_purged_out
          else break_loop, ledger, num_tx_purged_out)
  in
  let output:usize = num_tx_purged_out in
  ledger, output

let select_accounts_to_trim
      (#l: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized l)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: t_LedgerData l)
      (ledger: l)
    : Alloc.Vec.t_Vec (Mini_ledger_core.Tokens.t_Tokens & _) Alloc.Alloc.t_Global =
  let (to_trim: Alloc.Collections.Binary_heap.t_BinaryHeap (Mini_ledger_core.Tokens.t_Tokens & _)):Alloc.Collections.Binary_heap.t_BinaryHeap
  (Mini_ledger_core.Tokens.t_Tokens & _) =
    Alloc.Collections.Binary_heap.new_under_impl_9
  in
  let num_accounts:usize = Mini_ledger.LedgerData.accounts_overflow_trim_quantity ledger in
  let to_trim:Alloc.Collections.Binary_heap.t_BinaryHeap (Mini_ledger_core.Tokens.t_Tokens & _) =
    Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter (Core.Iter.Traits.Iterator.Iterator.take
              (Std.Collections.Hash.Map.iter_under_impl_1 (Mini_ledger.LedgerData.balances ledger
                    <:
                    Mini_ledger_core.Balances.t_Balances _
                      (Std.Collections.Hash.Map.t_HashMap _
                          Mini_ledger_core.Tokens.t_Tokens
                          Std.Collections.Hash.Map.t_RandomState))
                    .Mini_ledger_core.Balances.Balances.f_store
                <:
                Std.Collections.Hash.Map.t_Iter _ Mini_ledger_core.Tokens.t_Tokens)
              num_accounts
            <:
            Core.Iter.Adapters.Take.t_Take
            (Std.Collections.Hash.Map.t_Iter _ Mini_ledger_core.Tokens.t_Tokens))
        <:
        _)
      to_trim
      (fun to_trim (account, balance) ->
          Alloc.Collections.Binary_heap.push_under_impl_9 to_trim
            (balance, (Core.Clone.Clone.clone account <: _))
          <:
          Alloc.Collections.Binary_heap.t_BinaryHeap (Mini_ledger_core.Tokens.t_Tokens & _))
  in
  let to_trim:Alloc.Collections.Binary_heap.t_BinaryHeap (Mini_ledger_core.Tokens.t_Tokens & _) =
    Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter (Core.Iter.Traits.Iterator.Iterator.skip
              (Std.Collections.Hash.Map.iter_under_impl_1 (Mini_ledger.LedgerData.balances ledger
                    <:
                    Mini_ledger_core.Balances.t_Balances _
                      (Std.Collections.Hash.Map.t_HashMap _
                          Mini_ledger_core.Tokens.t_Tokens
                          Std.Collections.Hash.Map.t_RandomState))
                    .Mini_ledger_core.Balances.Balances.f_store
                <:
                Std.Collections.Hash.Map.t_Iter _ Mini_ledger_core.Tokens.t_Tokens)
              num_accounts
            <:
            Core.Iter.Adapters.Skip.t_Skip
            (Std.Collections.Hash.Map.t_Iter _ Mini_ledger_core.Tokens.t_Tokens))
        <:
        _)
      to_trim
      (fun to_trim (account, balance) ->
          match
            Alloc.Collections.Binary_heap.peek_under_impl_10 to_trim
            <:
            Core.Option.t_Option (Mini_ledger_core.Tokens.t_Tokens & _)
          with
          | Core.Option.Option_Some (greatest_balance, _) ->
            if balance <. greatest_balance <: bool
            then
              let to_trim:Alloc.Collections.Binary_heap.t_BinaryHeap
              (Mini_ledger_core.Tokens.t_Tokens & _) =
                Alloc.Collections.Binary_heap.push_under_impl_9 to_trim
                  (balance, (Core.Clone.Clone.clone account <: _))
              in
              let tmp0, out:(Alloc.Collections.Binary_heap.t_BinaryHeap
                (Mini_ledger_core.Tokens.t_Tokens & _) &
                Core.Option.t_Option (Mini_ledger_core.Tokens.t_Tokens & _)) =
                Alloc.Collections.Binary_heap.pop_under_impl_9 to_trim
              in
              let to_trim:Alloc.Collections.Binary_heap.t_BinaryHeap
              (Mini_ledger_core.Tokens.t_Tokens & _) =
                tmp0
              in
              let _:(Alloc.Collections.Binary_heap.t_BinaryHeap
                (Mini_ledger_core.Tokens.t_Tokens & _) &
                Core.Option.t_Option (Mini_ledger_core.Tokens.t_Tokens & _)) =
                out
              in
              to_trim
            else to_trim
          | _ -> to_trim)
  in
  Alloc.Collections.Binary_heap.into_vec_under_impl_10 to_trim

let throttle
      (#l: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized l)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: t_LedgerData l)
      (ledger: l)
      (now: Mini_ledger_core.Timestamp.t_TimeStamp)
    : bool =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let num_in_window:usize =
        Alloc.Collections.Vec_deque.len_under_impl_5 (Mini_ledger.LedgerData.transactions_by_height ledger

            <:
            Alloc.Collections.Vec_deque.t_VecDeque (Mini_ledger.Transaction.t_TransactionInfo _)
              Alloc.Alloc.t_Global)
      in
      let* _:Prims.unit =
        if
          num_in_window >=.
          ((Mini_ledger.LedgerData.max_transactions_in_window ledger <: usize) /. 2sz <: usize)
        then
          let max_rate:usize =
            cast (((cast (Mini_ledger.LedgerData.max_transactions_in_window ledger <: usize) /. 2uL
                    <:
                    u64) /.
                  (Core.Time.as_secs_under_impl_1 (Mini_ledger.LedgerData.transaction_window ledger
                        <:
                        Core.Time.t_Duration)
                    <:
                    u64)
                  <:
                  u64) +.
                1uL)
          in
          if
            ((Core.Option.unwrap_or_else_under_impl (Core.Option.map_under_impl (Alloc.Collections.Vec_deque.get_under_impl_5
                          (Mini_ledger.LedgerData.transactions_by_height ledger
                            <:
                            Alloc.Collections.Vec_deque.t_VecDeque
                              (Mini_ledger.Transaction.t_TransactionInfo _) Alloc.Alloc.t_Global)
                          (Core.Num.saturating_sub_under_impl_11 num_in_window max_rate <: usize)
                        <:
                        Core.Option.t_Option (Mini_ledger.Transaction.t_TransactionInfo _))
                      (fun tx -> tx.Mini_ledger.Transaction.TransactionInfo.f_block_timestamp)
                    <:
                    Core.Option.t_Option Mini_ledger_core.Timestamp.t_TimeStamp)
                  (fun  ->
                      Mini_ledger_core.Timestamp.from_nanos_since_unix_epoch_under_impl 0uL
                      <:
                      Mini_ledger_core.Timestamp.t_TimeStamp)
                <:
                Mini_ledger_core.Timestamp.t_TimeStamp) +.
              (Core.Time.from_secs_under_impl_1 1uL <: Core.Time.t_Duration)
              <:
              Mini_ledger_core.Timestamp.t_TimeStamp) >.
            now
          then
            let* hoist162:Rust_primitives.Hax.t_Never =
              Core.Ops.Control_flow.ControlFlow.v_Break true
            in
            Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist162)
          else Core.Ops.Control_flow.ControlFlow_Continue ()
        else Core.Ops.Control_flow.ControlFlow_Continue ()
      in
      Core.Ops.Control_flow.ControlFlow_Continue false)

let apply_transaction
      (#l: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized l)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: t_LedgerData l)
      (ledger: l)
      (transaction: _)
      (now: Mini_ledger_core.Timestamp.t_TimeStamp)
    : (l &
      Core.Result.t_Result
        (u64 & Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock)
        t_TransferError) =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let tmp0, out:(l & usize) =
        purge_old_transactions ledger now
      in
      let ledger:l = tmp0 in
      let num_pruned:(l & usize) = out in
      let* _:Prims.unit =
        if Prims.op_AmpAmp (num_pruned =. 0sz) (throttle ledger now)
        then
          let* hoist163:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (ledger,
                Core.Result.Result_Err TransferError_TxThrottled)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist163)
        else Core.Ops.Control_flow.ControlFlow_Continue ()
      in
      let maybe_time_and_hash:Core.Option.t_Option
      (Mini_ledger_core.Timestamp.t_TimeStamp & Mini_ledger_core.Block.t_HashOf _) =
        Core.Option.map_under_impl (Mini_ledger.LedgerTransaction.created_at_time transaction
            <:
            Core.Option.t_Option Mini_ledger_core.Timestamp.t_TimeStamp)
          (fun created_at_time ->
              created_at_time,
              (Mini_ledger.LedgerTransaction.hash transaction <: Mini_ledger_core.Block.t_HashOf _))
      in
      let* _:Prims.unit =
        match maybe_time_and_hash with
        | Core.Option.Option_Some (created_at_time, tx_hash) ->
          let* _:Prims.unit =
            if
              (created_at_time +.
                (Mini_ledger.LedgerData.transaction_window ledger <: Core.Time.t_Duration)
                <:
                Mini_ledger_core.Timestamp.t_TimeStamp) <.
              now
            then
              let* hoist164:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (ledger,
                    Core.Result.Result_Err
                    (TransferError_TxTooOld
                      ({
                          Mini_ledger.TransferError.TxTooOld.f_allowed_window_nanos
                          =
                          cast (Core.Time.as_nanos_under_impl_1 (Mini_ledger.LedgerData.transaction_window
                                    ledger
                                  <:
                                  Core.Time.t_Duration)
                              <:
                              u128)
                        })))
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist164)
            else Core.Ops.Control_flow.ControlFlow_Continue ()
          in
          let* _:Prims.unit =
            if
              created_at_time >.
              (now +. v_PERMITTED_DRIFT <: Mini_ledger_core.Timestamp.t_TimeStamp)
            then
              let* hoist165:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (ledger,
                    Core.Result.Result_Err
                    (TransferError_TxCreatedInFuture
                      ({ Mini_ledger.TransferError.TxCreatedInFuture.f_ledger_time = now })))
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist165)
            else Core.Ops.Control_flow.ControlFlow_Continue ()
          in
          (match
              Alloc.Collections.Btree.Map.get_under_impl_20 (Mini_ledger.LedgerData.transactions_by_hash
                    ledger
                  <:
                  Alloc.Collections.Btree.Map.t_BTreeMap (Mini_ledger_core.Block.t_HashOf _)
                    u64
                    Alloc.Alloc.t_Global)
                tx_hash
            with
            | Core.Option.Option_Some block_height ->
              let* hoist166:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (ledger,
                    Core.Result.Result_Err
                    (TransferError_TxDuplicate
                      ({ Mini_ledger.TransferError.TxDuplicate.f_duplicate_of = block_height })))
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist166)
            | _ -> Core.Ops.Control_flow.ControlFlow_Continue ())
        | _ -> Core.Ops.Control_flow.ControlFlow_Continue ()
      in
      let tmp0, out:(l & Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
        Mini_ledger.LedgerTransaction.apply transaction ledger
      in
      let ledger:l = tmp0 in
      let hoist168:(l & Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
        out
      in
      let hoist169:Core.Result.t_Result Prims.unit t_TransferError =
        Core.Result.map_err_under_impl hoist168
          (function
            | Mini_ledger_core.Balances.BalanceError_InsufficientFunds
              { Mini_ledger_core.Balances.BalanceError.InsufficientFunds.f_balance = balance } ->
              TransferError_InsufficientFunds
              ({ Mini_ledger.TransferError.InsufficientFunds.f_balance = balance }))
      in
      let hoist170:Core.Ops.Control_flow.t_ControlFlow _ _ =
        Core.Ops.Try_trait.Try.branch hoist169
      in
      let* _:Prims.unit =
        match hoist170 with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist167:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (ledger,
                (Core.Ops.Try_trait.FromResidual.from_residual residual
                  <:
                  Core.Result.t_Result
                    (u64 & Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock)
                    t_TransferError))
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist167)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      Core.Ops.Control_flow.ControlFlow_Continue
      (let block =
          Mini_ledger_core.Block.BlockType.from_transaction (Mini_ledger.LedgerData.blockchain ledger

              <:
              t_Blockchain)
              .Mini_ledger.Blockchain.f_last_hash
            transaction
            now
        in
        let block_timestamp:Mini_ledger_core.Timestamp.t_TimeStamp =
          Mini_ledger_core.Block.BlockType.timestamp block
        in
        let tmp0, out:(l & Core.Result.t_Result u64 Alloc.String.t_String) =
          Mini_ledger.LedgerData.blockchain_add_block ledger block
        in
        let ledger:l = tmp0 in
        let hoist171:(l & Core.Result.t_Result u64 Alloc.String.t_String) = out in
        let height:u64 = Core.Result.expect_under_impl hoist171 "failed to add block" in
        let ledger:l =
          match maybe_time_and_hash with
          | Core.Option.Option_Some (_, tx_hash) ->
            let tmp0, out:(l & Core.Option.t_Option u64) =
              Mini_ledger.LedgerData.insert_transactions_by_hash ledger tx_hash height
            in
            let ledger:l = tmp0 in
            let _:(l & Core.Option.t_Option u64) = out in
            let ledger:l =
              Mini_ledger.LedgerData.push_back_transactions_by_height ledger
                ({
                    Mini_ledger.Transaction.TransactionInfo.f_block_timestamp = block_timestamp;
                    Mini_ledger.Transaction.TransactionInfo.f_transaction_hash = tx_hash
                  })
            in
            ledger
          | _ -> ledger
        in
        let to_trim:Alloc.Vec.t_Vec (Mini_ledger_core.Tokens.t_Tokens & _) Alloc.Alloc.t_Global =
          if
            (Std.Collections.Hash.Map.len_under_impl_1 (Mini_ledger.LedgerData.balances ledger
                  <:
                  Mini_ledger_core.Balances.t_Balances _
                    (Std.Collections.Hash.Map.t_HashMap _
                        Mini_ledger_core.Tokens.t_Tokens
                        Std.Collections.Hash.Map.t_RandomState))
                  .Mini_ledger_core.Balances.Balances.f_store
              <:
              usize) >=.
            ((Mini_ledger.LedgerData.max_number_of_accounts ledger <: usize) +.
              (Mini_ledger.LedgerData.accounts_overflow_trim_quantity ledger <: usize)
              <:
              usize)
          then select_accounts_to_trim ledger
          else Alloc.Vec.new_under_impl
        in
        let ledger:l =
          Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter to_trim

              <:
              _)
            ledger
            (fun ledger (balance, account) ->
                let burn_tx =
                  Mini_ledger.LedgerTransaction.burn account
                    balance
                    (Core.Option.Option_Some now)
                    (Core.Option.Option_Some Mini_ledger.Transaction.v_TRIMMED_MEMO)
                in
                let tmp0, out:(l &
                  Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
                  Mini_ledger.LedgerTransaction.apply burn_tx ledger
                in
                let ledger:l = tmp0 in
                let hoist172:(l &
                  Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
                  out
                in
                let _:Prims.unit =
                  Core.Result.expect_under_impl hoist172
                    "failed to burn funds that must have existed"
                in
                let parent_hash:Core.Option.t_Option
                (Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock) =
                  (Mini_ledger.LedgerData.blockchain ledger).Mini_ledger.Blockchain.f_last_hash
                in
                let tmp0, out:(l & Core.Result.t_Result u64 Alloc.String.t_String) =
                  Mini_ledger.LedgerData.blockchain_add_block ledger
                    (Mini_ledger_core.Block.BlockType.from_transaction parent_hash burn_tx now <: _)
                in
                let ledger:l = tmp0 in
                let hoist173:(l & Core.Result.t_Result u64 Alloc.String.t_String) = out in
                let _:u64 = Core.Result.unwrap_under_impl hoist173 in
                ledger)
        in
        let output:Core.Result.t_Result
          (u64 & Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock)
          t_TransferError =
          Core.Result.Result_Ok
          (height,
            Core.Option.unwrap_under_impl (Mini_ledger.LedgerData.blockchain ledger <: t_Blockchain)
                .Mini_ledger.Blockchain.f_last_hash)
        in
        ledger, output))

let mint_under_impl_3
      (to: Mini_ledger.Account.t_Account)
      (amount: Mini_ledger_core.Tokens.t_Tokens)
      (created_at_time: Core.Option.t_Option Mini_ledger_core.Timestamp.t_TimeStamp)
      (memo: Core.Option.t_Option Mini_ledger.Transaction.t_Memo)
    : Mini_ledger.Transaction.t_Transaction =
  {
    Mini_ledger.Transaction.Transaction.f_operation
    =
    Mini_ledger.Transaction.Operation_Mint
    ({
        Mini_ledger.Transaction.Operation.Mint.f_to = to;
        Mini_ledger.Transaction.Operation.Mint.f_amount
        =
        Mini_ledger_core.Tokens.get_e8s_under_impl amount
      });
    Mini_ledger.Transaction.Transaction.f_created_at_time
    =
    Core.Option.map_under_impl created_at_time
      (fun t -> Mini_ledger_core.Timestamp.as_nanos_since_unix_epoch_under_impl t <: u64);
    Mini_ledger.Transaction.Transaction.f_memo = memo
  }

let transfer_under_impl_3
      (from to: Mini_ledger.Account.t_Account)
      (amount fee: Mini_ledger_core.Tokens.t_Tokens)
      (created_at_time: Core.Option.t_Option Mini_ledger_core.Timestamp.t_TimeStamp)
      (memo: Core.Option.t_Option Mini_ledger.Transaction.t_Memo)
    : Mini_ledger.Transaction.t_Transaction =
  {
    Mini_ledger.Transaction.Transaction.f_operation
    =
    Mini_ledger.Transaction.Operation_Transfer
    ({
        Mini_ledger.Transaction.Operation.Transfer.f_from = from;
        Mini_ledger.Transaction.Operation.Transfer.f_to = to;
        Mini_ledger.Transaction.Operation.Transfer.f_amount
        =
        Mini_ledger_core.Tokens.get_e8s_under_impl amount;
        Mini_ledger.Transaction.Operation.Transfer.f_fee
        =
        Mini_ledger_core.Tokens.get_e8s_under_impl fee
      });
    Mini_ledger.Transaction.Transaction.f_created_at_time
    =
    Core.Option.map_under_impl created_at_time
      (fun t -> Mini_ledger_core.Timestamp.as_nanos_since_unix_epoch_under_impl t <: u64);
    Mini_ledger.Transaction.Transaction.f_memo = memo
  }

type t_Block = {
  f_parent_hash:Core.Option.t_Option
  (Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock);
  f_transaction:Mini_ledger.Transaction.t_Transaction;
  f_timestamp:u64
}

let v___4: Prims.unit = ()

let v___5: Prims.unit = ()

let t_TaggedBlock = Ciborium.Tag.t_Required t_Block 55799uL

let impl: Mini_ledger_core.Block.t_BlockType t_Block =
  {
    transaction = Mini_ledger.Transaction.t_Transaction;
    encode
    =
    (fun (self: t_Block) ->
        let bytes:Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global = Alloc.Vec.new_under_impl in
        let (value: Ciborium.Tag.t_Required t_Block 55799uL):Ciborium.Tag.t_Required t_Block 55799uL
        =
          Ciborium.Tag.Required self
        in
        let tmp0, out:(Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global &
          Core.Result.t_Result Prims.unit (Ciborium.Ser.Error.t_Error _)) =
          Ciborium.Ser.into_writer value bytes
        in
        let bytes:Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global = tmp0 in
        let hoist174:(Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global &
          Core.Result.t_Result Prims.unit (Ciborium.Ser.Error.t_Error _)) =
          out
        in
        let _:Prims.unit = Core.Result.expect_under_impl hoist174 "bug: failed to encode a block" in
        Mini_ledger_core.Block.from_vec_under_impl_8 bytes);
    decode
    =
    (fun (encoded_block: Mini_ledger_core.Block.t_EncodedBlock) ->
        Rust_primitives.Hax.Control_flow_monad.Mexception.run (let bytes:Alloc.Vec.t_Vec u8
              Alloc.Alloc.t_Global =
              Mini_ledger_core.Block.into_vec_under_impl_8 encoded_block
            in
            let* (tagged_block: Ciborium.Tag.t_Required t_Block 55799uL):Ciborium.Tag.t_Required
              t_Block 55799uL =
              match
                Core.Ops.Try_trait.Try.branch (Core.Result.map_err_under_impl (Ciborium.De.from_reader
                          (bytes.[ Core.Ops.Range.RangeFull ] <: slice u8)
                        <:
                        Core.Result.t_Result (Ciborium.Tag.t_Required t_Block 55799uL)
                          (Ciborium.De.Error.t_Error _))
                      (fun e ->
                          Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let
                                      list =
                                        ["failed to decode a block: "]
                                      in
                                      FStar.Pervasives.assert_norm
                                      (Prims.eq2 (List.Tot.length list) 1);
                                      Rust_primitives.Hax.array_of_list list)
                                  <:
                                  slice string)
                                (Rust_primitives.unsize (let list =
                                        [
                                          Core.Fmt.Rt.new_display_under_impl_1 e
                                          <:
                                          Core.Fmt.Rt.t_Argument
                                        ]
                                      in
                                      FStar.Pervasives.assert_norm
                                      (Prims.eq2 (List.Tot.length list) 1);
                                      Rust_primitives.Hax.array_of_list list)
                                  <:
                                  slice Core.Fmt.Rt.t_Argument)
                              <:
                              Core.Fmt.t_Arguments)
                          <:
                          Alloc.String.t_String)
                    <:
                    Core.Result.t_Result (Ciborium.Tag.t_Required t_Block 55799uL)
                      Alloc.String.t_String)
              with
              | Core.Ops.Control_flow.ControlFlow_Break residual ->
                let* hoist175:Rust_primitives.Hax.t_Never =
                  Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                        residual
                      <:
                      Core.Result.t_Result t_Block Alloc.String.t_String)
                in
                Core.Ops.Control_flow.ControlFlow_Continue
                (Rust_primitives.Hax.never_to_any hoist175)
              | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                Core.Ops.Control_flow.ControlFlow_Continue v_val
            in
            Core.Ops.Control_flow.ControlFlow_Continue
            (Core.Result.Result_Ok tagged_block.Ciborium.Tag.Required.0)));
    block_hash
    =
    (fun (encoded_block: Mini_ledger_core.Block.t_EncodedBlock) ->
        Core.Result.unwrap_or_else_under_impl (Core.Result.map_under_impl (Mini_ledger.Hash.hash_cbor
                  (Mini_ledger_core.Block.as_slice_under_impl_8 encoded_block <: slice u8)
                <:
                Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
              Mini_ledger_core.Block.new_under_impl_2
            <:
            Core.Result.t_Result
              (Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock)
              Alloc.String.t_String)
          (fun err ->
              Rust_primitives.Hax.never_to_any (Core.Panicking.panic_fmt (Core.Fmt.new_v1_under_impl_2
                        (Rust_primitives.unsize (let list =
                                ["bug: encoded block "; " is not hashable cbor: "]
                              in
                              FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                              Rust_primitives.Hax.array_of_list list)
                          <:
                          slice string)
                        (Rust_primitives.unsize (let list =
                                [
                                  Core.Fmt.Rt.new_display_under_impl_1 (Hex.encode (Mini_ledger_core.Block.as_slice_under_impl_8
                                            encoded_block
                                          <:
                                          slice u8)
                                      <:
                                      Alloc.String.t_String)
                                  <:
                                  Core.Fmt.Rt.t_Argument;
                                  Core.Fmt.Rt.new_display_under_impl_1 err <: Core.Fmt.Rt.t_Argument
                                ]
                              in
                              FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                              Rust_primitives.Hax.array_of_list list)
                          <:
                          slice Core.Fmt.Rt.t_Argument)
                      <:
                      Core.Fmt.t_Arguments)
                  <:
                  Rust_primitives.Hax.t_Never)
              <:
              Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock));
    parent_hash = (fun (self: t_Block) -> self.Mini_ledger.Block.f_parent_hash);
    timestamp
    =
    (fun (self: t_Block) ->
        Mini_ledger_core.Timestamp.from_nanos_since_unix_epoch_under_impl self
            .Mini_ledger.Block.f_timestamp);
    from_transaction
    =
    fun
      (parent_hash:
        Core.Option.t_Option (Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock)
      )
      (transaction: Mini_ledger.Transaction.t_Transaction)
      (timestamp: Mini_ledger_core.Timestamp.t_TimeStamp)
      ->
      {
        Mini_ledger.Block.f_parent_hash = parent_hash;
        Mini_ledger.Block.f_transaction = transaction;
        Mini_ledger.Block.f_timestamp
        =
        Mini_ledger_core.Timestamp.as_nanos_since_unix_epoch_under_impl timestamp
      }
  }

let t_LedgerBalances =
  Mini_ledger_core.Balances.t_Balances Mini_ledger.Account.t_Account
    (Std.Collections.Hash.Map.t_HashMap Mini_ledger.Account.t_Account
        Mini_ledger_core.Tokens.t_Tokens
        Std.Collections.Hash.Map.t_RandomState)

let v_TRANSACTION_WINDOW: Core.Time.t_Duration =
  Core.Time.from_secs_under_impl_1 ((24uL *. 60uL <: u64) *. 60uL <: u64)

let v_MAX_ACCOUNTS: usize = 28000000sz

let v_ACCOUNTS_OVERFLOW_TRIM_QUANTITY: usize = 100000sz

let v_MAX_TRANSACTIONS_IN_WINDOW: usize = 3000000sz

let v_MAX_TRANSACTIONS_TO_PURGE: usize = 100000sz

type t_InitArgs = {
  f_minting_account:Mini_ledger.Account.t_Account;
  f_initial_balances:Alloc.Vec.t_Vec (Mini_ledger.Account.t_Account & u64) Alloc.Alloc.t_Global;
  f_transfer_fee:u64;
  f_token_name:Alloc.String.t_String;
  f_token_symbol:Alloc.String.t_String
}

let v___6: Prims.unit = ()

let impl: Candid.Types.t_CandidType t_InitArgs =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Type_Record
        (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                  <:
                  Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 5sz) Alloc.Alloc.t_Global)
              <:
              Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_InitArgs) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist176:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist176)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.InitArgs.f_token_symbol
          in
          let ser = tmp0 in
          let hoist178:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist179:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist178
          in
          let* _:Prims.unit =
            match hoist179 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist177:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist177)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.InitArgs.f_transfer_fee
          in
          let ser = tmp0 in
          let hoist181:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist182:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist181
          in
          let* _:Prims.unit =
            match hoist182 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist180:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist180)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.InitArgs.f_minting_account
          in
          let ser = tmp0 in
          let hoist184:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist185:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist184
          in
          let* _:Prims.unit =
            match hoist185 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist183:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist183)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.InitArgs.f_initial_balances
          in
          let ser = tmp0 in
          let hoist187:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist188:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist187
          in
          let* _:Prims.unit =
            match hoist188 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist186:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist186)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.InitArgs.f_token_name
          in
          let ser = tmp0 in
          let hoist190:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist191:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist190
          in
          let* _:Prims.unit =
            match hoist191 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist189:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist189)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

type t_Ledger = {
  f_balances:Mini_ledger_core.Balances.t_Balances Mini_ledger.Account.t_Account
    (Std.Collections.Hash.Map.t_HashMap Mini_ledger.Account.t_Account
        Mini_ledger_core.Tokens.t_Tokens
        Std.Collections.Hash.Map.t_RandomState);
  f_blockchain:t_Blockchain;
  f_minting_account:Mini_ledger.Account.t_Account;
  f_transactions_by_hash:Alloc.Collections.Btree.Map.t_BTreeMap
    (Mini_ledger_core.Block.t_HashOf Mini_ledger.Transaction.t_Transaction) u64 Alloc.Alloc.t_Global;
  f_transactions_by_height:Alloc.Collections.Vec_deque.t_VecDeque
    (Mini_ledger.Transaction.t_TransactionInfo Mini_ledger.Transaction.t_Transaction)
    Alloc.Alloc.t_Global;
  f_transfer_fee:Mini_ledger_core.Tokens.t_Tokens;
  f_token_symbol:Alloc.String.t_String;
  f_token_name:Alloc.String.t_String
}

let v___7: Prims.unit = ()

let v___8: Prims.unit = ()

let from_init_args_under_impl_5
      ({ Mini_ledger.InitArgs.f_minting_account = minting_account ;
            Mini_ledger.InitArgs.f_initial_balances = initial_balances ;
            Mini_ledger.InitArgs.f_transfer_fee = transfer_fee ;
            Mini_ledger.InitArgs.f_token_name = token_name ;
            Mini_ledger.InitArgs.f_token_symbol = token_symbol }:
          t_InitArgs)
      (now: Mini_ledger_core.Timestamp.t_TimeStamp)
    : t_Ledger =
  let ledger:t_Ledger =
    {
      Mini_ledger.Ledger.f_balances = Core.Default.Default.v_default;
      Mini_ledger.Ledger.f_transactions_by_hash = Alloc.Collections.Btree.Map.new_under_impl_18;
      Mini_ledger.Ledger.f_transactions_by_height = Alloc.Collections.Vec_deque.new_under_impl_4;
      Mini_ledger.Ledger.f_blockchain = Core.Default.Default.v_default;
      Mini_ledger.Ledger.f_minting_account = minting_account;
      Mini_ledger.Ledger.f_transfer_fee = Mini_ledger_core.Tokens.from_e8s_under_impl transfer_fee;
      Mini_ledger.Ledger.f_token_symbol = token_symbol;
      Mini_ledger.Ledger.f_token_name = token_name
    }
  in
  let ledger:t_Ledger =
    Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter (Core.Iter.Traits.Collect.IntoIterator.into_iter
              initial_balances
            <:
            _)
        <:
        _)
      ledger
      (fun ledger (account, balance) ->
          let tmp0, out:(t_Ledger &
            Core.Result.t_Result
              (u64 & Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock)
              t_TransferError) =
            apply_transaction ledger
              (mint_under_impl_3 (Core.Clone.Clone.clone account <: Mini_ledger.Account.t_Account)
                  (Mini_ledger_core.Tokens.from_e8s_under_impl balance
                    <:
                    Mini_ledger_core.Tokens.t_Tokens)
                  (Core.Option.Option_Some now)
                  Core.Option.Option_None
                <:
                Mini_ledger.Transaction.t_Transaction)
              now
          in
          let ledger:t_Ledger = tmp0 in
          let hoist192:(t_Ledger &
            Core.Result.t_Result
              (u64 & Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock)
              t_TransferError) =
            out
          in
          let _:(u64 & Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock) =
            Core.Result.unwrap_or_else_under_impl hoist192
              (fun err ->
                  Rust_primitives.Hax.never_to_any (Core.Panicking.panic_fmt (Core.Fmt.new_v1_under_impl_2
                            (Rust_primitives.unsize (let list =
                                    ["failed to mint "; " e8s to "; ": "]
                                  in
                                  FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 3);
                                  Rust_primitives.Hax.array_of_list list)
                              <:
                              slice string)
                            (Rust_primitives.unsize (let list =
                                    [
                                      Core.Fmt.Rt.new_display_under_impl_1 balance
                                      <:
                                      Core.Fmt.Rt.t_Argument;
                                      Core.Fmt.Rt.new_display_under_impl_1 account
                                      <:
                                      Core.Fmt.Rt.t_Argument;
                                      Core.Fmt.Rt.new_debug_under_impl_1 err
                                      <:
                                      Core.Fmt.Rt.t_Argument
                                    ]
                                  in
                                  FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 3);
                                  Rust_primitives.Hax.array_of_list list)
                              <:
                              slice Core.Fmt.Rt.t_Argument)
                          <:
                          Core.Fmt.t_Arguments)
                      <:
                      Rust_primitives.Hax.t_Never)
                  <:
                  (u64 & Mini_ledger_core.Block.t_HashOf Mini_ledger_core.Block.t_EncodedBlock))
          in
          ledger)
  in
  ledger

let impl: t_LedgerData t_Ledger =
  {
    accountId = Mini_ledger.Account.t_Account;
    transaction = Mini_ledger.Transaction.t_Transaction;
    block = t_Block;
    transaction_window = (fun (self: t_Ledger) -> v_TRANSACTION_WINDOW);
    max_transactions_in_window = (fun (self: t_Ledger) -> v_MAX_TRANSACTIONS_IN_WINDOW);
    max_transactions_to_purge = (fun (self: t_Ledger) -> v_MAX_TRANSACTIONS_TO_PURGE);
    max_number_of_accounts = (fun (self: t_Ledger) -> v_MAX_ACCOUNTS);
    accounts_overflow_trim_quantity = (fun (self: t_Ledger) -> v_ACCOUNTS_OVERFLOW_TRIM_QUANTITY);
    token_name
    =
    (fun (self: t_Ledger) -> Core.Ops.Deref.Deref.deref self.Mini_ledger.Ledger.f_token_name);
    token_symbol
    =
    (fun (self: t_Ledger) -> Core.Ops.Deref.Deref.deref self.Mini_ledger.Ledger.f_token_symbol);
    balances = (fun (self: t_Ledger) -> self.Mini_ledger.Ledger.f_balances);
    transfer_balance
    =
    (fun
        (self: t_Ledger)
        (from: Mini_ledger.Account.t_Account)
        (to: Mini_ledger.Account.t_Account)
        (amount: Mini_ledger_core.Tokens.t_Tokens)
        (fee: Mini_ledger_core.Tokens.t_Tokens)
        ->
        let tmp0, out:(Mini_ledger_core.Balances.t_Balances Mini_ledger.Account.t_Account
            (Std.Collections.Hash.Map.t_HashMap Mini_ledger.Account.t_Account
                Mini_ledger_core.Tokens.t_Tokens
                Std.Collections.Hash.Map.t_RandomState) &
          Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
          Mini_ledger_core.Balances.transfer_under_impl_2 self.Mini_ledger.Ledger.f_balances
            from
            to
            amount
            fee
        in
        let self:t_Ledger = { self with Mini_ledger.Ledger.f_balances = tmp0 } in
        let output:(Mini_ledger_core.Balances.t_Balances Mini_ledger.Account.t_Account
            (Std.Collections.Hash.Map.t_HashMap Mini_ledger.Account.t_Account
                Mini_ledger_core.Tokens.t_Tokens
                Std.Collections.Hash.Map.t_RandomState) &
          Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
          out
        in
        self, output);
    mint_balance
    =
    (fun
        (self: t_Ledger)
        (to: Mini_ledger.Account.t_Account)
        (amount: Mini_ledger_core.Tokens.t_Tokens)
        ->
        let tmp0, out:(Mini_ledger_core.Balances.t_Balances Mini_ledger.Account.t_Account
            (Std.Collections.Hash.Map.t_HashMap Mini_ledger.Account.t_Account
                Mini_ledger_core.Tokens.t_Tokens
                Std.Collections.Hash.Map.t_RandomState) &
          Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
          Mini_ledger_core.Balances.mint_under_impl_2 self.Mini_ledger.Ledger.f_balances to amount
        in
        let self:t_Ledger = { self with Mini_ledger.Ledger.f_balances = tmp0 } in
        let output:(Mini_ledger_core.Balances.t_Balances Mini_ledger.Account.t_Account
            (Std.Collections.Hash.Map.t_HashMap Mini_ledger.Account.t_Account
                Mini_ledger_core.Tokens.t_Tokens
                Std.Collections.Hash.Map.t_RandomState) &
          Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
          out
        in
        self, output);
    burn_balance
    =
    (fun
        (self: t_Ledger)
        (from: Mini_ledger.Account.t_Account)
        (amount: Mini_ledger_core.Tokens.t_Tokens)
        ->
        let tmp0, out:(Mini_ledger_core.Balances.t_Balances Mini_ledger.Account.t_Account
            (Std.Collections.Hash.Map.t_HashMap Mini_ledger.Account.t_Account
                Mini_ledger_core.Tokens.t_Tokens
                Std.Collections.Hash.Map.t_RandomState) &
          Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
          Mini_ledger_core.Balances.burn_under_impl_2 self.Mini_ledger.Ledger.f_balances from amount
        in
        let self:t_Ledger = { self with Mini_ledger.Ledger.f_balances = tmp0 } in
        let output:(Mini_ledger_core.Balances.t_Balances Mini_ledger.Account.t_Account
            (Std.Collections.Hash.Map.t_HashMap Mini_ledger.Account.t_Account
                Mini_ledger_core.Tokens.t_Tokens
                Std.Collections.Hash.Map.t_RandomState) &
          Core.Result.t_Result Prims.unit Mini_ledger_core.Balances.t_BalanceError) =
          out
        in
        self, output);
    blockchain = (fun (self: t_Ledger) -> self.Mini_ledger.Ledger.f_blockchain);
    blockchain_add_block
    =
    (fun (self: t_Ledger) (block: t_Block) ->
        let tmp0, out:(t_Blockchain & Core.Result.t_Result u64 Alloc.String.t_String) =
          add_block_under_impl_2 self.Mini_ledger.Ledger.f_blockchain block
        in
        let self:t_Ledger = { self with Mini_ledger.Ledger.f_blockchain = tmp0 } in
        let output:(t_Blockchain & Core.Result.t_Result u64 Alloc.String.t_String) = out in
        self, output);
    transactions_by_hash = (fun (self: t_Ledger) -> self.Mini_ledger.Ledger.f_transactions_by_hash);
    remove_transactions_by_hash
    =
    (fun
        (self: t_Ledger)
        (key: Mini_ledger_core.Block.t_HashOf Mini_ledger.Transaction.t_Transaction)
        ->
        let tmp0, out:(Alloc.Collections.Btree.Map.t_BTreeMap
            (Mini_ledger_core.Block.t_HashOf Mini_ledger.Transaction.t_Transaction)
            u64
            Alloc.Alloc.t_Global &
          Core.Option.t_Option u64) =
          Alloc.Collections.Btree.Map.remove_under_impl_20 self
              .Mini_ledger.Ledger.f_transactions_by_hash
            key
        in
        let self:t_Ledger = { self with Mini_ledger.Ledger.f_transactions_by_hash = tmp0 } in
        let output:(Alloc.Collections.Btree.Map.t_BTreeMap
            (Mini_ledger_core.Block.t_HashOf Mini_ledger.Transaction.t_Transaction)
            u64
            Alloc.Alloc.t_Global &
          Core.Option.t_Option u64) =
          out
        in
        self, output);
    insert_transactions_by_hash
    =
    (fun
        (self: t_Ledger)
        (key: Mini_ledger_core.Block.t_HashOf Mini_ledger.Transaction.t_Transaction)
        (value: u64)
        ->
        let tmp0, out:(Alloc.Collections.Btree.Map.t_BTreeMap
            (Mini_ledger_core.Block.t_HashOf Mini_ledger.Transaction.t_Transaction)
            u64
            Alloc.Alloc.t_Global &
          Core.Option.t_Option u64) =
          Alloc.Collections.Btree.Map.insert_under_impl_20 self
              .Mini_ledger.Ledger.f_transactions_by_hash
            key
            value
        in
        let self:t_Ledger = { self with Mini_ledger.Ledger.f_transactions_by_hash = tmp0 } in
        let output:(Alloc.Collections.Btree.Map.t_BTreeMap
            (Mini_ledger_core.Block.t_HashOf Mini_ledger.Transaction.t_Transaction)
            u64
            Alloc.Alloc.t_Global &
          Core.Option.t_Option u64) =
          out
        in
        self, output);
    transactions_by_height
    =
    (fun (self: t_Ledger) -> self.Mini_ledger.Ledger.f_transactions_by_height);
    pop_front_transactions_by_height
    =
    (fun (self: t_Ledger) ->
        let tmp0, out:(Alloc.Collections.Vec_deque.t_VecDeque
            (Mini_ledger.Transaction.t_TransactionInfo Mini_ledger.Transaction.t_Transaction)
            Alloc.Alloc.t_Global &
          Core.Option.t_Option
          (Mini_ledger.Transaction.t_TransactionInfo Mini_ledger.Transaction.t_Transaction)) =
          Alloc.Collections.Vec_deque.pop_front_under_impl_5 self
              .Mini_ledger.Ledger.f_transactions_by_height
        in
        let self:t_Ledger = { self with Mini_ledger.Ledger.f_transactions_by_height = tmp0 } in
        let _:(Alloc.Collections.Vec_deque.t_VecDeque
            (Mini_ledger.Transaction.t_TransactionInfo Mini_ledger.Transaction.t_Transaction)
            Alloc.Alloc.t_Global &
          Core.Option.t_Option
          (Mini_ledger.Transaction.t_TransactionInfo Mini_ledger.Transaction.t_Transaction)) =
          out
        in
        self);
    push_back_transactions_by_height
    =
    (fun
        (self: t_Ledger)
        (value: Mini_ledger.Transaction.t_TransactionInfo Mini_ledger.Transaction.t_Transaction)
        ->
        let self:t_Ledger =
          {
            self with
            Mini_ledger.Ledger.f_transactions_by_height
            =
            Alloc.Collections.Vec_deque.push_back_under_impl_5 self
                .Mini_ledger.Ledger.f_transactions_by_height
              value
          }
        in
        self);
    on_purged_transaction = fun (self: t_Ledger) (v__height: u64) -> self
  }

let minting_account_under_impl_7 (self: t_Ledger) : Mini_ledger.Account.t_Account =
  self.Mini_ledger.Ledger.f_minting_account

let transfer_fee_under_impl_7 (self: t_Ledger) : Mini_ledger_core.Tokens.t_Tokens =
  self.Mini_ledger.Ledger.f_transfer_fee

let get_transactions_under_impl_7 (self: t_Ledger) (start: u64) (length: usize)
    : Mini_ledger.Endpoints.t_GetTransactionsResponse =
  let (local_transactions: Alloc.Vec.t_Vec Mini_ledger.Endpoints.t_Transaction Alloc.Alloc.t_Global):Alloc.Vec.t_Vec
    Mini_ledger.Endpoints.t_Transaction Alloc.Alloc.t_Global =
    Core.Iter.Traits.Iterator.Iterator.collect (Core.Iter.Traits.Iterator.Iterator.map (Core.Slice.iter_under_impl
              (block_slice_under_impl_2 self.Mini_ledger.Ledger.f_blockchain
                  ({
                      Core.Ops.Range.Range.f_start = start;
                      Core.Ops.Range.Range.f_end = start +. cast length <: u64
                    })
                <:
                slice Mini_ledger_core.Block.t_EncodedBlock)
            <:
            Core.Slice.Iter.t_Iter Mini_ledger_core.Block.t_EncodedBlock)
          (fun enc_block ->
              Core.Convert.Into.into (Core.Result.expect_under_impl (Mini_ledger_core.Block.BlockType.decode
                        (Core.Clone.Clone.clone enc_block <: Mini_ledger_core.Block.t_EncodedBlock)
                      <:
                      Core.Result.t_Result t_Block Alloc.String.t_String)
                    "bug: failed to decode encoded block"
                  <:
                  t_Block)
              <:
              Mini_ledger.Endpoints.t_Transaction)
        <:
        Core.Iter.Adapters.Map.t_Map (Core.Slice.Iter.t_Iter Mini_ledger_core.Block.t_EncodedBlock)
          (Mini_ledger_core.Block.t_EncodedBlock -> Mini_ledger.Endpoints.t_Transaction))
  in
  {
    Mini_ledger.Endpoints.GetTransactionsResponse.f_first_index = Core.Convert.From.from start;
    Mini_ledger.Endpoints.GetTransactionsResponse.f_log_length
    =
    Core.Convert.From.from (chain_length_under_impl_2 self.Mini_ledger.Ledger.f_blockchain <: u64);
    Mini_ledger.Endpoints.GetTransactionsResponse.f_transactions = local_transactions
  }