module Mini_ledger.Endpoints
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

type t_Mint = {
  f_amount:Candid.Types.Number.t_Nat;
  f_to:Mini_ledger.Account.t_Account;
  f_memo:Core.Option.t_Option Mini_ledger.Transaction.t_Memo;
  f_created_at_time:Core.Option.t_Option u64
}

let impl: Candid.Types.t_CandidType t_Mint =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Type_Record
        (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                  <:
                  Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 4sz) Alloc.Alloc.t_Global)
              <:
              Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_Mint) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist8:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist8)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Mint.f_to
          in
          let ser = tmp0 in
          let hoist10:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist11:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist10
          in
          let* _:Prims.unit =
            match hoist11 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist9:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist9)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Mint.f_memo
          in
          let ser = tmp0 in
          let hoist13:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist14:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist13
          in
          let* _:Prims.unit =
            match hoist14 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist12:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist12)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.Mint.f_created_at_time
          in
          let ser = tmp0 in
          let hoist16:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist17:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist16
          in
          let* _:Prims.unit =
            match hoist17 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist15:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist15)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Mint.f_amount
          in
          let ser = tmp0 in
          let hoist19:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist20:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist19
          in
          let* _:Prims.unit =
            match hoist20 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist18:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist18)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___: Prims.unit = ()

type t_Burn = {
  f_amount:Candid.Types.Number.t_Nat;
  f_from:Mini_ledger.Account.t_Account;
  f_memo:Core.Option.t_Option Mini_ledger.Transaction.t_Memo;
  f_created_at_time:Core.Option.t_Option u64
}

let impl: Candid.Types.t_CandidType t_Burn =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Type_Record
        (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                  <:
                  Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 4sz) Alloc.Alloc.t_Global)
              <:
              Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_Burn) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist21:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist21)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Burn.f_from
          in
          let ser = tmp0 in
          let hoist23:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist24:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist23
          in
          let* _:Prims.unit =
            match hoist24 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist22:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist22)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Burn.f_memo
          in
          let ser = tmp0 in
          let hoist26:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist27:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist26
          in
          let* _:Prims.unit =
            match hoist27 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist25:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist25)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.Burn.f_created_at_time
          in
          let ser = tmp0 in
          let hoist29:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist30:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist29
          in
          let* _:Prims.unit =
            match hoist30 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist28:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist28)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Burn.f_amount
          in
          let ser = tmp0 in
          let hoist32:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist33:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist32
          in
          let* _:Prims.unit =
            match hoist33 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist31:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist31)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___1: Prims.unit = ()

type t_Transfer = {
  f_amount:Candid.Types.Number.t_Nat;
  f_from:Mini_ledger.Account.t_Account;
  f_to:Mini_ledger.Account.t_Account;
  f_memo:Core.Option.t_Option Mini_ledger.Transaction.t_Memo;
  f_fee:Core.Option.t_Option Candid.Types.Number.t_Nat;
  f_created_at_time:Core.Option.t_Option u64
}

let impl: Candid.Types.t_CandidType t_Transfer =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Type_Record
        (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                  <:
                  Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 6sz) Alloc.Alloc.t_Global)
              <:
              Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_Transfer) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist34:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist34)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Transfer.f_to
          in
          let ser = tmp0 in
          let hoist36:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist37:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist36
          in
          let* _:Prims.unit =
            match hoist37 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist35:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist35)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Transfer.f_fee
          in
          let ser = tmp0 in
          let hoist39:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist40:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist39
          in
          let* _:Prims.unit =
            match hoist40 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist38:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist38)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Transfer.f_from
          in
          let ser = tmp0 in
          let hoist42:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist43:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist42
          in
          let* _:Prims.unit =
            match hoist43 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist41:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist41)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Transfer.f_memo
          in
          let ser = tmp0 in
          let hoist45:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist46:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist45
          in
          let* _:Prims.unit =
            match hoist46 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist44:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist44)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.Transfer.f_created_at_time
          in
          let ser = tmp0 in
          let hoist48:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist49:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist48
          in
          let* _:Prims.unit =
            match hoist49 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist47:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist47)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.Transfer.f_amount
          in
          let ser = tmp0 in
          let hoist51:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist52:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist51
          in
          let* _:Prims.unit =
            match hoist52 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist50:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist50)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___2: Prims.unit = ()

