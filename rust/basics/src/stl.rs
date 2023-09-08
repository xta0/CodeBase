#[allow(dead_code)]
#[allow(unused_variables)]
use std::collections::HashMap;
use std::collections::HashSet;
use std::mem;

pub fn vectors() {
    let mut a = Vec::new();
    a.push(1);
    a.push(2);
    a.push(3);
    println!("a={:?}", a);
    let idx: usize = 0;
    println!("a[0]={}", a[idx]);
    let x = a.get(4); //returns an option type
    match x {
        Some(x) => println!("a[4] = {}", x),
        None => println!("no such element"),
    }
    for x in &a {
        println!("x = {}", x);
    }
    if let Some(y) = a.pop() {
        // returns an option
        println!("y = {}", y);
    }
}

pub fn hashmaps() {
    let mut shapes = HashMap::new();
    shapes.insert(String::from("triangle"), 3);
    shapes.insert(String::from("square"), 4);
    println!("square: {}", shapes["square"]);

    for (key, value) in &shapes {
        println!("{}:{}", key, value);
    }
    // override the existing value
    shapes.insert("square".into(), 5);
    println!("{:?}", shapes);

    //check and override
    shapes.entry("circle".into()).or_insert(1);
    println!("{:?}", shapes);

    {
        let actual = shapes.entry("circle".into()).or_insert(2);
        *actual = 0;
        println!("{:?}", shapes);
    }
}

pub fn hashsets() {
    let mut greeks = HashSet::new();
    greeks.insert("gamma");
    greeks.insert("delta");
    println!("{:?}", greeks);
    if !greeks.contains("kappa") {
        println!("we don't have kappa");
    }
    let removed = greeks.remove("delta");
    if removed {
        println!("we removed delta");
    }

    let _1_10: HashSet<_> = (1..=10).collect();
    let _2_8: HashSet<_> = (2..=8).collect();
    if _2_8.is_subset(&_1_10) {
        println!("sub set");
    }
}

pub fn itors() {
    let v = vec![1, 2, 3];
    // &v gives the reference
    // without & means std::move in c++
    for x in &v {
        println!("{}", x);
    }

    // x is immutable reference
    // v.iter returns a const iterator
    for x in v.iter() {
        println!("{}", x);
    }

    let mut v2 = vec![1, 2, 3];
    // v2.iter_mut returns an non-const itor
    for x in v2.iter_mut() {
        *x += 1;
        println!("{}", x);
    }
}
