#[allow(dead_code)]
#[allow(unused_variables)]
use std::mem;
struct Point {
    x: f64,
    y: f64,
}

enum Color {
    Red,
    Green,
    Blue,
    RgbColor(u8, u8, u8),
}

// 32 bits
union IntOrFloat {
    i: i32,
    f: f32,
}

pub fn enums() {
    let c: Color = Color::Red;
    match c {
        Color::Red => println!("r"),
        Color::Green => println!("g"),
        Color::Blue => println!("b"),
        Color::RgbColor(0, 0, 0) => println!("black"),
        Color::RgbColor(r, g, b) => println!("rgb{},{},{}", r, g, b),
    }
}

pub fn unions() {
    let mut iof = IntOrFloat { i: 123 };
    iof.i = 234;

    let value = unsafe { iof.i };
    println!("iof.i = {}", value);

    unsafe {
        match iof {
            IntOrFloat { i: 42 } => {
                println!("matched for i");
            }
            IntOrFloat { f } => {
                println!("value of {}", f);
            }
        }
    }
}

// Option<T> -> Some(v) | None
pub fn options() {
    let x = 3.0;
    let y = 0.0;
    let result = if y != 0.0 { Some(x / y) } else { None };

    match result {
        Some(z) => println!("{}/{} = {}", x, y, z),
        None => println!("cannot divide by zero"),
    }

    if let Some(z) = result {
        println!("result = {}", z);
    }
}

// array is static
pub fn arrays() {
    //static array -> i32, 5 elelments
    let mut a: [i32; 5] = [1, 2, 3, 4, 5];
    println!("len(a) ={}", a.len());
    a[0] = 100;
    println!("{:?}", a); // print all elements
    if a != [1, 2, 3, 4, 5] {
        //length has to match
        println!("does not match");
    }
    let b = [1; 10]; // 10 elements of 1
    for i in 0..b.len() {
        println!("{}", b[i]);
    }
    print!("b took up {} bytes", mem::size_of_val(&b)); // 40bytes

    // multi-dimensional array
    let mtx: [[f32; 3]; 2] = [[1.0, 2.0, 3.0], [1.0, 2.0, 3.0]];
}

// reference to the original slice
fn use_slice(slice: &mut [i32]) {
    println!("len = {}", slice.len());
    slice[1] = 32; //modify the original array
}
pub fn slices() {
    let mut data = [1, 2, 3, 4, 5];
    use_slice(&mut data[1..4]);
    println!("{:?}", data);
}

fn sum_and_product(x: i32, y: i32) -> (i32, i32) {
    return (x + y, x * y);
}

pub fn tuples() {
    let x = 3;
    let y = 4;
    let sp = sum_and_product(x, y);
    println!("sp={:?}", sp);
    println!("sp.0: {}", sp.0);
    println!("sp.1: {}", sp.1);

    // destructuring
    let (a, b) = sp;
    let foo = (1, "43", [1, 2, 3]);
    let bar = (1,);
}

struct GPoint<T, V> {
    x: T,
    y: V,
}

pub fn generics() {
    let pt: GPoint<i32, f32> = GPoint { x: 0, y: 0.0 };
}