type t_Transaction = {
  f_kind:Alloc.String.t_String;
  f_mint:Core.Option.t_Option t_Mint;
  f_burn:Core.Option.t_Option t_Burn;
  f_transfer:Core.Option.t_Option t_Transfer;
  f_timestamp:u64
}

let impl: Candid.Types.t_CandidType t_Transaction =
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
    fun (self: t_Transaction) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist53:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist53)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.Transaction.f_burn
          in
          let ser = tmp0 in
          let hoist55:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist56:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist55
          in
          let* _:Prims.unit =
            match hoist56 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist54:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist54)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.Transaction.f_kind
          in
          let ser = tmp0 in
          let hoist58:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist59:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist58
          in
          let* _:Prims.unit =
            match hoist59 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist57:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist57)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.Transaction.f_mint
          in
          let ser = tmp0 in
          let hoist61:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist62:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist61
          in
          let* _:Prims.unit =
            match hoist62 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist60:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist60)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.Transaction.f_timestamp
          in
          let ser = tmp0 in
          let hoist64:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist65:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist64
          in
          let* _:Prims.unit =
            match hoist65 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist63:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist63)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.Transaction.f_transfer
          in
          let ser = tmp0 in
          let hoist67:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist68:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist67
          in
          let* _:Prims.unit =
            match hoist68 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist66:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist66)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___3: Prims.unit = ()

let impl: Core.Convert.t_From t_Transaction Mini_ledger.t_Block =
  {
    from
    =
    fun (b: Mini_ledger.t_Block) ->
      let tx:t_Transaction =
        {
          Mini_ledger.Endpoints.Transaction.f_kind = Alloc.String.ToString.to_string "";
          Mini_ledger.Endpoints.Transaction.f_mint = Core.Option.Option_None;
          Mini_ledger.Endpoints.Transaction.f_burn = Core.Option.Option_None;
          Mini_ledger.Endpoints.Transaction.f_transfer = Core.Option.Option_None;
          Mini_ledger.Endpoints.Transaction.f_timestamp = b.Mini_ledger.Block.f_timestamp
        }
      in
      let created_at_time:Core.Option.t_Option u64 =
        b.Mini_ledger.Block.f_transaction.Mini_ledger.Transaction.Transaction.f_created_at_time
      in
      let memo:Core.Option.t_Option Mini_ledger.Transaction.t_Memo =
        b.Mini_ledger.Block.f_transaction.Mini_ledger.Transaction.Transaction.f_memo
      in
      let tx:t_Transaction =
        match b.Mini_ledger.Block.f_transaction.Mini_ledger.Transaction.Transaction.f_operation with
        | Mini_ledger.Transaction.Operation_Mint
          { Mini_ledger.Transaction.Operation.Mint.f_to = to ;
            Mini_ledger.Transaction.Operation.Mint.f_amount = amount } ->
          let tx:t_Transaction =
            {
              tx with
              Mini_ledger.Endpoints.Transaction.f_kind = Alloc.String.ToString.to_string "mint"
            }
          in
          let tx:t_Transaction =
            {
              tx with
              Mini_ledger.Endpoints.Transaction.f_mint
              =
              Core.Option.Option_Some
              ({
                  Mini_ledger.Endpoints.Mint.f_to = to;
                  Mini_ledger.Endpoints.Mint.f_amount = Core.Convert.From.from amount;
                  Mini_ledger.Endpoints.Mint.f_created_at_time = created_at_time;
                  Mini_ledger.Endpoints.Mint.f_memo = memo
                })
            }
          in
          tx
        | Mini_ledger.Transaction.Operation_Burn
          { Mini_ledger.Transaction.Operation.Burn.f_from = from ;
            Mini_ledger.Transaction.Operation.Burn.f_amount = amount } ->
          let tx:t_Transaction =
            {
              tx with
              Mini_ledger.Endpoints.Transaction.f_kind = Alloc.String.ToString.to_string "burn"
            }
          in
          let tx:t_Transaction =
            {
              tx with
              Mini_ledger.Endpoints.Transaction.f_burn
              =
              Core.Option.Option_Some
              ({
                  Mini_ledger.Endpoints.Burn.f_from = from;
                  Mini_ledger.Endpoints.Burn.f_amount = Core.Convert.From.from amount;
                  Mini_ledger.Endpoints.Burn.f_created_at_time = created_at_time;
                  Mini_ledger.Endpoints.Burn.f_memo = memo
                })
            }
          in
          tx
        | Mini_ledger.Transaction.Operation_Transfer
          { Mini_ledger.Transaction.Operation.Transfer.f_from = from ;
            Mini_ledger.Transaction.Operation.Transfer.f_to = to ;
            Mini_ledger.Transaction.Operation.Transfer.f_amount = amount ;
            Mini_ledger.Transaction.Operation.Transfer.f_fee = fee } ->
          let tx:t_Transaction =
            {
              tx with
              Mini_ledger.Endpoints.Transaction.f_kind = Alloc.String.ToString.to_string "transfer"
            }
          in
          let tx:t_Transaction =
            {
              tx with
              Mini_ledger.Endpoints.Transaction.f_transfer
              =
              Core.Option.Option_Some
              ({
                  Mini_ledger.Endpoints.Transfer.f_from = from;
                  Mini_ledger.Endpoints.Transfer.f_to = to;
                  Mini_ledger.Endpoints.Transfer.f_amount = Core.Convert.From.from amount;
                  Mini_ledger.Endpoints.Transfer.f_fee
                  =
                  Core.Option.Option_Some (Core.Convert.From.from fee);
                  Mini_ledger.Endpoints.Transfer.f_created_at_time = created_at_time;
                  Mini_ledger.Endpoints.Transfer.f_memo = memo
                })
            }
          in
          tx
      in
      tx
  }

