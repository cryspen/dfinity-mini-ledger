module Mini_ledger_core.Timestamp
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open FStar.Mul
open Hacspec.Lib
open Hacspec_lib_tc

type timeStamp_t = { timestamp_nanos:UInt64.t }

let impl: Candid.Types.CandidType timeStamp_t =
  {
    _ty
    =
    (fun  ->
        Candid.Types.Internal.Record
        (Alloc.Slice.into_vec (Hacspec.Lib.unsize [
                  {
                    Candid.Types.Internal.id
                    =
                    Candid.Types.Internal.Named (Alloc.String.ToString.to_string "timestamp_nanos");
                    Candid.Types.Internal.ty = Candid.Types.CandidType.ty
                  }
                ])));
    id = (fun  -> Candid.Types.Internal.of);
    idl_serialize
    =
    fun (self: timeStamp_t) (__serializer: __s) ->
      Hacspec.Lib.run (let ser:Core.Result.result_t Prims.unit _ =
            Std.Ops.FromResidual.from_residual (Candid.Types.Serializer.serialize_struct __serializer
                )
          in
          let todo_fresh_var, ser_temp:(Core.Result.result_t Prims.unit _ & _) =
            Candid.Types.Compound.serialize_element ser
              self.Mini_ledger_core.Timestamp.TimeStamp.timestamp_nanos
          in
          let ser = ser_temp in
          let hoist2:Core.Result.result_t Prims.unit _ = todo_fresh_var in
          let* _:Prims.unit = Std.Ops.FromResidual.from_residual hoist2 in
          Core.Result.Result.Ok (Core.Result.Ok ()))
  }

let _: Prims.unit = ()

let _: Prims.unit = ()

let _ = "hax failure"

let impl: Core.Convert.From timeStamp_t Std.Time.systemTime_t =
  {
    from
    =
    fun (t: Std.Time.systemTime_t) ->
      let d:Core.Time.duration_t =
        Core.Result.unwrap (Std.Time.duration_since t Std.Time.uNIX_EPOCH)
      in
      from_nanos_since_unix_epoch (Core.Result.unwrap (Core.Convert.TryInto.try_into (Core.Time.as_nanos
                    d)))
  }

let impl: Core.Convert.From Std.Time.systemTime_t timeStamp_t =
  {
    from
    =
    fun (t: timeStamp_t) ->
      Std.Time.uNIX_EPOCH +.
      Core.Time.from_nanos t.Mini_ledger_core.Timestamp.TimeStamp.timestamp_nanos
  }

let impl: Core.Ops.Arith.Add timeStamp_t Core.Time.duration_t =
  {
    output = timeStamp_t;
    add
    =
    fun (self: timeStamp_t) (d: Core.Time.duration_t) ->
      Core.Convert.Into.into (Core.Convert.From.from self +. d)
  }