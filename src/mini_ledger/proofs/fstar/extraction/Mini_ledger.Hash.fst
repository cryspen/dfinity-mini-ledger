module Mini_ledger.Hash
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

let t_Hash = array u8 32sz

let hash_cbor (bytes: slice u8) : Core.Result.t_Result (array u8 32sz) Alloc.String.t_String =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* (value: Ciborium.Value.t_Value):Ciborium.Value.t_Value
      =
        match
          Core.Ops.Try_trait.Try.branch (Core.Result.map_err_under_impl (Ciborium.De.from_reader bytes

                  <:
                  Core.Result.t_Result Ciborium.Value.t_Value (Ciborium.De.Error.t_Error _))
                (fun e -> Alloc.String.ToString.to_string e <: Alloc.String.t_String)
              <:
              Core.Result.t_Result Ciborium.Value.t_Value Alloc.String.t_String)
        with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist136:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                  residual
                <:
                Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist136)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      Core.Ops.Control_flow.ControlFlow_Continue (hash_value value))

type t_Sha256 = { f_state:Sha2.Sha256.t_Sha256 }

let new_under_impl: t_Sha256 = Core.Default.Default.v_default

let write_under_impl (self: t_Sha256) (data: slice u8) : t_Sha256 =
  let self:t_Sha256 =
    {
      self with
      Mini_ledger.Hash.Sha256.f_state
      =
      Digest.Digest.Digest.update self.Mini_ledger.Hash.Sha256.f_state data
    }
  in
  self

let finish_under_impl (self: t_Sha256) : array u8 32sz =
  Core.Convert.Into.into (Digest.Digest.Digest.finalize self.Mini_ledger.Hash.Sha256.f_state
      <:
      Generic_array.t_GenericArray u8 _)

let hash_under_impl (data: slice u8) : array u8 32sz =
  let hasher:Sha2.Sha256.t_Sha256 = Digest.Digest.Digest.v_new in
  let hasher:Sha2.Sha256.t_Sha256 = Digest.Digest.Digest.update hasher data in
  Core.Convert.Into.into (Digest.Digest.Digest.finalize hasher <: Generic_array.t_GenericArray u8 _)

