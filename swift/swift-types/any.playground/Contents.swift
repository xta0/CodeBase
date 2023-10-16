import Foundation
import UIKit

/// Any and AnyObject are special types in Swift, used for type erasure, and don’t have a direct relationship with any.

// ----------------------------------------------------------------------------
// When to use AnyObject?
// AnyObject is a protocol to which all **classes** implicitly conform. AnyObject can represent an instance of any **class**  type.

// In fact, the standard library contains a type alias AnyClass representing AnyObject.Type.

print(AnyObject.self) // Prints: AnyObject
print(AnyClass.self) // Prints: AnyObject.Type

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

// All classes, class types, or class-only protocols can use AnyObject as their concrete type. To demonstrate, you could create an array of different types:

let imageView = UIImageView(image: nil)
let viewController = UIViewController(nibName: nil, bundle: nil)

let mixedArray: [AnyObject] = [
    // We can add both `UIImageView` and `UIViewController` to the same array
    // since they both cast to `AnyObject`.
    imageView,
    viewController,

    // The `UIViewController` type conforms implicitly to `AnyObject` and can be added as well.
    UIViewController.self
]

// Only classes conform to AnyObject, meaning that you can use it to restrict protocols to be implemented by reference types only:

protocol MyProtocol: AnyObject { }

// ----------------------------------------------------------------------------
// When to use Any?
// Any: can represent an instance of any type at all, including function types and optional types.

var anyArray:[Any] = [1,2,"hello",true]
print(anyArray) //[1, 2, "hello", true] all value type

//call string's method
var hello1:String = anyArray[2] as! String
print(hello1.count)
    

let name = "Alex"
print(name.count)
print((name as! NSString).length)

//swift 3.0之后，AnyObject不是必要的，Any完全可以替代AnyObejct
//Any可以将Swift任何类型映射为对应的OC类型，对应的OC中的id类型映射为Swift的Any （Swift 2.0中id映射为AnyObject，3.0统一映射为Any）
//使用AnyObject的场景需要明确指定类型

// ----------------------------------------------------------------------------

/// When to use any?
///any is introduced in SE-335 and looks similar to Any and AnyObject but has a different purpose since you use it to indicate the use of an existential.

protocol ImageContainer {
    var name: String {get}
}
struct ImageConfigurator {
    // we indicated the use of an existential ImageContainer by marking our imageContainer property with the any keyword.
    // Marking a protocol using any will be enforced starting from Swift 6 as it will indicate the performance impact of using a protocol in this way.
    var imageContainer: any ImageContainer
}

// Existential types have significant limitations and performance implications and are more expensive than using concrete types since you can change them dynamically.

// A prefered way of erasing the extential type is to use generics
struct ImageConfigurator2<T: ImageContainer> {
    var imageContainer: T
}
