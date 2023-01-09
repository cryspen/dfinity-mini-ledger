# mini_ledger

This is a simplified version of the ICRC-1 ledger that can be used to gauge verification tools.

In particular, this version:
 - can be built using ``cargo build`` ()has no dependencies on the main IC repo)
 - doesn't archive blocks, avoiding async blocks and traits (all messages are processed atomically)
 - aside from main.rs, it avoids interior mutability

It still exercises a number of Rust/Cargo and other features:
 - It uses lots of mutable references
 - It's heavily abstracted, with generics, traits, and trait bounds everywhere
 - It uses macros (to derive things like default implementations, but also serialization/deserialization code)
 - It uses a Cargo workspace
 - It relies on a number of standard library collections (vectors, maps, queues)
 - It uses hashing (relying on an external SHA-256 library to do the legwork)