let hash_value (value: Ciborium.Value.t_Value)
    : Core.Result.t_Result (array u8 32sz) Alloc.String.t_String =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (match value with
      | Ciborium.Value.Value_Integer int ->
        let (v: i128):i128 = Core.Convert.Into.into int in
        let* _:Prims.unit =
          if v <. pub_i128 0sz
          then
            let* hoist137:Rust_primitives.Hax.t_Never =
              Core.Ops.Control_flow.ControlFlow.v_Break (Core.Result.Result_Err
                  (Alloc.String.ToString.to_string "RI hash is not defined for negative integers"
                    <:
                    Alloc.String.t_String))
            in
            Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist137)
          else Core.Ops.Control_flow.ControlFlow_Continue ()
        in
        Core.Ops.Control_flow.ControlFlow_Continue
        (let buf:array u8 19sz = Rust_primitives.Hax.repeat 0uy 19sz in
          let n:i128 = v in
          let done:bool = false in
          let msb:usize = 0sz in
          let buf, done, msb, n:(array u8 19sz & bool & usize & Prims.unit) =
            Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter
                  ({ Core.Ops.Range.Range.f_start = 0sz; Core.Ops.Range.Range.f_end = 19sz })
                <:
                _)
              (buf, done, msb, n)
              (fun (buf, done, msb, n) i ->
                  if ~.done <: bool
                  then
                    let byte:u8 = cast (n &. pub_i128 127sz) in
                    let n:Prims.unit = n <<. 7l in
                    if n =. pub_i128 0sz
                    then
                      let buf:array u8 19sz = Rust_primitives.Hax.update_at buf i byte in
                      let msb:usize = i in
                      let done:bool = true in
                      buf, done, msb, n
                    else
                      let buf:array u8 19sz =
                        Rust_primitives.Hax.update_at buf i (byte |. 128uy <: u8)
                      in
                      buf, done, msb, n
                  else buf, done, msb, n)
          in
          Core.Result.Result_Ok
          (hash_under_impl (buf.[ { Core.Ops.Range.RangeToInclusive.f_end = msb } ] <: slice u8)))
      | Ciborium.Value.Value_Bytes bytes ->
        Core.Ops.Control_flow.ControlFlow_Continue
        (Core.Result.Result_Ok
          (hash_under_impl (Core.Ops.Deref.Deref.deref bytes <: slice u8) <: array u8 32sz))
      | Ciborium.Value.Value_Text text ->
        Core.Ops.Control_flow.ControlFlow_Continue
        (Core.Result.Result_Ok
          (hash_under_impl (Alloc.String.as_bytes_under_impl text <: slice u8) <: array u8 32sz))
      | Ciborium.Value.Value_Tag v__tag value ->
        Core.Ops.Control_flow.ControlFlow_Continue
        (hash_value value <: Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
      | Ciborium.Value.Value_Array values ->
        Core.Ops.Control_flow.ControlFlow_Continue
        (let hasher:t_Sha256 = new_under_impl in
          let hasher:t_Sha256 =
            Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter
                  (Core.Slice.iter_under_impl (Core.Ops.Deref.Deref.deref values
                        <:
                        slice Ciborium.Value.t_Value)
                    <:
                    Core.Slice.Iter.t_Iter Ciborium.Value.t_Value)
                <:
                _)
              hasher
              (fun hasher v ->
                  let* h:array u8 32sz =
                    match
                      Core.Ops.Try_trait.Try.branch (hash_value v
                          <:
                          Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
                    with
                    | Core.Ops.Control_flow.ControlFlow_Break residual ->
                      let* hoist138:Rust_primitives.Hax.t_Never =
                        Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                              residual
                            <:
                            Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
                      in
                      Core.Ops.Control_flow.ControlFlow_Continue
                      (Rust_primitives.Hax.never_to_any hoist138)
                    | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                      Core.Ops.Control_flow.ControlFlow_Continue v_val
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (let hasher:t_Sha256 =
                      write_under_impl hasher (Rust_primitives.unsize h <: slice u8)
                    in
                    hasher))
          in
          Core.Result.Result_Ok (finish_under_impl hasher))
      | Ciborium.Value.Value_Map map ->
        Core.Ops.Control_flow.ControlFlow_Continue
        (let hpairs:Alloc.Vec.t_Vec (array u8 32sz & array u8 32sz) Alloc.Alloc.t_Global =
            Alloc.Vec.with_capacity_under_impl (Alloc.Vec.len_under_impl_1 map <: usize)
          in
          let hpairs:Alloc.Vec.t_Vec (array u8 32sz & array u8 32sz) Alloc.Alloc.t_Global =
            Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter
                  (Core.Slice.iter_under_impl (Core.Ops.Deref.Deref.deref map
                        <:
                        slice (Ciborium.Value.t_Value & Ciborium.Value.t_Value))
                    <:
                    Core.Slice.Iter.t_Iter (Ciborium.Value.t_Value & Ciborium.Value.t_Value))
                <:
                _)
              hpairs
              (fun hpairs (k, v) ->
                  let* hoist142:array u8 32sz =
                    Core.Ops.Control_flow.ControlFlow_Continue
                    (match
                        Core.Ops.Try_trait.Try.branch (hash_value k
                            <:
                            Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
                      with
                      | Core.Ops.Control_flow.ControlFlow_Break residual ->
                        let* hoist139:Rust_primitives.Hax.t_Never =
                          Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                                residual
                              <:
                              Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
                        in
                        Core.Ops.Control_flow.ControlFlow_Continue
                        (Rust_primitives.Hax.never_to_any hoist139)
                      | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                        Core.Ops.Control_flow.ControlFlow_Continue v_val)
                  in
                  let* hoist141:array u8 32sz =
                    match
                      Core.Ops.Try_trait.Try.branch (hash_value v
                          <:
                          Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
                    with
                    | Core.Ops.Control_flow.ControlFlow_Break residual ->
                      let* hoist140:Rust_primitives.Hax.t_Never =
                        Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                              residual
                            <:
                            Core.Result.t_Result (array u8 32sz) Alloc.String.t_String)
                      in
                      Core.Ops.Control_flow.ControlFlow_Continue
                      (Rust_primitives.Hax.never_to_any hoist140)
                    | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                      Core.Ops.Control_flow.ControlFlow_Continue v_val
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (let hoist143:(array u8 32sz & array u8 32sz) = hoist142, hoist141 in
                    let hoist144:Alloc.Vec.t_Vec (array u8 32sz & array u8 32sz)
                      Alloc.Alloc.t_Global =
                      Alloc.Vec.push_under_impl_1 hpairs hoist143
                    in
                    hoist144))
          in
          let hpairs:Alloc.Vec.t_Vec (array u8 32sz & array u8 32sz) Alloc.Alloc.t_Global =
            Core.Slice.sort_unstable_under_impl hpairs
          in
          let hasher:t_Sha256 = new_under_impl in
          let hasher:t_Sha256 =
            Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter
                  (Core.Slice.iter_under_impl (Core.Ops.Deref.Deref.deref hpairs
                        <:
                        slice (array u8 32sz & array u8 32sz))
                    <:
                    Core.Slice.Iter.t_Iter (array u8 32sz & array u8 32sz))
                <:
                _)
              hasher
              (fun hasher (khash, vhash) ->
                  let hasher:t_Sha256 =
                    write_under_impl hasher (khash.[ Core.Ops.Range.RangeFull ] <: slice u8)
                  in
                  let hasher:t_Sha256 =
                    write_under_impl hasher (vhash.[ Core.Ops.Range.RangeFull ] <: slice u8)
                  in
                  hasher)
          in
          Core.Result.Result_Ok (finish_under_impl hasher))
      | Ciborium.Value.Value_Bool _ ->
        Core.Ops.Control_flow.ControlFlow_Continue
        (Core.Result.Result_Err
          (Alloc.String.ToString.to_string "RI hash is not defined for booleans"
            <:
            Alloc.String.t_String))
      | Ciborium.Value.Value_Null  ->
        Core.Ops.Control_flow.ControlFlow_Continue
        (Core.Result.Result_Err
          (Alloc.String.ToString.to_string "RI hash is not defined for NULL"
            <:
            Alloc.String.t_String))
      | Ciborium.Value.Value_Float _ ->
        Core.Ops.Control_flow.ControlFlow_Continue
        (Core.Result.Result_Err
          (Alloc.String.ToString.to_string "RI hash is not defined for floats"
            <:
            Alloc.String.t_String))
      | _ ->
        Core.Ops.Control_flow.ControlFlow_Continue
        (let res:Alloc.String.t_String =
            Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list =
                          ["unsupported value type: "]
                        in
                        FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
                        Rust_primitives.Hax.array_of_list list)
                    <:
                    slice string)
                  (Rust_primitives.unsize (let list =
                          [Core.Fmt.Rt.new_debug_under_impl_1 value <: Core.Fmt.Rt.t_Argument]
                        in
                        FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
                        Rust_primitives.Hax.array_of_list list)
                    <:
                    slice Core.Fmt.Rt.t_Argument)
                <:
                Core.Fmt.t_Arguments)
          in
          Core.Result.Result_Err res))