type t_GetTransactionsResponse = {
  f_log_length:Candid.Types.Number.t_Nat;
  f_first_index:Candid.Types.Number.t_Nat;
  f_transactions:Alloc.Vec.t_Vec t_Transaction Alloc.Alloc.t_Global
}

let impl: Candid.Types.t_CandidType t_GetTransactionsResponse =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Type_Record
        (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                  <:
                  Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 3sz) Alloc.Alloc.t_Global)
              <:
              Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_GetTransactionsResponse) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist69:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist69)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.GetTransactionsResponse.f_first_index
          in
          let ser = tmp0 in
          let hoist71:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist72:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist71
          in
          let* _:Prims.unit =
            match hoist72 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist70:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist70)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.GetTransactionsResponse.f_log_length
          in
          let ser = tmp0 in
          let hoist74:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist75:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist74
          in
          let* _:Prims.unit =
            match hoist75 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist73:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist73)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.GetTransactionsResponse.f_transactions
          in
          let ser = tmp0 in
          let hoist77:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist78:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist77
          in
          let* _:Prims.unit =
            match hoist78 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist76:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist76)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___4: Prims.unit = ()

let t_BlockIndex = Candid.Types.Number.t_Nat

type t_GetTransactionsRequest = {
  f_start:Candid.Types.Number.t_Nat;
  f_length:Candid.Types.Number.t_Nat
}

let impl: Candid.Types.t_CandidType t_GetTransactionsRequest =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Type_Record
        (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                  <:
                  Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 2sz) Alloc.Alloc.t_Global)
              <:
              Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_GetTransactionsRequest) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist79:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist79)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.GetTransactionsRequest.f_start
          in
          let ser = tmp0 in
          let hoist81:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist82:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist81
          in
          let* _:Prims.unit =
            match hoist82 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist80:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist80)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.GetTransactionsRequest.f_length
          in
          let ser = tmp0 in
          let hoist84:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist85:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist84
          in
          let* _:Prims.unit =
            match hoist85 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist83:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist83)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___5: Prims.unit = ()

