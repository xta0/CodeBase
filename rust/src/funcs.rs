#[allow(dead_code)]
#[allow(unused_variables)]

fn increase(x: &mut i32) {
    *x += 1;
}

struct Point {
    x: f64,
    y: f64,
}

// use impl to define methods
impl Point {
    fn sum(&self) -> f64 {
        return self.x + self.y;
    }
}

fn say_hello() {
    println!("hello!");
}

pub fn closures() {
    let x1 = 1;
    // x is passed by value
    let lmd1 = |x| x + 1;
    let y1 = lmd1(x1);
    println!("closure 1: (x:{}, y:{})", x1, y1);

    //x is passed by ref
    let mut x2 = 1;
    let lmd2 = |x: &mut i32| *x += 1;
    lmd2(&mut x2);
    println!("closure 2: (x:{})", x2);
}

pub fn funcs() {
    let mut x = 1;
    increase(&mut x);
    println!("x: {}", x);
    let pt = Point { x: 1.0, y: 2.0 };
    let s = pt.sum();
    println!("sum: {}", s);

    // functions are first class citizen
    let sh = say_hello;
    sh();

    let plus_one = |x: i32| -> i32 { x + 1 };
    let a = 6;
    println!("{}+1={}", a, plus_one(a));
}
