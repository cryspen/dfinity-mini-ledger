module Mini_ledger.Transaction
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

let v_MAX_MEMO_LENGTH: usize = 32sz

let v_TRIMMED_MEMO: u64 = Core.Num.v_MAX_under_impl_9

type t_TransactionInfo = {
  f_block_timestamp:Mini_ledger_core.Timestamp.t_TimeStamp;
  f_transaction_hash:Mini_ledger_core.Block.t_HashOf transactiontype
}

let v___: Prims.unit = ()

let v___1: Prims.unit = ()

let ser_compact_account
      (#s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Serde.Ser.t_Serializer s)
      (acc: Mini_ledger.Account.t_Account)
      (s: s)
    : Core.Result.t_Result _ _ =
  Serde.Ser.Serialize.serialize (Core.Convert.From.from (Core.Clone.Clone.clone acc
          <:
          Mini_ledger.Account.t_Account)
      <:
      t_CompactAccount)
    s

let de_compact_account
      (#d: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized d)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Serde.De.t_Deserializer d)
      (d: d)
    : Core.Result.t_Result Mini_ledger.Account.t_Account _ =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* compact_account:t_CompactAccount =
        match
          Core.Ops.Try_trait.Try.branch (Serde.De.Deserialize.deserialize d
              <:
              Core.Result.t_Result t_CompactAccount _)
        with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist145:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                  residual
                <:
                Core.Result.t_Result Mini_ledger.Account.t_Account _)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist145)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      Core.Ops.Control_flow.ControlFlow_Continue
      (Core.Result.map_err_under_impl (Core.Convert.TryFrom.try_from compact_account
            <:
            Core.Result.t_Result Mini_ledger.Account.t_Account _)
          Serde.De.Error.custom))

type t_CompactAccount =
  | CompactAccount : Alloc.Vec.t_Vec Serde_bytes.Bytebuf.t_ByteBuf Alloc.Alloc.t_Global
    -> t_CompactAccount

let v___2: Prims.unit = ()

let v___3: Prims.unit = ()

let impl: Core.Convert.t_From t_CompactAccount Mini_ledger.Account.t_Account =
  {
    from
    =
    fun (acc: Mini_ledger.Account.t_Account) ->
      let components:Alloc.Vec.t_Vec Serde_bytes.Bytebuf.t_ByteBuf Alloc.Alloc.t_Global =
        Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                <:
                Alloc.Boxed.t_Box (array Serde_bytes.Bytebuf.t_ByteBuf 1sz) Alloc.Alloc.t_Global)
            <:
            Alloc.Boxed.t_Box (slice Serde_bytes.Bytebuf.t_ByteBuf) Alloc.Alloc.t_Global)
      in
      let components:Alloc.Vec.t_Vec Serde_bytes.Bytebuf.t_ByteBuf Alloc.Alloc.t_Global =
        match acc.Mini_ledger.Account.Account.f_subaccount with
        | Core.Option.Option_Some sub ->
          Alloc.Vec.push_under_impl_1 components
            (Serde_bytes.Bytebuf.from_under_impl (Alloc.Slice.to_vec_under_impl (Rust_primitives.unsize
                        sub
                      <:
                      slice u8)
                  <:
                  Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global)
              <:
              Serde_bytes.Bytebuf.t_ByteBuf)
        | _ -> components
      in
      CompactAccount components
  }

