#[allow(dead_code)]
#[allow(unused_variables)]

pub fn strings() {
    // utf-8
    let s: &'static str = "hello there!";
    // &str = string slice
    // static = preallcoated constant value in data segment
    for c in s.chars().rev() {
        println!("{}", c);
    }
    //indexing
    if let Some(first_char) = s.chars().nth(0) {
        println!("first_char: {}", first_char);
    }

    // heap allocated string
    // modified version of string
    // String
    let mut letters = String::new();
    // append chars
    letters.push('a');
    let b = 'b' as u8;
    letters.push(b as char);

    //append strings
    letters.push_str("_xyz");
    println!("letters: {:?}", letters);

    // &str <-> String
    let u: &str = &letters;

    // string from str
    let s1 = String::from("hello world");

    // str to String
    let mut s2 = "hello_world".to_string();
    let s3 = s2.replace("hello", "xx");
    println!("s3: {}", s3);

    // format
    let name = "Dmitri";
    let f1 = format!("hi I'm {}", name);
    println!("greeting: {}", name);
    let hello = "hello";
    let f2 = format!("{}, {}!", hello, name);
}
