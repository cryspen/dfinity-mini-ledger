module Mini_ledger_core.Tokens
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open FStar.Mul
open Hacspec.Lib
open Hacspec_lib_tc

type tokens_t = { e8s:UInt64.t }

let _: Prims.unit = ()

let _: Prims.unit = ()

let impl: Candid.Types.CandidType tokens_t =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Record
        (Alloc.Slice.into_vec (Hacspec.Lib.unsize [
                  {
                    Candid.Types.Internal.id
                    =
                    Candid.Types.Internal.Named (Alloc.String.ToString.to_string "e8s");
                    Candid.Types.Internal.ty = Candid.Types.CandidType.ty
                  }
                ])));
    id = (fun  -> Candid.Types.Internal.of);
    idl_serialize
    =
    fun (self: tokens_t) (__serializer: __s) ->
      Hacspec.Lib.run (let ser:Core.Result.result_t Prims.unit _ =
            Std.Ops.FromResidual.from_residual (Candid.Types.Serializer.serialize_struct __serializer
                )
          in
          let todo_fresh_var, ser_temp:(Core.Result.result_t Prims.unit _ & _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger_core.Tokens.Tokens.e8s
          in
          let ser = ser_temp in
          let hoist3:Core.Result.result_t Prims.unit _ = todo_fresh_var in
          let* _:Prims.unit = Std.Ops.FromResidual.from_residual hoist3 in
          Core.Result.Result.Ok (Core.Result.Ok ()))
  }

let dECIMAL_PLACES: UInt32.t = 8ul

let tOKEN_SUBDIVIDABLE_BY: UInt64.t = 100000000uL

let _ = "hax failure"

let impl: Core.Ops.Arith.Add tokens_t tokens_t =
  {
    output = Core.Result.result_t tokens_t Alloc.String.string_t;
    add
    =
    fun (self: tokens_t) (other: tokens_t) ->
      let e8s:Core.Result.result_t tokens_t Alloc.String.string_t =
        Std.Ops.FromResidual.from_residual (Core.Option.ok_or_else (Core.Num.checked_add self
                    .Mini_ledger_core.Tokens.Tokens.e8s
                  other.Mini_ledger_core.Tokens.Tokens.e8s)
              (fun  ->
                  Alloc.Fmt.format (Core.Fmt.new_v1 (Hacspec.Lib.unsize [
                              "Add Token ";
                              " + ";
                              " failed because the underlying u64 overflowed"
                            ])
                        (Hacspec.Lib.unsize [
                              Core.Fmt.new_display self.Mini_ledger_core.Tokens.Tokens.e8s;
                              Core.Fmt.new_display other.Mini_ledger_core.Tokens.Tokens.e8s
                            ]))))
      in
      Core.Result.Ok ({ e8s = e8s })
  }

let impl: Core.Ops.Arith.Sub tokens_t tokens_t =
  {
    output = Core.Result.result_t tokens_t Alloc.String.string_t;
    sub
    =
    fun (self: tokens_t) (other: tokens_t) ->
      let e8s:Core.Result.result_t tokens_t Alloc.String.string_t =
        Std.Ops.FromResidual.from_residual (Core.Option.ok_or_else (Core.Num.checked_sub self
                    .Mini_ledger_core.Tokens.Tokens.e8s
                  other.Mini_ledger_core.Tokens.Tokens.e8s)
              (fun  ->
                  Alloc.Fmt.format (Core.Fmt.new_v1 (Hacspec.Lib.unsize [
                              "Subtracting Token ";
                              " - ";
                              " failed because the underlying u64 underflowed"
                            ])
                        (Hacspec.Lib.unsize [
                              Core.Fmt.new_display self.Mini_ledger_core.Tokens.Tokens.e8s;
                              Core.Fmt.new_display other.Mini_ledger_core.Tokens.Tokens.e8s
                            ]))))
      in
      Core.Result.Ok ({ e8s = e8s })
  }