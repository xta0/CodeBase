import UIKit

var myInt:Int = 1
var myDouble:Double = 1.4
var myBool:Bool = true
var myString:String = "Jayson"

//swift 2.0
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

let constantDouble = 2.0
//constantDouble = 3.0 //error

/*
 Initialization
 1. Every variable must have a initial value
 2. If not sure the initial value, make it optional
 3. nil is a type, variable with type can not be initialized as nil value
 */
var myStringNonOptional:String
// print(myStringNonOptional) //error:used before being initialized
// myStringNonOptional = nil //error, myStringNonOptional is typeof string, can not be assigned to nil


/*
Optionals
*/
var optionalStr1:String? //equal to optionalStr1 = nil in objc
var optionalStr2:String! = nil //you need to make sure the string is not nil when use
print(optionalStr1); //none
print(optionalStr2); //nil

optionalStr1 = "optinal string 1"
optionalStr2 = "optinal string 2"

if(optionalStr1 != nil){
    //println(optionalStr1) swift2.0
    print(optionalStr1); //swift 3.0
}

//using unwrap: !
print(optionalStr1!);
//because optionalStr2 is declared as !
//so we don't need to unwarp the value
print(optionalStr2);

//using optional binding
if let optionalStr1 = optionalStr1{
    print(optionalStr1)
}

//tenery operators
var hungury = true
hungury ? print("Let's eat!") : print("Let's wait.")
