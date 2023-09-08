#[allow(dead_code)]
#[allow(unused_variables)]

/**
 * Rust ownership rules
 *
 * 1. Each value in Rust has an owner.
 * 2. There can only be one owner at a time.
 * 3. When the owner goes out of scope, the value will be dropped.
 *
 */
pub fn memory() {
    println!("---------Memory-----------");
    ownership();
    reference();
}

fn ownership() {
    let v = vec![1, 2, 3];
    let v2 = v; // this is move, not copy. ownership will be tranferred to v2
                // println!("v: {:?}", v); // compiler will throw an error here
    let a = 10;
    let b = a; // this is ok because a and b are value type. values get copied.

    let mut input = String::new();
    borrow(&mut input);
    println!("after borrow: {}", input);
    not_borrow(input);
    mutable_borrow();
}

// the function will borrow the string, not own it.
fn borrow(s: &mut String) {
    s.push_str("dummy")
}

// the ownership will be transfered to s
fn not_borrow(s: String) {
    println!("not borrow: {}", s);
}

fn mutable_borrow() {
    let mut s = String::new();
    let s1 = &s; //ok
                 // let s2 = &mut s; //wrong because s cannot be borrowed mutablly
}

// To pass an object to a function without transfering the ownership, we need to use references
// references allows us to refer a value without taking the ownership from it.
fn reference() {
    println!("---------Reference-----------");
    let x = 5;
    let y = &x; // y is an immutable reference to x

    println!("x = {}", x);
    println!("y = {}", y);

    let mut z = 10;
    let w = &mut z; // w is a mutable reference to z

    *w += 5; // modify the value of z through the reference w

    println!("z = {}", z);
}