let impl: Core.Convert.t_TryFrom Mini_ledger.Account.t_Account t_CompactAccount =
  {
    error = Alloc.String.t_String;
    try_from
    =
    fun (compact: t_CompactAccount) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let elems:Alloc.Vec.t_Vec
            Serde_bytes.Bytebuf.t_ByteBuf Alloc.Alloc.t_Global =
            compact.Mini_ledger.Transaction.CompactAccount.0
          in
          let* _:Prims.unit =
            if Alloc.Vec.is_empty_under_impl_1 elems
            then
              let* hoist146:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Result.Result_Err
                    (Alloc.String.ToString.to_string "account tuple must have at least one element"
                      <:
                      Alloc.String.t_String))
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist146)
            else Core.Ops.Control_flow.ControlFlow_Continue ()
          in
          let* _:Prims.unit =
            if (Alloc.Vec.len_under_impl_1 elems <: usize) >. 2sz
            then
              let res:Alloc.String.t_String =
                Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list =
                              ["account tuple must have at most two elements, got "]
                            in
                            FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
                            Rust_primitives.Hax.array_of_list list)
                        <:
                        slice string)
                      (Rust_primitives.unsize (let list =
                              [
                                Core.Fmt.Rt.new_display_under_impl_1 (Alloc.Vec.len_under_impl_1 elems

                                    <:
                                    usize)
                                <:
                                Core.Fmt.Rt.t_Argument
                              ]
                            in
                            FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
                            Rust_primitives.Hax.array_of_list list)
                        <:
                        slice Core.Fmt.Rt.t_Argument)
                    <:
                    Core.Fmt.t_Arguments)
              in
              let* hoist147:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Result.Result_Err res)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist147)
            else Core.Ops.Control_flow.ControlFlow_Continue ()
          in
          let* principal:Candid.Types.Principal.t_Principal =
            match
              Core.Ops.Try_trait.Try.branch (Core.Result.map_err_under_impl (Core.Convert.TryFrom.try_from
                        ((Core.Ops.Deref.Deref.deref (elems.[ 0sz ] <: Serde_bytes.Bytebuf.t_ByteBuf
                              )
                            <:
                            Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global).[ Core.Ops.Range.RangeFull ]
                          <:
                          slice u8)
                      <:
                      Core.Result.t_Result Candid.Types.Principal.t_Principal _)
                    (fun e ->
                        Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let
                                    list =
                                      ["invalid principal: "]
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
                  Core.Result.t_Result Candid.Types.Principal.t_Principal Alloc.String.t_String)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist148:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Mini_ledger.Account.t_Account Alloc.String.t_String)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist148)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let* subaccount:Core.Option.t_Option (array u8 32sz) =
            if (Alloc.Vec.len_under_impl_1 elems <: usize) >. 1sz
            then
              let* hoist150:array u8 32sz =
                match
                  Core.Ops.Try_trait.Try.branch (Core.Result.map_err_under_impl (Core.Convert.TryFrom.try_from
                            ((Core.Ops.Deref.Deref.deref (elems.[ 1sz ]
                                    <:
                                    Serde_bytes.Bytebuf.t_ByteBuf)
                                <:
                                Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global).[ Core.Ops.Range.RangeFull
                              ]
                              <:
                              slice u8)
                          <:
                          Core.Result.t_Result (array u8 32sz) _)
                        (fun _ ->
                            Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let
                                        list =
                                          ["invalid subaccount: expected 32 bytes, got "]
                                        in
                                        FStar.Pervasives.assert_norm
                                        (Prims.eq2 (List.Tot.length list) 1);
                                        Rust_primitives.Hax.array_of_list list)
                                    <:
                                    slice string)
                                  (Rust_primitives.unsize (let list =
                                          [
                                            Core.Fmt.Rt.new_display_under_impl_1 (Alloc.Vec.len_under_impl_1
                                                  (Core.Ops.Deref.Deref.deref (elems.[ 1sz ]
                                                        <:
                                                        Serde_bytes.Bytebuf.t_ByteBuf)
                                                    <:
                                                    Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global)
                                                <:
                                                usize)
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
                      Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist149:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Mini_ledger.Account.t_Account Alloc.String.t_String)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist149)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Core.Option.Option_Some hoist150)
            else Core.Ops.Control_flow.ControlFlow_Continue Core.Option.Option_None
          in
          Core.Ops.Control_flow.ControlFlow_Continue
          (Core.Result.Result_Ok
            ({
                Mini_ledger.Account.Account.f_owner = principal;
                Mini_ledger.Account.Account.f_subaccount = subaccount
              })))
  }

type t_Operation =
  | Operation_Mint {
    f_to:Mini_ledger.Account.t_Account;
    f_amount:u64
  }: t_Operation
  | Operation_Transfer {
    f_from:Mini_ledger.Account.t_Account;
    f_to:Mini_ledger.Account.t_Account;
    f_amount:u64;
    f_fee:u64
  }: t_Operation
  | Operation_Burn {
    f_from:Mini_ledger.Account.t_Account;
    f_amount:u64
  }: t_Operation

let v___4: Prims.unit = ()

let v___5: Prims.unit = ()

type t_MemoTooLarge = | MemoTooLarge : usize -> t_MemoTooLarge

let impl: Core.Fmt.t_Display t_MemoTooLarge =
  {
    fmt
    =
    fun (self: t_MemoTooLarge) (f: Core.Fmt.t_Formatter) ->
      let tmp0, out:(Core.Fmt.t_Formatter & Core.Result.t_Result Prims.unit Core.Fmt.t_Error) =
        Core.Fmt.write_fmt_under_impl_7 f
          (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list =
                      ["Memo field is "; " bytes long, max allowed length is "]
                    in
                    FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                    Rust_primitives.Hax.array_of_list list)
                <:
                slice string)
              (Rust_primitives.unsize (let list =
                      [
                        Core.Fmt.Rt.new_display_under_impl_1 self
                            .Mini_ledger.Transaction.MemoTooLarge.0
                        <:
                        Core.Fmt.Rt.t_Argument;
                        Core.Fmt.Rt.new_display_under_impl_1 v_MAX_MEMO_LENGTH
                        <:
                        Core.Fmt.Rt.t_Argument
                      ]
                    in
                    FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                    Rust_primitives.Hax.array_of_list list)
                <:
                slice Core.Fmt.Rt.t_Argument)
            <:
            Core.Fmt.t_Arguments)
      in
      let f:Core.Fmt.t_Formatter = tmp0 in
      let output:(Core.Fmt.t_Formatter & Core.Result.t_Result Prims.unit Core.Fmt.t_Error) = out in
      f, output
  }

