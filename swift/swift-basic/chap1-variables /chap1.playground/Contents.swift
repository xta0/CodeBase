import UIKit
import Foundation

var myInt:Int = 1
var myDouble:Double = 1.4
var myBool:Bool = true
var myString:String = "Jayson"

//swift 1.2
//var myView:UIView = UIView(frame: CGRectMake(0, 0, 320, 100))
//swift 3.0
var myView:UIView = UIView(frame: CGRect(x:0,y:0, width:320, height: 100))
myView.backgroundColor = UIColor(red: 0x11, green: 0x22, blue: 0x33,alpha: 1.0)
myView.backgroundColor = UIColor.red;

var urInt = 1
var urDouble = 1.4
var urBool = true
var urString = "Jayson"
var mutableDouble = 1.0
mutableDouble = 2.0

// using "let" keyword  for constant variables
let constantDouble = 2.0
//constantDouble = 3.0 //error
/*
 variable Initialization
 1. Every variable must have a initial value
 2. If not sure the initial value, make it optional
 3. nil is a type, variable with type can not be initialized as nil value
 */
var myStringNonOptional:String
// print(myStringNonOptional) //error:used before being initialized
// myStringNonOptional = nil //error, myStringNonOptional is typeof string, can not be assigned to type of nil


/*
Optionals
*/
//equals to optionalStr1 = nil in objc
var optionalStr1:String?

//implicity unwrapped optionals
//you need to make sure the string is not nil when use
var optionalStr2:String! = nil

print(optionalStr1); //nil
print(optionalStr1 as Any); //nil
print(optionalStr1 as AnyObject); //null
print(optionalStr2); //nil

optionalStr1 = "optinal string 1"
optionalStr2 = "optinal string 2"

if(optionalStr1 != nil){
    //println(optionalStr1) swift 1.0
    print(optionalStr1!); //swift 2.0
}

//for safty concern
var y:Int?
y = Int("32");
y = Int("ABC"); //nil

//functions return optional types
func f1(s1:String?, s2:String?) -> Any?
{
    return s1 == nil || s2 == nil
}
let ret:Any? = f1(s1:nil,s2:nil);
print(ret) //Optional(true) ??

class someViewController:UIViewController{
    var btn:UIButton?

}
var imageView = UIImageView();
imageView.image = UIImage(named: "")
if  let image = imageView.image{
    let sz = image.size
}else{
    print("This image hasn't been set")
}

/**
 using unwrap: !
 */
print(optionalStr1!);
//because optionalStr2 is declared as !
//so we don't need to unwarp the value
print(optionalStr2);
//
let w = Int("123")!;
print(w*2);
let x = Int("22");
print(x!*2);

/*
using if-let
 */
//using optional binding
if let optionalStr1 = optionalStr1{
    print(optionalStr1)
}
//Optional Chaining as an Alternative to Forced Unwrapping
let imageSize = imageView.image?.size
//dynamicType is deprecated in Swift 2.3
//imageSize.dynamicType
//use type(of:) in Swift 3.0
print(type(of: imageSize)) //Optional<CGSize>
if let imageSize = imageView.image?.size {
    print("\(imageSize)")
}

/*
 as! & as？
 */
class Berverage{
    var Category:String
    init(category:String){
        self.Category = String
    }
}
class HotDrink:Berverage{
    var paring:String
    init(category: String, paring: String){
        self.paring = paring;
    }
}

//tenery operators
var hungury = true
hungury ? print("Let's eat!") : print("Let's wait.")


/*
 * Any & AnyObject
 */
/*
 Swift provides two special types for working with nonspecific types:
 
 Any can represent an instance of any type at all, including function types.
 AnyObject can represent an instance of any class type.
 */
let anyArray: [Any] = [1,2,"hello",true]
print(anyArray)
