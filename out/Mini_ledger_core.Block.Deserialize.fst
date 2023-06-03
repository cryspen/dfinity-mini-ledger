module Mini_ledger_core.Block.Deserialize
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open FStar.Mul
open Hacspec.Lib
open Hacspec_lib_tc

type hashOfVisitor_t = { phantom:Core.Marker.phantomData_t t }