type t_Memo = | Memo : Serde_bytes.Bytebuf.t_ByteBuf -> t_Memo

let v___6: Prims.unit = ()

let v___7: Prims.unit = ()

let impl: Candid.Types.t_CandidType t_Memo =
  {
    _ty = (fun  -> Candid.Types.CandidType.ty);
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_Memo) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist151:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist151)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Transaction.Memo.0
          in
          let ser = tmp0 in
          let hoist153:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist154:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist153
          in
          let* _:Prims.unit =
            match hoist154 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist152:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist152)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let deserialize_memo_bytes
      (#d: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized d)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Serde.De.t_Deserializer d)
      (d: d)
    : Core.Result.t_Result Serde_bytes.Bytebuf.t_ByteBuf _ =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* bytes:Serde_bytes.Bytebuf.t_ByteBuf =
        match
          Core.Ops.Try_trait.Try.branch (Serde.De.Deserialize.deserialize d
              <:
              Core.Result.t_Result Serde_bytes.Bytebuf.t_ByteBuf _)
        with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist155:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                  residual
                <:
                Core.Result.t_Result Serde_bytes.Bytebuf.t_ByteBuf _)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist155)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      let* memo:t_Memo =
        match
          Core.Ops.Try_trait.Try.branch (Core.Result.map_err_under_impl (Core.Convert.TryFrom.try_from
                    bytes
                  <:
                  Core.Result.t_Result t_Memo _)
                Serde.De.Error.custom
              <:
              Core.Result.t_Result t_Memo _)
        with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist156:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                  residual
                <:
                Core.Result.t_Result Serde_bytes.Bytebuf.t_ByteBuf _)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist156)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      Core.Ops.Control_flow.ControlFlow_Continue
      (Core.Result.Result_Ok (Core.Convert.Into.into memo)))

let impl: Core.Convert.t_From t_Memo (array u8 32sz) =
  {
    from
    =
    fun (memo: array u8 32sz) ->
      Memo
      (Serde_bytes.Bytebuf.from_under_impl (Alloc.Slice.to_vec_under_impl (Rust_primitives.unsize memo

                <:
                slice u8)
            <:
            Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global))
  }

let impl: Core.Convert.t_From t_Memo u64 =
  {
    from
    =
    fun (num: u64) ->
      Memo
      (Serde_bytes.Bytebuf.from_under_impl (Alloc.Slice.to_vec_under_impl (Rust_primitives.unsize (Core.Num.to_be_bytes_under_impl_9
                      num
                    <:
                    array u8 8sz)
                <:
                slice u8)
            <:
            Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global))
  }

let impl: Core.Convert.t_TryFrom t_Memo Serde_bytes.Bytebuf.t_ByteBuf =
  {
    error = t_MemoTooLarge;
    try_from
    =
    fun (b: Serde_bytes.Bytebuf.t_ByteBuf) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* _:Prims.unit =
            if
              (Alloc.Vec.len_under_impl_1 (Core.Ops.Deref.Deref.deref b
                    <:
                    Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global)
                <:
                usize) >.
              v_MAX_MEMO_LENGTH
            then
              let* hoist157:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Result.Result_Err
                    (MemoTooLarge
                      (Alloc.Vec.len_under_impl_1 (Core.Ops.Deref.Deref.deref b
                            <:
                            Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global)
                        <:
                        usize)))
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist157)
            else Core.Ops.Control_flow.ControlFlow_Continue ()
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok (Memo b)))
  }

let impl: Core.Convert.t_TryFrom t_Memo (Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global) =
  {
    error = t_MemoTooLarge;
    try_from
    =
    fun (v: Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global) ->
      Core.Convert.TryFrom.try_from (Serde_bytes.Bytebuf.from_under_impl v
          <:
          Serde_bytes.Bytebuf.t_ByteBuf)
  }

let impl: Core.Convert.t_From Serde_bytes.Bytebuf.t_ByteBuf t_Memo =
  { from = fun (memo: t_Memo) -> memo.Mini_ledger.Transaction.Memo.0 }

type t_Transaction = {
  f_operation:t_Operation;
  f_created_at_time:Core.Option.t_Option u64;
  f_memo:Core.Option.t_Option t_Memo
}

let v___8: Prims.unit = ()

let v___9: Prims.unit = ()