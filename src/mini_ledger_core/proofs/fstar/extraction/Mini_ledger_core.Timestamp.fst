module Mini_ledger_core.Timestamp
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

type t_TimeStamp = { f_timestamp_nanos:u64 }

let impl: Candid.Types.t_CandidType t_TimeStamp =
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
    fun (self: t_TimeStamp) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist19:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist19)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger_core.Timestamp.TimeStamp.f_timestamp_nanos
          in
          let ser = tmp0 in
          let hoist21:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist22:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist21
          in
          let* _:Prims.unit =
            match hoist22 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist20:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist20)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___: Prims.unit = ()

let v___1: Prims.unit = ()

let new_under_impl (secs: u64) (nanos: u32) : t_TimeStamp =
  let _:Prims.unit =
    if ~.(nanos <. 1000000000ul <: bool)
    then
      Rust_primitives.Hax.never_to_any (Core.Panicking.panic "assertion failed: nanos < 1_000_000_000"

          <:
          Rust_primitives.Hax.t_Never)
  in
  {
    Mini_ledger_core.Timestamp.TimeStamp.f_timestamp_nanos
    =
    (secs *. 1000000000uL <: u64) +. cast nanos
  }

let from_nanos_since_unix_epoch_under_impl (nanos: u64) : t_TimeStamp =
  { Mini_ledger_core.Timestamp.TimeStamp.f_timestamp_nanos = nanos }

let as_nanos_since_unix_epoch_under_impl (self: t_TimeStamp) : u64 =
  self.Mini_ledger_core.Timestamp.TimeStamp.f_timestamp_nanos

let impl: Core.Convert.t_From t_TimeStamp Std.Time.t_SystemTime =
  {
    from
    =
    fun (t: Std.Time.t_SystemTime) ->
      let d:Core.Time.t_Duration =
        Core.Result.unwrap_under_impl (Std.Time.duration_since_under_impl_7 t
              Std.Time.v_UNIX_EPOCH_under_impl_7
            <:
            Core.Result.t_Result Core.Time.t_Duration Std.Time.t_SystemTimeError)
      in
      from_nanos_since_unix_epoch_under_impl (Core.Result.unwrap_under_impl (Core.Convert.TryInto.try_into
                (Core.Time.as_nanos_under_impl_1 d <: u128)
              <:
              Core.Result.t_Result u64 _)
          <:
          u64)
  }

let impl: Core.Convert.t_From Std.Time.t_SystemTime t_TimeStamp =
  {
    from
    =
    fun (t: t_TimeStamp) ->
      Std.Time.v_UNIX_EPOCH_under_impl_7 +.
      (Core.Time.from_nanos_under_impl_1 t.Mini_ledger_core.Timestamp.TimeStamp.f_timestamp_nanos
        <:
        Core.Time.t_Duration)
  }

let impl: Core.Ops.Arith.t_Add t_TimeStamp Core.Time.t_Duration =
  {
    output = t_TimeStamp;
    add
    =
    fun (self: t_TimeStamp) (d: Core.Time.t_Duration) ->
      Core.Convert.Into.into ((Core.Convert.From.from self <: Std.Time.t_SystemTime) +. d <: _)
  }