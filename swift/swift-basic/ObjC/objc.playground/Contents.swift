import Foundation
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


/*
 ==================
 "Any"&"AnyObject"
 ==================
 */

/*
 [Any]: can represent an instance of any type at all, including function types and optional types.
 [AnyObject]: can represent an instance of any class type.
 */
var anyArray:[Any] = [1,2,"hello",true]
print(anyArray) //[1, 2, "hello", true] all value type

var anyObjectArray:[AnyObject] = [1 as AnyObject, 2 as AnyObject, "hello" as AnyObject, true as AnyObject]
print(anyObjectArray) //[1, 2, hello, 1] nsnumber,nsstring

for ele in anyObjectArray{
    if ele is NSNumber{
        print("\(ele) is NSNumber!")
    }else if ele is NSString{
        print("\(ele) is NSString!")
    }
}
/*
 Types that can be converted between Objective-C and Swift are referred to as bridged types.
 Anywhere you can use a bridged Objective-C reference type, you can use the Swift value type instead.
 */
var hello2 = anyObjectArray[2]
//call nasstring's method
if let l1 = hello2.length{
    print(l1)
}
//call string's method
var hello1:String = anyArray[2] as! String
print(hello1.count)


let name = "Alex"
print(name.count)
print((name as NSString).length)

//swift 3.0之后，AnyObject不是必要的，Any完全可以替代AnyObejct
//Any可以将Swift任何类型映射为对应的OC类型，对应的OC中的id类型映射为Swift的Any （Swift 2.0中id映射为AnyObject，3.0统一映射为Any）
//使用AnyObject的场景需要明确指定类型
