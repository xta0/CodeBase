import UIKit
import Foundation

var myInt:Int = 1
var myDouble:Double = 1.4
var myBool:Bool = true
var myString:String = "Jayson"
var myArray: [String] = ["1"]

print(MemoryLayout.size(ofValue: myInt))
print(MemoryLayout.size(ofValue: myDouble))
print(MemoryLayout.size(ofValue: myBool))
print(MemoryLayout.size(ofValue: myString))
print(MemoryLayout.size(ofValue: myArray))

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
 ====
 Optionals
 ====
 */
//equals to optionalStr1 = nil in objc
var optionalStr1:String?

//implicity unwrapped optionals
//you need to make sure the string is not nil when use
var optionalStr2:String! = nil

print(optionalStr1!); //nil
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
        self.Category = category
    }
}
class HotDrink:Berverage{
    var paring:String
    init(category: String, paring: String){
        self.paring = paring;
        super.init(category: category)
    }
}

let hotDrink = HotDrink(category: "coffee", paring: "unknow")

print((hotDrink as Berverage).Category)
if let hotDrink = hotDrink as? Berverage {
    print(hotDrink.Category)
}

/*
 ====
 Optional Chaining
 ====
 */
class Address
{
    var buildingNumber :String?
    var streetName: String?
    var apartmentName: String?
}
class Residence
{
    var address :Address?
}
class Person
{
    var residence :Residence?
}


let paul = Person()
var addressNumber:Int?

if let home = paul.residence
{
    if let postalAddress = home.address
    {
        if let building = postalAddress.buildingNumber
        {
            if let convertedNumber = Int(building)
            {
                addressNumber = convertedNumber
            }
        }
    }
}
//the above codes are cubersome
//optional chaining:
//?意思是：如果paul.residence?不为nil，则返回paul.residence
if let addressNumber = paul.residence?.address?.buildingNumber
{
    //...
    print("\(addressNumber)")
}



//tenery operators
var hungury = true
hungury ? print("Let's eat!") : print("Let's wait.")



