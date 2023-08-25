module Mini_ledger_core.Block
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

let t_BlockIndex = u64

let v_HASH_LENGTH: usize = 32sz

type t_HashOf = {
  f_inner:array u8 32sz;
  f__marker:Core.Marker.t_PhantomData t
}

let impl (#t: Type) : Candid.Types.t_CandidType (t_HashOf t) =
  {
    _ty = (fun (#t: Type) -> Candid.Types.Internal.Type_Vec Candid.Types.Internal.Type_Nat8);
    idl_serialize
    =
    fun (#t: Type) (self: t_HashOf t) (serializer: s) ->
      Candid.Types.Serializer.serialize_blob serializer (as_slice_under_impl_2 self <: slice u8)
  }

let impl
      (#t: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized t)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Clone.t_Clone t)
    : Core.Marker.t_Copy (t_HashOf t) = {  }

let into_bytes_under_impl_2 (#t: Type) (self: t_HashOf t) : array u8 32sz =
  self.Mini_ledger_core.Block.HashOf.f_inner

let new_under_impl_2 (#t: Type) (bs: array u8 32sz) : t_HashOf t =
  {
    Mini_ledger_core.Block.HashOf.f_inner = bs;
    Mini_ledger_core.Block.HashOf.f__marker = Core.Marker.PhantomData
  }

let as_slice_under_impl_2 (#t: Type) (self: t_HashOf t) : slice u8 =
  Rust_primitives.unsize self.Mini_ledger_core.Block.HashOf.f_inner

let impl (#t: Type) : Core.Fmt.t_Display (t_HashOf t) =
  {
    fmt
    =
    fun (#t: Type) (self: t_HashOf t) (f: Core.Fmt.t_Formatter) ->
      let res:Alloc.String.t_String = Hex.encode (as_slice_under_impl_2 self <: slice u8) in
      let tmp0, out:(Core.Fmt.t_Formatter & Core.Result.t_Result Prims.unit Core.Fmt.t_Error) =
        Core.Fmt.write_fmt_under_impl_7 f
          (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list = [""] in
                    FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
                    Rust_primitives.Hax.array_of_list list)
                <:
                slice string)
              (Rust_primitives.unsize (let list =
                      [Core.Fmt.Rt.new_display_under_impl_1 res <: Core.Fmt.Rt.t_Argument]
                    in
                    FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
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

let impl (#t: Type) : Core.Str.Traits.t_FromStr (t_HashOf t) =
  {
    err = Alloc.String.t_String;
    from_str
    =
    fun (#t: Type) (s: string) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* v:Alloc.Vec.t_Vec u8
            Alloc.Alloc.t_Global =
            match
              Core.Ops.Try_trait.Try.branch (Core.Result.map_err_under_impl (Hex.decode s
                      <:
                      Core.Result.t_Result (Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global)
                        Hex.Error.t_FromHexError)
                    (fun e -> Alloc.String.ToString.to_string e <: Alloc.String.t_String)
                  <:
                  Core.Result.t_Result (Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global)
                    Alloc.String.t_String)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist14:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result (t_HashOf t) Alloc.String.t_String)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist14)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue
          (let slice:slice u8 = Alloc.Vec.as_slice_under_impl_1 v in
            match Core.Convert.TryInto.try_into slice with
            | Core.Result.Result_Ok ba -> Core.Result.Result_Ok (new_under_impl_2 ba)
            | Core.Result.Result_Err _ ->
              let res:Alloc.String.t_String =
                Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list =
                              ["Expected a Vec of length "; " but it was "]
                            in
                            FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                            Rust_primitives.Hax.array_of_list list)
                        <:
                        slice string)
                      (Rust_primitives.unsize (let list =
                              [
                                Core.Fmt.Rt.new_display_under_impl_1 v_HASH_LENGTH
                                <:
                                Core.Fmt.Rt.t_Argument;
                                Core.Fmt.Rt.new_display_under_impl_1 (Alloc.Vec.len_under_impl_1 v
                                    <:
                                    usize)
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
              Core.Result.Result_Err res))
  }

let impl (#t: Type) : Serde.Ser.t_Serialize (t_HashOf t) =
  {
    serialize
    =
    fun (#t: Type) (self: t_HashOf t) (serializer: s) ->
      if Serde.Ser.Serializer.is_human_readable serializer
      then
        Serde.Ser.Serializer.serialize_str serializer
          (Core.Ops.Deref.Deref.deref (Alloc.String.ToString.to_string self <: Alloc.String.t_String
              )
            <:
            string)
      else Serde.Ser.Serializer.serialize_bytes serializer (as_slice_under_impl_2 self <: slice u8)
  }

let impl (#t: Type) : Serde.De.t_Deserialize (t_HashOf t) =
  {
    deserialize
    =
    fun (#t: Type) (deserializer: d) ->
      if Serde.De.Deserializer.is_human_readable deserializer
      then
        Serde.De.Deserializer.deserialize_str deserializer
          ({
              Mini_ledger_core.Block.Impl_6.Deserialize.HashOfVisitor.f_phantom
              =
              Core.Marker.PhantomData
            })
      else
        Serde.De.Deserializer.deserialize_bytes deserializer
          ({
              Mini_ledger_core.Block.Impl_6.Deserialize.HashOfVisitor.f_phantom
              =
              Core.Marker.PhantomData
            })
  }

type t_HashOfVisitor_under_deserialize_under_impl_6 = { f_phantom:Core.Marker.t_PhantomData t }

let impl (#t: Type) : Serde.De.t_Visitor (t_HashOfVisitor_under_deserialize_under_impl_6 t) =
  {
    value = t_HashOf t;
    expecting
    =
    (fun
        (#t: Type)
        (self: t_HashOfVisitor_under_deserialize_under_impl_6 t)
        (formatter: Core.Fmt.t_Formatter)
        ->
        let tmp0, out:(Core.Fmt.t_Formatter & Core.Result.t_Result Prims.unit Core.Fmt.t_Error) =
          Core.Fmt.write_fmt_under_impl_7 formatter
            (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list =
                        ["a hash of type "; ": a blob with at most "; " bytes"]
                      in
                      FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 3);
                      Rust_primitives.Hax.array_of_list list)
                  <:
                  slice string)
                (Rust_primitives.unsize (let list =
                        [
                          Core.Fmt.Rt.new_display_under_impl_1 (Core.Any.type_name <: string)
                          <:
                          Core.Fmt.Rt.t_Argument;
                          Core.Fmt.Rt.new_display_under_impl_1 v_HASH_LENGTH
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
        let formatter:Core.Fmt.t_Formatter = tmp0 in
        let output:(Core.Fmt.t_Formatter & Core.Result.t_Result Prims.unit Core.Fmt.t_Error) =
          out
        in
        formatter, output);
    visit_bytes
    =
    (fun (#t: Type) (self: t_HashOfVisitor_under_deserialize_under_impl_6 t) (v: slice u8) ->
        Core.Result.Result_Ok
        (new_under_impl_2 (Core.Result.expect_under_impl (Core.Convert.TryInto.try_into v
                  <:
                  Core.Result.t_Result (array u8 32sz) _)
                "hash does not have correct length"
              <:
              array u8 32sz)));
    visit_str
    =
    fun (#t: Type) (self: t_HashOfVisitor_under_deserialize_under_impl_6 t) (s: string) ->
      Core.Result.map_err_under_impl (Core.Str.Traits.FromStr.from_str s
          <:
          Core.Result.t_Result (t_HashOf t) _)
        Serde.De.Error.custom
  }

type t_EncodedBlock = | EncodedBlock : Serde_bytes.Bytebuf.t_ByteBuf -> t_EncodedBlock

let v___: Prims.unit = ()

let v___1: Prims.unit = ()

let impl: Candid.Types.t_CandidType t_EncodedBlock =
  {
    _ty = (fun  -> Candid.Types.CandidType.ty);
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_EncodedBlock) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
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
            Candid.Types.Compound.serialize_element ser self.Mini_ledger_core.Block.EncodedBlock.0
          in
          let ser = tmp0 in
          let hoist17:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist18:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist17
          in
          let* _:Prims.unit =
            match hoist18 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist16:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist16)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let impl: Core.Convert.t_From t_EncodedBlock (Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global) =
  { from = fun (bytes: Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global) -> from_vec_under_impl_8 bytes }

let from_vec_under_impl_8 (bytes: Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global) : t_EncodedBlock =
  EncodedBlock (Serde_bytes.Bytebuf.from_under_impl bytes)

let into_vec_under_impl_8 (self: t_EncodedBlock) : Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global =
  Alloc.Slice.to_vec_under_impl (Core.Ops.Deref.Deref.deref (Core.Ops.Deref.Deref.deref self
              .Mini_ledger_core.Block.EncodedBlock.0
          <:
          Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global)
      <:
      slice u8)

let as_slice_under_impl_8 (self: t_EncodedBlock) : slice u8 =
  Core.Ops.Deref.Deref.deref (Core.Ops.Deref.Deref.deref self.Mini_ledger_core.Block.EncodedBlock.0
      <:
      Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global)

let size_bytes_under_impl_8 (self: t_EncodedBlock) : usize =
  Alloc.Vec.len_under_impl_1 (Core.Ops.Deref.Deref.deref self.Mini_ledger_core.Block.EncodedBlock.0
      <:
      Alloc.Vec.t_Vec u8 Alloc.Alloc.t_Global)

class t_BlockType (v_Self: Type) = {
  transaction:Type;
  transaction_implements_t_Sized:Core.Marker.t_Sized _;
  from_transaction:
      Core.Option.t_Option (t_HashOf t_EncodedBlock) ->
      _ ->
      Mini_ledger_core.Timestamp.t_TimeStamp
    -> self;
  encode:self -> t_EncodedBlock;
  decode:t_EncodedBlock -> Core.Result.t_Result self Alloc.String.t_String;
  block_hash:t_EncodedBlock -> t_HashOf t_EncodedBlock;
  parent_hash:self -> Core.Option.t_Option (t_HashOf t_EncodedBlock);
  timestamp:self -> Mini_ledger_core.Timestamp.t_TimeStamp
}