let t_NumTokens = Candid.Types.Number.t_Nat

type t_TransferError =
  | TransferError_BadFee { f_expected_fee:Candid.Types.Number.t_Nat }: t_TransferError
  | TransferError_BadBurn { f_min_burn_amount:Candid.Types.Number.t_Nat }: t_TransferError
  | TransferError_InsufficientFunds { f_balance:Candid.Types.Number.t_Nat }: t_TransferError
  | TransferError_TooOld : t_TransferError
  | TransferError_CreatedInFuture { f_ledger_time:u64 }: t_TransferError
  | TransferError_TemporarilyUnavailable : t_TransferError
  | TransferError_Duplicate { f_duplicate_of:Candid.Types.Number.t_Nat }: t_TransferError
  | TransferError_GenericError {
    f_error_code:Candid.Types.Number.t_Nat;
    f_message:Alloc.String.t_String
  }: t_TransferError

let impl: Candid.Types.t_CandidType t_TransferError =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Type_Variant
        (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                  <:
                  Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 8sz) Alloc.Alloc.t_Global)
              <:
              Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_TransferError) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* _:Prims.unit =
            match self with
            | TransferError_GenericError
              { Mini_ledger.Endpoints.TransferError.GenericError.f_message = message ;
                Mini_ledger.Endpoints.TransferError.GenericError.f_error_code = error_code } ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        0uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist86:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist86)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
                Candid.Types.Compound.serialize_element ser message
              in
              let ser = tmp0 in
              let hoist88:(_ & Core.Result.t_Result Prims.unit _) = out in
              let hoist89:Core.Ops.Control_flow.t_ControlFlow _ _ =
                Core.Ops.Try_trait.Try.branch hoist88
              in
              let* _:Prims.unit =
                match hoist89 with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist87:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist87)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
                Candid.Types.Compound.serialize_element ser error_code
              in
              let ser = tmp0 in
              let hoist91:(_ & Core.Result.t_Result Prims.unit _) = out in
              let hoist92:Core.Ops.Control_flow.t_ControlFlow _ _ =
                Core.Ops.Try_trait.Try.branch hoist91
              in
              let* _:Prims.unit =
                match hoist92 with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist90:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist90)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
            | TransferError_TemporarilyUnavailable  ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        1uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist93:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist93)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
            | TransferError_BadBurn
              { Mini_ledger.Endpoints.TransferError.BadBurn.f_min_burn_amount = min_burn_amount } ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        2uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist94:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist94)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
                Candid.Types.Compound.serialize_element ser min_burn_amount
              in
              let ser = tmp0 in
              let hoist96:(_ & Core.Result.t_Result Prims.unit _) = out in
              let hoist97:Core.Ops.Control_flow.t_ControlFlow _ _ =
                Core.Ops.Try_trait.Try.branch hoist96
              in
              let* _:Prims.unit =
                match hoist97 with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist95:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist95)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
            | TransferError_Duplicate
              { Mini_ledger.Endpoints.TransferError.Duplicate.f_duplicate_of = duplicate_of } ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        3uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist98:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist98)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
                Candid.Types.Compound.serialize_element ser duplicate_of
              in
              let ser = tmp0 in
              let hoist100:(_ & Core.Result.t_Result Prims.unit _) = out in
              let hoist101:Core.Ops.Control_flow.t_ControlFlow _ _ =
                Core.Ops.Try_trait.Try.branch hoist100
              in
              let* _:Prims.unit =
                match hoist101 with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist99:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist99)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
            | TransferError_BadFee
              { Mini_ledger.Endpoints.TransferError.BadFee.f_expected_fee = expected_fee } ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        4uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist102:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist102)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
                Candid.Types.Compound.serialize_element ser expected_fee
              in
              let ser = tmp0 in
              let hoist104:(_ & Core.Result.t_Result Prims.unit _) = out in
              let hoist105:Core.Ops.Control_flow.t_ControlFlow _ _ =
                Core.Ops.Try_trait.Try.branch hoist104
              in
              let* _:Prims.unit =
                match hoist105 with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist103:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist103)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
            | TransferError_CreatedInFuture
              { Mini_ledger.Endpoints.TransferError.CreatedInFuture.f_ledger_time = ledger_time } ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        5uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist106:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist106)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
                Candid.Types.Compound.serialize_element ser ledger_time
              in
              let ser = tmp0 in
              let hoist108:(_ & Core.Result.t_Result Prims.unit _) = out in
              let hoist109:Core.Ops.Control_flow.t_ControlFlow _ _ =
                Core.Ops.Try_trait.Try.branch hoist108
              in
              let* _:Prims.unit =
                match hoist109 with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist107:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist107)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
            | TransferError_TooOld  ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        6uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist110:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist110)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
            | TransferError_InsufficientFunds
              { Mini_ledger.Endpoints.TransferError.InsufficientFunds.f_balance = balance } ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        7uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist111:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist111)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
                Candid.Types.Compound.serialize_element ser balance
              in
              let ser = tmp0 in
              let hoist113:(_ & Core.Result.t_Result Prims.unit _) = out in
              let hoist114:Core.Ops.Control_flow.t_ControlFlow _ _ =
                Core.Ops.Try_trait.Try.branch hoist113
              in
              let* _:Prims.unit =
                match hoist114 with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist112:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist112)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___6: Prims.unit = ()

