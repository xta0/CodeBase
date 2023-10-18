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
// provides a defult implementation
extension MyProtocol {
    func extensionMethod() {
        print("In Protocol")
    }
}


struct MyStruct: MyProtocol {}

extension MyStruct {
    func extensionMethod() {
        print("In Struct")
    }
}

let myStruct = MyStruct()
let myProto: MyProtocol = MyStruct()

myStruct.extensionMethod() // -> “In Struct”
myProto.extensionMethod() // -> "In Protocol"

