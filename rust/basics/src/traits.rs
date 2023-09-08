// trait is similar to protocols
use std::fmt::Debug;

trait Animal {
    fn create(name: &'static str) -> Self;
    fn name(&self) -> &'static str;
    fn talk(&self) {
        println!("{} cannot talk", self.name());
    }
}

// let compiler generate the default impl
// for the Debug trait
#[derive(Debug)]
struct Human {
    name: &'static str,
}

// implement trait functions
impl Animal for Human {
    fn create(name: &'static str) -> Human {
        Human { name: name }
    }
    fn name(&self) -> &'static str {
        self.name
    }
    fn talk(&self) {
        println!("{} says hello", self.name());
    }
}

trait Summable<T> {
    fn sum(&self) -> T;
}
// extend the functionalities using trait
impl Summable<i32> for Vec<i32> {
    fn sum(&self) -> i32 {
        let mut result: i32 = 0;
        for x in self {
            result += *x;
        }
        return result;
    }
}

// trait as parameter
// a needs to implement both Animal and Debug trait
fn print_info(a: &(impl Animal + Debug)) {
    println!("a.name: {}", a.name());
}

fn print_info2<T: Animal + Debug>(a: T, b: T) {
    println!("{:?}, {:?}", a, b);
}

fn print_info3<T>(a: T)
where
    T: Animal + Debug,
{
    println!("{:?}", a);
}

pub fn traits() {
    let h1 = Human { name: "John" };
    h1.talk();
    let h2 = Human::create("James");
    h2.talk();
    // Compiler can choose which create function to call
    // based on the type of `h3`
    let h3: Human = Animal::create("Aiden");
    h3.talk();

    let v = vec![1, 2, 3];
    println!("sum: {}", v.sum());

    print_info(&h1);
    print_info2(h1, h2);
    print_info3(h3);
}

// impl Human {
//     fn new<S>(name: S) -> Human
//     where
//         S: Into<String>,
//     {
//         Human { name: name.into() }
//     }
// }

// pub fn builtin_traits() {
//     // let name = String::from("Kevin");
//     let h1 = Human::new("Kevin");
//     print_info(&h1);
// }