type t_TransferArg = {
  f_from_subaccount:Core.Option.t_Option (array u8 32sz);
  f_to:Mini_ledger.Account.t_Account;
  f_fee:Core.Option.t_Option Candid.Types.Number.t_Nat;
  f_created_at_time:Core.Option.t_Option u64;
  f_memo:Core.Option.t_Option Mini_ledger.Transaction.t_Memo;
  f_amount:Candid.Types.Number.t_Nat
}

let impl: Candid.Types.t_CandidType t_TransferArg =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Type_Record
        (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                  <:
                  Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 6sz) Alloc.Alloc.t_Global)
              <:
              Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_TransferArg) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist115:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist115)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.TransferArg.f_to
          in
          let ser = tmp0 in
          let hoist117:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist118:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist117
          in
          let* _:Prims.unit =
            match hoist118 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist116:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist116)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Endpoints.TransferArg.f_fee
          in
          let ser = tmp0 in
          let hoist120:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist121:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist120
          in
          let* _:Prims.unit =
            match hoist121 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist119:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist119)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.TransferArg.f_memo
          in
          let ser = tmp0 in
          let hoist123:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist124:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist123
          in
          let* _:Prims.unit =
            match hoist124 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist122:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist122)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.TransferArg.f_from_subaccount
          in
          let ser = tmp0 in
          let hoist126:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist127:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist126
          in
          let* _:Prims.unit =
            match hoist127 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist125:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist125)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.TransferArg.f_created_at_time
          in
          let ser = tmp0 in
          let hoist129:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist130:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist129
          in
          let* _:Prims.unit =
            match hoist130 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist128:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist128)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Endpoints.TransferArg.f_amount
          in
          let ser = tmp0 in
          let hoist132:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist133:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist132
          in
          let* _:Prims.unit =
            match hoist133 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist131:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist131)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___7: Prims.unit = ()

