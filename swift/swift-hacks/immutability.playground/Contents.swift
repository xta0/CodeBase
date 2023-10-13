import UIKit

struct PersonStruct {
    var name: String
    var age: Int
}

final class PersonClass {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// variable struct: changing property and changing value OK
var taylor1 = PersonStruct(name: "Taylor Swift", age: 26)
taylor1.name = "Justin Bieber"
taylor1 = PersonStruct(name: "Justin Bieber", age: 22)

// constant struct: changing property or value not allowed
let taylor2 = PersonStruct(name: "Taylor Swift", age: 26)
//taylor2.name = "Justin Bieber"
//taylor2 = PersonStruct(name: "Justin Bieber", age: 22)

// variable object: changing property and reference OK
var taylor3 = PersonClass(name: "Taylor Swift", age: 26)
taylor3.name = "Justin Bieber"
taylor3 = PersonClass(name: "Justin Bieber", age: 22)

// constant object: changing property OK, changing reference not allowed
let taylor4 = PersonClass(name: "Taylor Swift", age: 26)
taylor4.name = "Justin Bieber"
//taylor4 = PersonClass(name: "Justin Bieber", age: 22)”
