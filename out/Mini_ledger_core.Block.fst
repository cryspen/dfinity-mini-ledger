module Mini_ledger_core.Block
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open FStar.Mul
open Hacspec.Lib
open Hacspec_lib_tc

let blockIndex = UInt64.t

let hASH_LENGTH: uint_size = 32

type hashOf_t = {
  inner:x: Prims.list UInt8.t {Prims.op_LessThan (FStar.List.Tot.Base.length x) 32};
  _marker:Core.Marker.phantomData_t t
}

let impl (#t: Type) : Candid.Types.CandidType (hashOf_t t) =
  {
    _ty
    =
    (fun (#t: Type) -> Candid.Types.Internal.Vec (Alloc.Boxed.new_ Candid.Types.Internal.Nat8));
    idl_serialize
    =
    fun (#t: Type) (self: hashOf_t t) (serializer: s) ->
      Candid.Types.Serializer.serialize_blob serializer (as_slice self)
  }

let impl
      (#t: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.sized_t t)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Clone.clone_t t)
    : Core.Marker.Copy (hashOf_t t) = {  }

let _ = "hax failure"

let impl (#t: Type) : Core.Str.Traits.FromStr (hashOf_t t) =
  {
    err = Alloc.String.string_t;
    from_str
    =
    fun (#t: Type) (s: Prims.string) ->
      let v:Core.Result.result_t (hashOf_t t) Alloc.String.string_t =
        Std.Ops.FromResidual.from_residual (Core.Result.map_err (Hex.decode s)
              (fun e -> Alloc.String.ToString.to_string e))
      in
      let slice:FStar.Seq.seq UInt8.t = Alloc.Vec.as_slice v in
      match Core.Convert.TryInto.try_into slice with
      | Core.Result.Ok ba -> Core.Result.Ok (new_ ba)
      | Core.Result.Err _ ->
        let res:Alloc.String.string_t =
          Alloc.Fmt.format (Core.Fmt.new_v1 (Hacspec.Lib.unsize [
                      "Expected a Vec of length ";
                      " but it was "
                    ])
                (Hacspec.Lib.unsize [
                      Core.Fmt.new_display hASH_LENGTH;
                      Core.Fmt.new_display (Alloc.Vec.len v)
                    ]))
        in
        Core.Result.Err res
  }

let impl (#t: Type) : Serde.Ser.Serialize (hashOf_t t) =
  {
    serialize
    =
    fun (#t: Type) (self: hashOf_t t) (serializer: s) ->
      if Serde.Ser.Serializer.is_human_readable serializer
      then
        Serde.Ser.Serializer.serialize_str serializer
          (Core.Ops.Deref.Deref.deref (Alloc.String.ToString.to_string self))
      else Serde.Ser.Serializer.serialize_bytes serializer (as_slice self)
  }

let impl (#t: Type) : Serde.De.Deserialize (hashOf_t t) =
  {
    deserialize
    =
    fun (#t: Type) (deserializer: d) ->
      if Serde.De.Deserializer.is_human_readable deserializer
      then
        Serde.De.Deserializer.deserialize_str deserializer
          ({ Mini_ledger_core.Block.Deserialize.phantom = {  } })
      else
        Serde.De.Deserializer.deserialize_bytes deserializer
          ({ Mini_ledger_core.Block.Deserialize.phantom = {  } })
  }

type encodedBlock = | EncodedBlock : Serde_bytes.Bytebuf.byteBuf_t -> encodedBlock

let _: Prims.unit = ()

let _: Prims.unit = ()

let impl: Candid.Types.CandidType encodedBlock_t =
  {
    _ty = (fun  -> Candid.Types.CandidType.ty);
    id = (fun  -> Candid.Types.Internal.of);
    idl_serialize
    =
    fun (self: encodedBlock_t) (__serializer: __s) ->
      Hacspec.Lib.run (let ser:Core.Result.result_t Prims.unit _ =
            Std.Ops.FromResidual.from_residual (Candid.Types.Serializer.serialize_struct __serializer
                )
          in
          let todo_fresh_var, ser_temp:(Core.Result.result_t Prims.unit _ & _) =
            Candid.Types.Compound.serialize_element ser self.Mini_ledger_core.Block.EncodedBlock.0
          in
          let ser = ser_temp in
          let hoist1:Core.Result.result_t Prims.unit _ = todo_fresh_var in
          let* _:Prims.unit = Std.Ops.FromResidual.from_residual hoist1 in
          Core.Result.Result.Ok (Core.Result.Ok ()))
  }

let impl: Core.Convert.From encodedBlock_t (Alloc.Vec.vec_t UInt8.t Alloc.Alloc.global_t) =
  { from = fun (bytes: Alloc.Vec.vec_t UInt8.t Alloc.Alloc.global_t) -> from_vec bytes }

let _ = "hax failure"

class blockType (self: Type) = {
  transaction:Type;
  transaction_implements_Sized:Core.Marker.sized_t self;
  transaction_implements_BlockType:blockType_t self;
  from_transaction:
      Core.Option.option_t (hashOf_t encodedBlock_t) ->
      _ ->
      Mini_ledger_core.Timestamp.timeStamp_t
    -> self;
  encode:self -> encodedBlock_t;
  decode:encodedBlock_t -> Core.Result.result_t self Alloc.String.string_t;
  block_hash:encodedBlock_t -> hashOf_t encodedBlock_t;
  parent_hash:self -> Core.Option.option_t (hashOf_t encodedBlock_t);
  timestamp:self -> Mini_ledger_core.Timestamp.timeStamp_t
}