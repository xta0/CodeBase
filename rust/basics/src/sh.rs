#![allow(dead_code)]

use std::mem;
struct Point {
    x: f64, // 8 bytes
    y: f64, // 8 bytes
}

fn origin() -> Point {
    return Point { x: 0.0, y: 0.0 };
}

pub fn stack_and_heap() {
    let p1 = origin();
    let p2 = Box::new(origin());
    println!("p1 takes up {} bytes", mem::size_of_val(&p1)); //16 bytes
    println!("p2 takes up {} bytes", mem::size_of_val(&p2)); //8 bytes (pointer size)
}
