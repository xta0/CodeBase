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

var myStringNonOptional:String
// print(myStringNonOptional) //error:used before being initialized
// myStringNonOptional = nil //error, myStringNonOptional is typeof string, can not be assigned to nil

//optional variables
var myStringOptional:String?
myStringOptional="abc"
//myStringOptional = nil; //option type can be assigned to nil

if(myStringOptional != nil){
    let myAnotherString = myStringOptional! //force unwrap the value
    //println(myAnotherString) swift2.0
    //swift 3.0
    print(myAnotherString)
}else{
    print("myAnotherString is nil")
}


if let myAnotherString = myStringOptional{
    print(myAnotherString)
}
else{
    print("myAnotherString is nil")
}
