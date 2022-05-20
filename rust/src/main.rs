#[allow(dead_code)]
#[allow(unused_variables)]
mod ds;
mod funcs;
mod sh;
mod stl;
mod str;
mod traits;
use std::mem;

const M: u64 = 128; // similar to c++ macro
static N: u32 = 256; // c++ static var
static mut X: u64 = 512;
fn fundamental_data_types() {
    // u8, u16, u32, u64, i8, i16, ...
    let a: u8 = 123; // a is immutable
    let mut b: i8 = 0; // mutable keyword
    b = 42;
    println!("b = {}", b);
    let c = 12345678;
    println!("c taks up {} bytes", mem::size_of_val(&c));

    // usize isize
    let z: isize = 123;
    let size_of_z = mem::size_of_val(&z);
    println!(
        "z = {}, takes up {} bytes, {}-bit OS",
        z,
        size_of_z,
        size_of_z * 8
    );

    // char -> 4 byte
    let d: char = 'x';
    println!("{} is a char, size = {} bytes", d, mem::size_of_val(&d));

    // fp32 fp64 -> 4 byte
    let e: f64 = 2.5;
    println!("{} is a float, size = {} bytes", e, mem::size_of_val(&e));

    // bool -> 1 byte
    let g: bool = false;
    println!("{} is a bool, size = {} bytes", g, mem::size_of_val(&g));
}

fn unsafe_mutation() {
    unsafe {
        X = 123;
    }
}

fn if_statement() {
    let temp = 15;
    if temp > 20 {
        println!("hot");
    } else if temp > 15 {
        println!("normal");
    } else {
        println!("cold");
    }
    let day = if temp > 20 { "sunny" } else { "cloudy" };
    println!("{}", day);

    // nested if
    let x = if temp > 20 {
        if temp > 30 {
            "very"
        } else {
            "hot"
        }
    } else if temp < 10 {
        "cold"
    } else {
        "freeze"
    };
    println!("{}", x)
}

fn while_and_loop() {
    let mut x = 1;
    while x < 1000 {
        x *= 2;
        println!("x = {}", x);
    }
    let mut y = 1;
    loop
    // while true { ... }
    {
        y *= 2;
        if y >= 1024 {
            break;
        }
    }
}

fn for_loop() {
    for x in 1..11 {
        //[1, 11)
        if x == 10 {
            break;
        }
    }
    for (i, x) in (30..41).enumerate() {
        println!("{} : {}", i, x);
    }
}

// match needs to catch all cases
fn matches() {
    let country_code = 44;
    let country = match country_code {
        44 => "UK",
        46 => "Sweden",
        7 => "Russia",
        1..=1000 => "unknown",
        _ => "invalid",
    };
    println!("the country with code {} is {}", country_code, country);
}

fn main() {
    println!("Hello, Rust! {}", 10);
    fundamental_data_types();
    unsafe_mutation();
    sh::stack_and_heap();
    if_statement();
    while_and_loop();
    for_loop();
    matches();
    ds::enums();
    ds::unions();
    ds::options();
    ds::arrays();
    ds::slices();
    stl::vectors();
    stl::hashmaps();
    stl::hashsets();
    str::strings();
    funcs::funcs();
    funcs::closures();
    traits::traits();
    traits::builtin_traits();
}
