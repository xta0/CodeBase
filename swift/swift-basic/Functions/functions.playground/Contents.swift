import UIKit

/*
 ========
 Functions
 ========
 */
//【函数参数】
//声明函数参数包含两部分内容
//1. argument label : first, second
//2. argument name: x, y
func addNums(first x:Int, second y:Int) -> Int{
    return x+y;
}
//swift 1.2 可以忽略argument label
//addNums(10, 10)
//swift 2.0必须加上
print(addNums(first: 10, second: 10));

//argument label 可以用'_'代替
//argument label影响函数签名，和上面函数属于两个不同的函数
func addNums(_ x: Int,_ y: Int ) -> Int{
    return x+y
}
//有argument label，但是忽略
addNums(10,10)

//arugment name可以忽略
//此时x，y表示arugment label
func addNums(x:Int, y:Int)->Int{
    return x+y;
}
print(addNums(x:10, y:10));

/*
 默认参数
 */
func sayHello(name:String="Tom"){
    print("Hello,\(name)")
}

//有默认参数的可以不传参，如果传参，需要加入param name
sayHello()
sayHello(name: "Bob")

/*
 可变参数
 //variadic parameters
*/
func maxof(numbers:Int ... ) ->Int{
    if numbers.count == 0{
        return 0
    }
    var max = numbers[0]
    for number in numbers{
        if number > max{
            max = number
        }
    }
    return max
}
print("MAX number:\(maxof(numbers: 1,2,3))");

//函数返回值
func noParams1()->(){
    
}

func noParams2(){
    
}


/*
 *【参数修饰符】
 */
var someString = "entryString"

//默认参数为const
func addEntry1(str:String){
    //string += "!" //error
    var s:String = str; //create a copy
    s+="1";
}
//传引用
func addEntry2( string:inout String){
    string += "!"
}

addEntry1(str:someString)
print(someString)


addEntry2(string: &someString)
print(someString)

func swap(_ a:inout Int, _ b:inout Int){
    let temp = b;
    b = a;
    a = temp;
}
var x = 3
var y = 4
swap(&x,&y);
print(x,y) //4,3

/*
 *【参数返回值】
 */
//return multiple values:Tuple
func returnATupleFunc() -> (String,Int){
    return ("Success",200)
}

let tuple = returnATupleFunc()
print(tuple.0,tuple.1)

/*
 *【函数参数和返回值】
 */
func printMathResult(_ math:(Int,Int)->Int, _ x:Int, _ y:Int){
    print(math(x,y));
}

printMathResult( {(a:Int, b:Int) -> Int in
    return a+b
},10,10)

func returnFunc(b:Bool) -> (Int)->Int {
    if(!b){
        return { (_ x:Int) -> Int in
            return x+1
        }
      
    }else{
        return { (_ x: Int) -> Int in
            return x-1
            
        }
    }
}

print(returnFunc(b:true)(10))
print(returnFunc(b:false)(10))

//pass in a block
func repeatWork(count:Int, task:()->()){
    for _ in 0...count{
        task()
    }
}

repeatWork(count: 2) {
    print("Hello")
}


/*
 * Function as First-Class Object
 */
func addTwoInts(_ x:Int, _ y:Int)->Int{
    return x+y;
}
var mathfunc:(Int,Int)->Int = addTwoInts;
print(mathfunc(10,1));

//匿名函数
var mathfunc2:(Int,Int)->Int = { (_ x:Int, _ y:Int)->Int in
    return x+y;
}
mathfunc2(10,1)
/*
 *【函数嵌套】
 */
func returnFunc2(b:Bool) -> (Int)->Int {
    func ff1(x:Int)->Int {
        return x+1;
    }
    func ff2(x:Int)->Int{
        return x-1;
    }
    return b ? ff1 : ff2
}
returnFunc2(b: true)(10);
returnFunc2(b: false)(10);








