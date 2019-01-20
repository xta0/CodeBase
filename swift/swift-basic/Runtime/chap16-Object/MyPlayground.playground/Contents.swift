import ObjectiveC.runtime

//not interoperable with obj-c
class MyObject{
    var myData = "data"
    func myFunc(x:Int)->Int {
        print(x);
        return x;
    }
}

//swift object has a default Ivar: magic and a isa pointer
let array = [0,1,2,3] //'as AnyObject', swift array
print(type(of: array))
import Foundation
let objc_array: AnyObject = [0,1,"a"] as AnyObject;
print(type(of: objc_array)) //"_SwiftDeferredNSArray\n"
print(objc_array)
//error
//print(array == objc_array);

//@convention ?
//@convention(swift)
//@convention(c)

//
//CFunctionPointer<>
//swift 2.x
//(@convention(c) (UnsafeMutablePointer<Void>, Float) -> Int).self;

//swift 3.x
//function type
typealias CFuntion = @convention(c) (UnsafeMutableRawPointer, Float) -> Int;
let fun = CFuntion.self;

//block type
//@convention(block)

//Runtime Introspection
//var propertyCount:UInt32 = 0
//var properties: UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(MyObject.self, &propertyCount)!
//
//for i in 0..<propertyCount {
//    let nameChar = property_getName(properties[Int(i)])
//    let nameStr = NSString (cString: nameChar, encoding: String.Encoding.utf8.rawValue);
//    print("Property: \(nameStr)" )
////    print("Property" + String.fromCString(property_getName(properties[Int(i)]))!)
//}

//mirror and reflect ?

//
let myString = "FOoBar" as NSString
print(myString.description)
let myBlock: @convention(block)(String)->String = { (sself:String) -> (String) in
    return sself + " Block Called";
}
print(myBlock("abc"));

let myIMP = imp_implementationWithBlock(unsafeBitCast(myBlock, to: AnyObject.self))

//nsinvocation does not exist
//swroute
