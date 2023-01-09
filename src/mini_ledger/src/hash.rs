use ciborium::value::Value;
use sha2::{Digest, Sha256 as Sha256Impl};

pub type Hash = [u8; 32];

/// Implements representation-independent hashing for CBOR values.
/// See https://internetcomputer.org/docs/current/references/ic-interface-spec/#hash-of-map
pub fn hash_cbor(bytes: &[u8]) -> Result<Hash, String> {
    let value: Value = ciborium::de::from_reader(bytes).map_err(|e| e.to_string())?;
    hash_value(&value)
}

#[derive(Default)]
pub struct Sha256 {
    state: Sha256Impl,
}

impl Sha256 {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn write(&mut self, data: &[u8]) {
        self.state.update(data);
    }

    pub fn finish(self) -> [u8; 32] {
        self.state.finalize().into()
    }

    pub fn hash(data: &[u8]) -> [u8; 32] {
        let mut hasher = Sha256Impl::new();
        hasher.update(data);
        hasher.finalize().into()
    }
}

fn hash_value(value: &Value) -> Result<Hash, String> {
    match value {
        Value::Integer(int) => {
            let v: i128 = (*int).into();
            if v < 0 {
                return Err("RI hash is not defined for negative integers".to_string());
            }

            // We need at most ⌈ 128 / 7 ⌉ = 19 bytes to encode a 128 bit
            // integer in LEB128.
            let mut buf = [0u8; 19];
            let mut n = v;
            let mut i = 0;

            loop {
                let byte = (n & 0x7f) as u8;
                n >>= 7;

                if n == 0 {
                    buf[i] = byte;
                    break;
                } else {
                    buf[i] = byte | 0x80;
                    i += 1;
                }
            }

            Ok(Sha256::hash(&buf[..=i]))
        }
        Value::Bytes(bytes) => Ok(Sha256::hash(bytes)),
        Value::Text(text) => Ok(Sha256::hash(text.as_bytes())),
        Value::Tag(_tag, value) => hash_value(value),
        Value::Array(values) => {
            let mut hasher = Sha256::new();
            for v in values.iter() {
                let h = hash_value(v)?;
                hasher.write(&h);
            }
            Ok(hasher.finish())
        }
        Value::Map(map) => {
            let mut hpairs = Vec::with_capacity(map.len());
            for (k, v) in map.iter() {
                hpairs.push((hash_value(k)?, hash_value(v)?));
            }

            hpairs.sort_unstable();

            let mut hasher = Sha256::new();
            for (khash, vhash) in hpairs.iter() {
                hasher.write(&khash[..]);
                hasher.write(&vhash[..]);
            }
            Ok(hasher.finish())
        }
        Value::Bool(_) => Err("RI hash is not defined for booleans".to_string()),
        Value::Null => Err("RI hash is not defined for NULL".to_string()),
        Value::Float(_) => Err("RI hash is not defined for floats".to_string()),
        _ => Err(format!("unsupported value type: {:?}", value)),
    }
}
