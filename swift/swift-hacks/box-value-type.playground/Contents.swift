import UIKit

/*
 Boxing and unboxing can be helpful if you’re facing significant referencing counting performance issues.
 If a struct contains an object as one of its properties, that object is reference counted
 
 For something small this isn’t a problem, but if your struct has lots of objects as properties – let’s say 10
 then suddenly ARC has to do 10 reference increments and decrements each time your struct is copied. In this
 situation, boxing your struct in a wrapper object simplifies things dramatically, because ARC would only need to
 manipulate the reference count for the box, not for all the individual properties.
 */

struct Person {
    var name: String
    var age: Int
    var favoriteIceCream: String
}

let taylor = Person(name: "James", age: 8, favoriteIceCream: "Chocoloate")

// Box the value type into a ref type, so the value type can be shared across
final class Box<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}

let box = Box(value: taylor)





