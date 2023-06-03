module Mini_ledger_core.Timestamp._.Deserialize
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open FStar.Mul
open Hacspec.Lib
open Hacspec_lib_tc

type __Field =
  | __field0 : __Field
  | __ignore : __Field

type __FieldVisitor = | __FieldVisitor : __FieldVisitor

let impl: Serde.De.Deserialize __Field_t =
  {
    deserialize
    =
    fun (__deserializer: __d) -> Serde.De.Deserializer.deserialize_identifier __deserializer ({  })
  }

type __Visitor_t = {
  marker:Core.Marker.phantomData_t Mini_ledger_core.Timestamp.timeStamp_t;
  lifetime:Core.Marker.phantomData_t Prims.unit
}

let fIELDS: FStar.Seq.seq Prims.string = Hacspec.Lib.unsize ["timestamp_nanos"]