module Mini_ledger.Account
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

let t_Subaccount = array u8 32sz

let v_DEFAULT_SUBACCOUNT: array u8 32sz = Rust_primitives.Hax.repeat 0uy 32sz

type t_Account = {
  f_owner:Candid.Types.Principal.t_Principal;
  f_subaccount:Core.Option.t_Option (array u8 32sz)
}

let v___: Prims.unit = ()

let v___1: Prims.unit = ()

let impl: Candid.Types.t_CandidType t_Account =
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
    fun (self: t_Account) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist1:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist1)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger.Account.Account.f_owner
          in
          let ser = tmp0 in
          let hoist3:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist4:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist3
          in
          let* _:Prims.unit =
            match hoist4 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist2:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist2)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger.Account.Account.f_subaccount
          in
          let ser = tmp0 in
          let hoist6:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist7:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist6
          in
          let* _:Prims.unit =
            match hoist7 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist5:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist5)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let effective_subaccount_under_impl (self: t_Account) : array u8 32sz =
  Core.Option.unwrap_or_under_impl (Core.Option.as_ref_under_impl self
          .Mini_ledger.Account.Account.f_subaccount
      <:
      Core.Option.t_Option (array u8 32sz))
    v_DEFAULT_SUBACCOUNT

let impl: Core.Cmp.t_PartialEq t_Account t_Account =
  {
    eq
    =
    fun (self: t_Account) (other: t_Account) ->
      Prims.op_AmpAmp (self.Mini_ledger.Account.Account.f_owner =.
          other.Mini_ledger.Account.Account.f_owner)
        ((effective_subaccount_under_impl self <: array u8 32sz) =.
          (effective_subaccount_under_impl other <: array u8 32sz))
  }

let impl: Core.Cmp.t_Eq t_Account = {  }

let impl: Core.Cmp.t_PartialOrd t_Account t_Account =
  {
    partial_cmp
    =
    fun (self: t_Account) (other: t_Account) ->
      Core.Option.Option_Some (Core.Cmp.Ord.cmp self other)
  }

let impl: Core.Cmp.t_Ord t_Account =
  {
    cmp
    =
    fun (self: t_Account) (other: t_Account) ->
      Core.Cmp.then_with_under_impl (Core.Cmp.Ord.cmp self.Mini_ledger.Account.Account.f_owner
            other.Mini_ledger.Account.Account.f_owner
          <:
          Core.Cmp.t_Ordering)
        (fun  ->
            Core.Cmp.Ord.cmp (effective_subaccount_under_impl self <: array u8 32sz)
              (effective_subaccount_under_impl other <: array u8 32sz)
            <:
            Core.Cmp.t_Ordering)
  }

let impl: Core.Hash.t_Hash t_Account =
  {
    hash
    =
    fun (self: t_Account) (state: h) ->
      let state:h = Core.Hash.Hash.hash self.Mini_ledger.Account.Account.f_owner state in
      let state:h =
        Core.Hash.Hash.hash (effective_subaccount_under_impl self <: array u8 32sz) state
      in
      state
  }

let impl: Core.Fmt.t_Display t_Account =
  {
    fmt
    =
    fun (self: t_Account) (f: Core.Fmt.t_Formatter) ->
      let f, output:(Core.Fmt.t_Formatter &
        (Core.Fmt.t_Formatter & Core.Result.t_Result Prims.unit Core.Fmt.t_Error)) =
        match self.Mini_ledger.Account.Account.f_subaccount with
        | Core.Option.Option_None  ->
          let tmp0, out:(Core.Fmt.t_Formatter & Core.Result.t_Result Prims.unit Core.Fmt.t_Error) =
            Core.Fmt.write_fmt_under_impl_7 f
              (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list = [""] in
                        FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
                        Rust_primitives.Hax.array_of_list list)
                    <:
                    slice string)
                  (Rust_primitives.unsize (let list =
                          [
                            Core.Fmt.Rt.new_display_under_impl_1 self
                                .Mini_ledger.Account.Account.f_owner
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
          let f:Core.Fmt.t_Formatter = tmp0 in
          f, out
        | Core.Option.Option_Some subaccount ->
          let tmp0, out:(Core.Fmt.t_Formatter & Core.Result.t_Result Prims.unit Core.Fmt.t_Error) =
            Core.Fmt.write_fmt_under_impl_7 f
              (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list = ["0x"; "."] in
                        FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                        Rust_primitives.Hax.array_of_list list)
                    <:
                    slice string)
                  (Rust_primitives.unsize (let list =
                          [
                            Core.Fmt.Rt.new_display_under_impl_1 (Hex.encode (subaccount.[ Core.Ops.Range.RangeFull
                                    ]
                                    <:
                                    slice u8)
                                <:
                                Alloc.String.t_String)
                            <:
                            Core.Fmt.Rt.t_Argument;
                            Core.Fmt.Rt.new_display_under_impl_1 self
                                .Mini_ledger.Account.Account.f_owner
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
          f, out
      in
      f, output
  }

let impl: Core.Convert.t_From t_Account Candid.Types.Principal.t_Principal =
  {
    from
    =
    fun (owner: Candid.Types.Principal.t_Principal) ->
      {
        Mini_ledger.Account.Account.f_owner = owner;
        Mini_ledger.Account.Account.f_subaccount = Core.Option.Option_None
      }
  }