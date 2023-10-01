/**
 * Rust ownership rules
 * 
 * 1. Each value in Rust has an owner.
 * 2. There can only be one owner at a time.
 * 3. When the owner goes out of scope, the value will be dropped.
 * 
 */
pub fn mems(){
    let v = vec![1, 2, 3];
    let v2 = v // this is move, not copy
}