module Mini_ledger_core.Balances
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open FStar.Mul
open Hacspec.Lib
open Hacspec_lib_tc

type balanceError_t = { balance:Mini_ledger_core.Tokens.tokens_t }

type balances_t = {
  store:s;
  token_pool:Mini_ledger_core.Tokens.tokens_t;
  _marker:Core.Marker.phantomData_t accountid
}

let _: Prims.unit = ()

let _: Prims.unit = ()

let impl
      (#accountid #s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.sized_t accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.sized_t s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.clone_t accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.default_t s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: balancesStore_t s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.sized_t accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.sized_t s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.clone_t accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.default_t s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: balancesStore_t s accountid)
    : Core.Default.Default (balances_t accountid s) =
  {
    default
    =
    fun
      (#accountid: Type)
      (#s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.sized_t accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.sized_t s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.clone_t accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.default_t s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: balancesStore_t s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.sized_t accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.sized_t s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.clone_t accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.default_t s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: balancesStore_t s accountid)
      ->
      new_
  }