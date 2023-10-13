// Playground - noun: a place where people can play

import UIKit

//function
func greetingFunc()->() {print("greeting func is called!")}
greetingFunc()

//unnamed function
let greetingBlock:()->()  = {print("greeting block is called!")}
greetingBlock()

/*
 Closure is reference type
 */
func createIncrementer() -> () -> Void {
    var counter = 0
    return {
        counter += 1
        print(counter)
    }
}

let incrementer = createIncrementer()
incrementer()
let incrementerCopy = incrementer
incrementerCopy() // this captures the same counter value, so counter will be 2


/*
 Closure Expression Syntax:
 
 { (parameters) -> return type in
        statements
 }
*/

//different types of blocks
let f = { (x:Int)->Int in return x+42} //closure has type of (int)->int
let closures = [f,
                { (x:Int)->Int in return x*2},
                { x in return x-8 },
                { x in x*x },
                { $0 * 42}
    
]

//define block using types
typealias IntToInt = (Int)->Int
let closure:IntToInt = { x in x*x }
print(closure(10))

//sort using block:

var clients = ["aa","sdf","v","asdfasdf"]
//specify the type
clients.sort { (s1:String, s2:String) -> Bool in
    return s1>s2;
}
print(clients)

//Inferring Type from context
clients.sort { s1, s2 -> Bool in
    return s1<s2
}
print(clients)

//even cooler
//only in swift 1.0
clients.sort(by: { $0 < $1})

//map - filter -reduce
let result = clients.map ({ (a:String) -> String in return a.uppercased()})
    .filter({(a:String) -> Bool in a.hasPrefix("A")})
    .reduce("reduce"){(a:String,b:String)->String in "\(a) \(b)"}
print(result)

//short version
let result2 = clients.map{$0.uppercased()}.filter{$0.hasPrefix("A")}.reduce("reduce"){"\($0) \($1)"}
print(result2)


//sum the values, haskell thing
let numbers = [1,2,3,4,5]
func sum(numbers :[Int]) -> Int{
    var tmp = 0
    numbers.map{ tmp += $0}
    return tmp
}
print( sum(numbers: numbers))

//variable capture
func makeCounter() -> (Int)->Int {
    
    //closure
    var n = 20
    func adder(x:Int)->Int{
        return x+n
    }
    return adder
}

print(makeCounter()(100))

//capture retain cycles
class TempNotifier{
    //self retains this block
    var onChange:(Int) -> Void = {(a:Int)->Void in  }
    var currentTemp = 72
    
    init(){
        //block retains self
        onChange = { [ unowned self] (tmp) in self.currentTemp = tmp}
    }
    
    deinit{
        print("deinit called")
    }
    
}

var notifier = TempNotifier()

//UIKit
import Foundation

extension UIView{
    func fadeOut(duration: TimeInterval, delay: TimeInterval, completion: ((_ finished:Bool)->Void)?){
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    func fadeIn(duration: TimeInterval, delay: TimeInterval, completion:((_ finished:Bool)->Void)?){
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
}


