module Mini_ledger_core.Tokens
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

type t_Tokens = { f_e8s:u64 }

let v___: Prims.unit = ()

let v___1: Prims.unit = ()

let impl: Candid.Types.t_CandidType t_Tokens =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Type_Record
        (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new
                  <:
                  Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 1sz) Alloc.Alloc.t_Global)
              <:
              Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_Tokens) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist23:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist23)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger_core.Tokens.Tokens.f_e8s
          in
          let ser = tmp0 in
          let hoist25:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist26:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist25
          in
          let* _:Prims.unit =
            match hoist26 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist24:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist24)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v_DECIMAL_PLACES: u32 = 8ul

let v_TOKEN_SUBDIVIDABLE_BY: u64 = 100000000uL

let v_MAX_under_impl: t_Tokens =
  { Mini_ledger_core.Tokens.Tokens.f_e8s = Core.Num.v_MAX_under_impl_9 }

let new_under_impl (tokens e8s: u64) : Core.Result.t_Result t_Tokens Alloc.String.t_String =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* token_part:u64 =
        match
          Core.Ops.Try_trait.Try.branch (Core.Option.ok_or_else_under_impl (Core.Num.checked_mul_under_impl_9
                    tokens
                    v_TOKEN_SUBDIVIDABLE_BY
                  <:
                  Core.Option.t_Option u64)
                (fun  ->
                    Alloc.String.ToString.to_string v_CONSTRUCTION_FAILED_under_new_under_impl
                    <:
                    Alloc.String.t_String)
              <:
              Core.Result.t_Result u64 Alloc.String.t_String)
        with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist27:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                  residual
                <:
                Core.Result.t_Result t_Tokens Alloc.String.t_String)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist27)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      let* _:Prims.unit =
        if e8s >=. v_TOKEN_SUBDIVIDABLE_BY
        then
          let res:Alloc.String.t_String =
            Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list =
                          ["You've added too many E8s, make sure there are less than "]
                        in
                        FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
                        Rust_primitives.Hax.array_of_list list)
                    <:
                    slice string)
                  (Rust_primitives.unsize (let list =
                          [
                            Core.Fmt.Rt.new_display_under_impl_1 v_TOKEN_SUBDIVIDABLE_BY
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
          let* hoist28:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (Core.Result.Result_Err res)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist28)
        else Core.Ops.Control_flow.ControlFlow_Continue ()
      in
      let* e8s:u64 =
        match
          Core.Ops.Try_trait.Try.branch (Core.Option.ok_or_else_under_impl (Core.Num.checked_add_under_impl_9
                    token_part
                    e8s
                  <:
                  Core.Option.t_Option u64)
                (fun  ->
                    Alloc.String.ToString.to_string v_CONSTRUCTION_FAILED_under_new_under_impl
                    <:
                    Alloc.String.t_String)
              <:
              Core.Result.t_Result u64 Alloc.String.t_String)
        with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist29:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                  residual
                <:
                Core.Result.t_Result t_Tokens Alloc.String.t_String)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist29)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      Core.Ops.Control_flow.ControlFlow_Continue
      (Core.Result.Result_Ok ({ Mini_ledger_core.Tokens.Tokens.f_e8s = e8s })))

let v_ZERO_under_impl: t_Tokens = { Mini_ledger_core.Tokens.Tokens.f_e8s = 0uL }

let from_tokens_under_impl (tokens: u64) : Core.Result.t_Result t_Tokens Alloc.String.t_String =
  new_under_impl tokens 0uL

let from_e8s_under_impl (e8s: u64) : t_Tokens = { Mini_ledger_core.Tokens.Tokens.f_e8s = e8s }

let get_tokens_under_impl (self: t_Tokens) : u64 =
  self.Mini_ledger_core.Tokens.Tokens.f_e8s /. v_TOKEN_SUBDIVIDABLE_BY

let get_e8s_under_impl (self: t_Tokens) : u64 = self.Mini_ledger_core.Tokens.Tokens.f_e8s

let get_remainder_e8s_under_impl (self: t_Tokens) : u64 =
  self.Mini_ledger_core.Tokens.Tokens.f_e8s %. v_TOKEN_SUBDIVIDABLE_BY

let unpack_under_impl (self: t_Tokens) : (u64 & u64) =
  get_tokens_under_impl self, get_remainder_e8s_under_impl self