let impl: Core.Convert.t_From t_TransferError Mini_ledger.t_TransferError =
  {
    from
    =
    fun (err: Mini_ledger.t_TransferError) ->
      match err with
      | Mini_ledger.TransferError_BadFee
        { Mini_ledger.TransferError.BadFee.f_expected_fee = expected_fee } ->
        TransferError_BadFee
        ({
            Mini_ledger.Endpoints.TransferError.BadFee.f_expected_fee
            =
            Core.Convert.From.from (Mini_ledger_core.Tokens.get_e8s_under_impl expected_fee <: u64)
          })
      | Mini_ledger.TransferError_InsufficientFunds
        { Mini_ledger.TransferError.InsufficientFunds.f_balance = balance } ->
        TransferError_InsufficientFunds
        ({
            Mini_ledger.Endpoints.TransferError.InsufficientFunds.f_balance
            =
            Core.Convert.From.from (Mini_ledger_core.Tokens.get_e8s_under_impl balance <: u64)
          })
      | Mini_ledger.TransferError_TxTooOld  -> TransferError_TooOld
      | Mini_ledger.TransferError_TxCreatedInFuture
        { Mini_ledger.TransferError.TxCreatedInFuture.f_ledger_time = ledger_time } ->
        TransferError_CreatedInFuture
        ({
            Mini_ledger.Endpoints.TransferError.CreatedInFuture.f_ledger_time
            =
            Mini_ledger_core.Timestamp.as_nanos_since_unix_epoch_under_impl ledger_time
          })
      | Mini_ledger.TransferError_TxThrottled  -> TransferError_TemporarilyUnavailable
      | Mini_ledger.TransferError_TxDuplicate
        { Mini_ledger.TransferError.TxDuplicate.f_duplicate_of = duplicate_of } ->
        TransferError_Duplicate
        ({
            Mini_ledger.Endpoints.TransferError.Duplicate.f_duplicate_of
            =
            Core.Convert.From.from duplicate_of
          })
  }

let as_start_and_length_under_impl_2 (self: t_GetTransactionsRequest)
    : Core.Result.t_Result (u64 & usize) Alloc.String.t_String =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* start:u64 =
        match
          Core.Ops.Try_trait.Try.branch (Core.Option.ok_or_else_under_impl (Num_traits.Cast.ToPrimitive.to_u64
                    self.Mini_ledger.Endpoints.GetTransactionsRequest.f_start
                      .Candid.Types.Number.Nat.0
                  <:
                  Core.Option.t_Option u64)
                (fun  ->
                    Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list
                                =
                                  ["transaction index "; " is too large, max allowed: "]
                                in
                                FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                                Rust_primitives.Hax.array_of_list list)
                            <:
                            slice string)
                          (Rust_primitives.unsize (let list =
                                  [
                                    Core.Fmt.Rt.new_display_under_impl_1 self
                                        .Mini_ledger.Endpoints.GetTransactionsRequest.f_start
                                    <:
                                    Core.Fmt.Rt.t_Argument;
                                    Core.Fmt.Rt.new_display_under_impl_1 Core.Num.v_MAX_under_impl_9
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
                    <:
                    Alloc.String.t_String)
              <:
              Core.Result.t_Result u64 Alloc.String.t_String)
        with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist134:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                  residual
                <:
                Core.Result.t_Result (u64 & usize) Alloc.String.t_String)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist134)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      let* length:u64 =
        match
          Core.Ops.Try_trait.Try.branch (Core.Option.ok_or_else_under_impl (Num_traits.Cast.ToPrimitive.to_u64
                    self.Mini_ledger.Endpoints.GetTransactionsRequest.f_length
                      .Candid.Types.Number.Nat.0
                  <:
                  Core.Option.t_Option u64)
                (fun  ->
                    Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list
                                =
                                  ["requested length "; " is too large, max allowed: "]
                                in
                                FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                                Rust_primitives.Hax.array_of_list list)
                            <:
                            slice string)
                          (Rust_primitives.unsize (let list =
                                  [
                                    Core.Fmt.Rt.new_display_under_impl_1 self
                                        .Mini_ledger.Endpoints.GetTransactionsRequest.f_length
                                    <:
                                    Core.Fmt.Rt.t_Argument;
                                    Core.Fmt.Rt.new_display_under_impl_1 Core.Num.v_MAX_under_impl_9
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
                    <:
                    Alloc.String.t_String)
              <:
              Core.Result.t_Result u64 Alloc.String.t_String)
        with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist135:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                  residual
                <:
                Core.Result.t_Result (u64 & usize) Alloc.String.t_String)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist135)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok (start, cast length)))