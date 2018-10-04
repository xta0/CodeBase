import UIKit


func addNums(x: Int,y: Int ) -> Int
{
    return x+y
}


//swift 1.2 可以忽略 x,y
//addNums(10, 10)
//swift 2.0必须加上x,y
addNums(x: 10, y: 10)

func noParams1()->()
{}

func noParams2(){}

//external paramter name
import CoreGraphics

func lerp(from start:CGPoint, to end:CGPoint, delta t:CGFloat) -> CGPoint
{
    let range = CGPoint(x:end.x - start.x, y: end.y - start.y)
    return CGPoint(x:start.x + range.x * t, y:start.y + range.y*t)
}

//函数默认是没有external paramter name的
lerp(from: CGPoint(x:100,y:100), to: CGPoint(x:200,y:200), delta: 0.2)


//make external name equal to internal param's name :
//using hash tag
func SubtractNums(x:Int , y:Int) -> Int
{
    return x-y;
}

SubtractNums(x:10,y:5)

//default params
func calcTip(subtotal:Double, tipPct:Double = 0.18) -> Double
{
    return subtotal * tipPct
}

calcTip(10, tipPct: 0.2)
calcTip(10)

//variadic parameters
func maxof(numbers:Int ... ) ->Int
{
    if numbers.count == 0
    {
        return 0
    }
    
    var max = numbers[0]
    
    for number in numbers
    {
        if number > max
        {
            max = number
        }
    }
    return max
}


/*
 * 
 */
var string:String = "entryString"

//默认参数为const，传引用
func addEntry1(string:String)
{
    //by default string can not be modified
    //string += "!" //error
}

// var is deprecated after swift 1.2
//func addEntry2(var string: String)
//{
//    string += "!" //only modify the local value, caller's value is not modified
//
//}
func addEntry3( string:inout String)
{
    string += "!"
}

addEntry1(string)
println(string)

addEntry2(string)
println(string)

addEntry3(&string)
println(string)

//default param value
func sayHello(name:String="Tom")
{
    println("Hello,\(name)")
}

//有默认参数的可以不传参，如果传参，需要加入param name
sayHello()
sayHello(name: "Bob")

//return multiple values:Tuple
func returnATupleFunc() -> (String,Int)
{
    return ("Success",200)
}

let tuple = returnATupleFunc()

println(tuple.0,tuple.1)

func repeatWork(count:Int, task:()->())
{
    for _ in 0...count
    {
        task()
    }
}


func print()->(){ print("hello")}
let proc:()->() = { print("hello")}

//repeat function
repeatWork(2,proc)
repeatWork(2,print)
//if the block is the last param of the function:
repeatWork(2){print("hello")}





