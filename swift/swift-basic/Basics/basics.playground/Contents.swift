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


/*
 ==
 let/var
 ==
 */
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
 溢出运算符
 */

/*
 无符号数 Uint8
 &+ 上溢出, 从最大数变成最小数
     11111111 （255）
            1 （1）
    100000000 （0）
 
     11111111（255）
           11（3）
    100000010（2）
 
 无符号数 Uint8
 &- 下溢出, 从最小数变成最大数
    00000000 （0）
           1 （1）
    11111111 （255）
 
    00000000 （0）
          11 （3）
    11111101 （253）
 
 */
let num1: UInt8 = 255
//let num2 = num1 + 10 //wrong
let num2 = num1 &+ 1 //0
let num3 = num1 &+ 3 //2

let num4: UInt8 = 0
let num5 = num4 &- 1 //255
let num6 = num4 &- 3 //253


/*
 有符号数 Int8 (-128 ~ 127)
 &+ 上溢出, 从最大数变成最小数
 01111111 （127）
        1 （1）
 10000000  (-128)
 
 有符号数 Int8 (-128 ~ 127)
 &- 下溢出, 从最小数变成最大数
 10000000 （-128）
        1 （1）
 01111111 （127）
 */

let num7:Int8 = 127
let num8 = num7 &+ 1 //-128
let num9:Int8 = -128
let num10 = num9 &- 1 //127

/*
 区间运算
 */

