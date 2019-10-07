import UIKit

/*
 ====
 Optional
 ====
 
 Optional is just an enum
 enum Optional<T>{ //a generic type, like Array<Element>
    case none
    case some(<T>) //some case has associate data of type T
 }
 
 But this type is so important that
 it has a lot of special syntax that other types don't have
 */

var foo: String?            //Optional<String> = .none
//equivalent to
var bar: String? = nil      //Optional<String> = .none
//in this case, we can see the keyword `nil` in swift is also an enum type

// here is an interesting example
var str1: String //this line will compile, the compiler will know that str1 doesn't have a valid value
print(type(of: str1))       //String
// var str2 = str1 //this will cause an error
var str2: String! //this line will also compile, However,the compiler will assume that str2 have a valid value
print(type(of: str2))       //Optional<String>
print(str2)  //nil, this won't cause any error,
//print(str2!) //this will cause an error, because we try to unwrap the value
var str3 = str2 //this acutally works, str3 is also Optional<String>
//for safty concern
var x:Int?
x = Int("32");
x = Int("ABC"); //nil
//type case to any
print(foo as Any) //nil
print(foo as AnyObject) //<null>



/*
 unwrapping
 let hello: String?
 print(hello!)
 
 switch hello {
    case .none: //raise an exception(crash)
    case .some(let data):
        print(data)
 }
 */

/*
 ====
 if/guard let
 ====
 */
var hello: String?
if let greeting = hello {
    print(greeting)
} else {
    //do something else
}
/*
 switch hello {
    case .some(let data): print(data)
    case .none { //do something else }
 }
 */
/*
 ===
 implicitly unwrapping
 ===
 mainly used in param initialization in class
 */
var text1: String! = "abc"
var text2: String? = "abc"

/*
 ====
 Nil - coalescing operator (Optional Default)
 ====
 */
let y = hello ?? "foo"

/*
 switch hello {
    case .none: y = "foo"
    case .some(let data): y = data
 }
 */

/*
 ====
 Optional Chaining
 ====
 */
var text: String? = "abc"
let count = text?.count // count is also an optional type
if count != nil {
    
}

class Address{
    var buildingNumber :String?
    var streetName: String?
    var apartmentName: String?
}
class Residence{
    var address :Address?
}
class Person{
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
if let addressNumber = paul.residence?.address?.buildingNumber{
    //...
    print("\(addressNumber)")
}

/*
 将optional chaining按照enum规则展开，是一个递归调用的规程
 switch paul {
    case .none: addressNumber = nil
    case .some(let data1):
        switch data1.residence() {
            case .none: addressNumber = nil
            case .some(let data2):
                switch data2.address() {
                     case .none: addressNumber = nil
                     case .some(let data3) {
                        switch data3.buildingNumber {
                            case .none: addressNumber = nil
                            case .some(let data4):
                                addressNumber = data4
                            }
                     }
                }
        }
 }
 */

//注意optional chaining的写法和三目运算符的区别
//tenery operators
var hungury = true
hungury ? print("Let's eat!") : print("Let's wait.")
