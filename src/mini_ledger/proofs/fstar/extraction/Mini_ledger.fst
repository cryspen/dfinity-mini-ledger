module Mini_ledger
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

let v___export_service: Alloc.String.t_String =
  let service:Alloc.Vec.t_Vec (Alloc.String.t_String & Candid.Types.Internal.t_Type)
    Alloc.Alloc.t_Global =
    Alloc.Vec.new_under_impl
  in
  let env:Candid.Types.Internal.t_TypeContainer = Candid.Types.Internal.new_under_impl_3 in
  let service:Alloc.Vec.t_Vec (Alloc.String.t_String & Candid.Types.Internal.t_Type)
    Alloc.Alloc.t_Global =
    Core.Slice.sort_unstable_by_key_under_impl service
      (fun (name, _) -> Core.Clone.Clone.clone name <: Alloc.String.t_String)
  in
  let ty:Candid.Types.Internal.t_Type = Candid.Types.Internal.Type_Service service in
  let actor:Core.Option.t_Option Candid.Types.Internal.t_Type = Core.Option.Option_Some ty in
  let result:Alloc.String.t_String =
    Candid.Bindings.Candid.compile env.Candid.Types.Internal.TypeContainer.f_env actor
  in
  Alloc.Fmt.format (Core.Fmt.new_v1_under_impl_2 (Rust_primitives.unsize (let list = [""] in
              FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
              Rust_primitives.Hax.array_of_list list)
          <:
          slice string)
        (Rust_primitives.unsize (let list =
                [Core.Fmt.Rt.new_display_under_impl_1 result <: Core.Fmt.Rt.t_Argument]
              in
              FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 1);
              Rust_primitives.Hax.array_of_list list)
          <:
          slice Core.Fmt.Rt.t_Argument)
      <:
      Core.Fmt.t_Arguments)

let main: Prims.unit = ()