//------------------------------------------------------
/*
 POP:
 The concept of pop is largely based on the Retroactive Modeling technique,
 where we can add new functionality to existing types.
 
 In Swift, this is done by using protocol extensions
 */

protocol MyProtocol {
//    func extensionMethod()
}
struct MyStruct: MyProtocol {
}
extension MyStruct {
    func extensionMethod() {
        print("In Struct")
    }
}
// provides a defult implementation
extension MyProtocol {
    func extensionMethod() {
        print("In Protocol")
    }
}
struct MyStruct2 : MyProtocol {}

let myStruct = MyStruct()
let myProto: MyProtocol = myStruct as MyProtocol

myStruct.extensionMethod() // -> “In Struct”
myProto.extensionMethod() // -> "In Protocol"


//-------------------------------------------------------
// Retroactive Modeling

extension Array {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}
let guests = ["1", "2"]
if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

/**
 here we add an extension method to an array. However, we want the same extension method to be available to all collections.
 We can do this by extending the Collection protocol.
 */