let impl: Core.Ops.Arith.t_Add t_Tokens t_Tokens =
  {
    output = Core.Result.t_Result t_Tokens Alloc.String.t_String;
    add
    =
    fun (self: t_Tokens) (other: t_Tokens) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* e8s:u64 =
            match
              Core.Ops.Try_trait.Try.branch (Core.Option.ok_or_else_under_impl (Core.Num.checked_add_under_impl_9
                        self.Mini_ledger_core.Tokens.Tokens.f_e8s
                        other.Mini_ledger_core.Tokens.Tokens.f_e8s
                      <:
                      Core.Option.t_Option u64)
                    (fun  ->
                        Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let
                                    list =
                                      [
                                        "Add Token ";
                                        " + ";
                                        " failed because the underlying u64 overflowed"
                                      ]
                                    in
                                    FStar.Pervasives.assert_norm
                                    (Prims.eq2 (List.Tot.length list) 3);
                                    Rust_primitives.Hax.array_of_list list)
                                <:
                                slice string)
                              (Rust_primitives.unsize (let list =
                                      [
                                        Core.Fmt.Rt.new_display_under_impl_1 self
                                            .Mini_ledger_core.Tokens.Tokens.f_e8s
                                        <:
                                        Core.Fmt.Rt.t_Argument;
                                        Core.Fmt.Rt.new_display_under_impl_1 other
                                            .Mini_ledger_core.Tokens.Tokens.f_e8s
                                        <:
                                        Core.Fmt.Rt.t_Argument
                                      ]
                                    in
                                    FStar.Pervasives.assert_norm
                                    (Prims.eq2 (List.Tot.length list) 2);
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
              let* hoist30:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result t_Tokens Alloc.String.t_String)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist30)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue
          (Core.Result.Result_Ok ({ Mini_ledger_core.Tokens.Tokens.f_e8s = e8s })))
  }

let impl: Core.Ops.Arith.t_AddAssign t_Tokens t_Tokens =
  {
    add_assign
    =
    fun (self: t_Tokens) (other: t_Tokens) ->
      let self:t_Tokens = Core.Result.expect_under_impl (self +. other <: _) "+= panicked" in
      self
  }

let impl: Core.Ops.Arith.t_Sub t_Tokens t_Tokens =
  {
    output = Core.Result.t_Result t_Tokens Alloc.String.t_String;
    sub
    =
    fun (self: t_Tokens) (other: t_Tokens) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* e8s:u64 =
            match
              Core.Ops.Try_trait.Try.branch (Core.Option.ok_or_else_under_impl (Core.Num.checked_sub_under_impl_9
                        self.Mini_ledger_core.Tokens.Tokens.f_e8s
                        other.Mini_ledger_core.Tokens.Tokens.f_e8s
                      <:
                      Core.Option.t_Option u64)
                    (fun  ->
                        Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let
                                    list =
                                      [
                                        "Subtracting Token ";
                                        " - ";
                                        " failed because the underlying u64 underflowed"
                                      ]
                                    in
                                    FStar.Pervasives.assert_norm
                                    (Prims.eq2 (List.Tot.length list) 3);
                                    Rust_primitives.Hax.array_of_list list)
                                <:
                                slice string)
                              (Rust_primitives.unsize (let list =
                                      [
                                        Core.Fmt.Rt.new_display_under_impl_1 self
                                            .Mini_ledger_core.Tokens.Tokens.f_e8s
                                        <:
                                        Core.Fmt.Rt.t_Argument;
                                        Core.Fmt.Rt.new_display_under_impl_1 other
                                            .Mini_ledger_core.Tokens.Tokens.f_e8s
                                        <:
                                        Core.Fmt.Rt.t_Argument
                                      ]
                                    in
                                    FStar.Pervasives.assert_norm
                                    (Prims.eq2 (List.Tot.length list) 2);
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
              let* hoist31:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result t_Tokens Alloc.String.t_String)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist31)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue
          (Core.Result.Result_Ok ({ Mini_ledger_core.Tokens.Tokens.f_e8s = e8s })))
  }

let impl: Core.Ops.Arith.t_SubAssign t_Tokens t_Tokens =
  {
    sub_assign
    =
    fun (self: t_Tokens) (other: t_Tokens) ->
      let self:t_Tokens = Core.Result.expect_under_impl (self -. other <: _) "-= panicked" in
      self
  }