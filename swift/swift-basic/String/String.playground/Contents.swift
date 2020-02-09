// Playground - noun: a place where people can play

import UIKit
import Foundation

/*===============
* String APIs
================*/

/*
* [String concatenation]
*/
var str = "Hello, playground" + ","
str += "!"

/*
 * [string interpolation and fomating]
 */
var myInt = 10
str += "\(myInt)"
str += "\(5*6)"

/*
 * String comparasion
 */
let str1 = "Jayson"
let str2 = "Jayson"
let str3 = "jayson"

print(str1 == str2) //true
//lowercaseString is deprecated in swift 2.0
//print(str1.lowercaseString == str3)
//use lowercased in swift 4.0
print(str1.lowercased() == str3)
print(str2.isEmpty)
//contains string
let welcome = "hello, world"
print(welcome.contains("hello"))
print(welcome.hasPrefix("hello"))
print(welcome.hasSuffix("world"))

/*
 * String to other type
 */
//integer/double -> string
let str4 = String(1)
let str5 = String(1.1)
let str6 = NSString(format: "%.1f", 3.14)

//string -> integer/double
//func toInt() -> Int?
//toInt() is deprecated in swift 2
let maybeInt:Int? = Int(str4);
//let maybeInt = str4.toInt() //returns an optional value
if( maybeInt != nil )
{
    let definitInt = maybeInt!
    print(definitInt)
}

/*
 * Indexing
 */
let greeting = "Guten Tag!"
// greeting[1] //error:'subscript(_:)' is unavailable: cannot subscript String with an Int, see the documentation comment for discussion
// can't use Int as index, String has its own indexing type - String.Index
greeting[greeting.startIndex]
greeting[greeting.index(after:  greeting.startIndex)]
greeting[greeting.index(before: greeting.endIndex)]
//访问任意字符
let index = greeting.index(greeting.startIndex, offsetBy: 2)
greeting[index] //'t'



/*
 * APIs
 */
var flappy = "Flappy Jay"
//insert
//1. insert a character
flappy.insert("!", at: flappy.endIndex)
//2. insert a string
flappy.insert(contentsOf: " Bird", at: flappy.index(flappy.startIndex, offsetBy: 6))
print(flappy) //Flappy Bird Jay

//remove
flappy.remove(at: flappy.index(before: flappy.endIndex))
let range = flappy.index(flappy.startIndex, offsetBy: 6) ..< flappy.index(flappy.startIndex, offsetBy: 11)
flappy.removeSubrange(range)
print(flappy)
//SubString
//In Swift, substring has its own type of "Substring"
//Substring 拥有 String的大部分方法
//Substring 可以转成 String
//Both String and Substring conform to StringProtocol
let prefix_index = flappy.firstIndex(of: " ") ?? flappy.endIndex
let prefix = flappy[..<prefix_index] //typeof Substring
let newString = String(prefix)
//why substring?
let img = UIImage(named: "substring")

//



/*
 * Char Enumeration
 */
let words = "xta0.me"
//characters deprecated in swift 3.0
//for c in words.characters {
//swift 4.0:
for c in words {
    if c == "x"{
        print("found x!")
    }
}


/*
 * Unicode
 */
//all swift code is unicode
//Strings are an ordered collection of Characters
let chara:Character = "a"
let charb:Character = "b"
//+ is deprecated
//let holidays:String = chara+charb
func + (left:Character, right:Character) -> String {
    return "\(left)\(right)"
}
let holidays = chara + charb;

//number of unicode characters:
//countElements was removed in iOS 8.3 (with Swift 1.2)
//countElements(holidays) //2
//characters deprecated in swift 3.0
//print(holidays.characters.count);
//Swift 4.0
print(holidays.count)

//not necessarily the same as NSString's length(number of UTF-16 units)
//'utf16Count' is unavailable
//holidays.utf16Count //2
//Swift 4.0
print(holidays.utf16.count) //2
print((holidays as NSString).length) //2
print(holidays.utf8.count) //2


/*
 NSString API
 */
//String is Swift class, NSString is OC class
//needs bridging : "as"

//The entire NSString API is available to call on any String value you create
let myDouble = Double(("3.14" as NSString).doubleValue) //use "as" to convert String to NSString, then use NSString's API
let myInt2 = ("3.14" as NSString).intValue;

let nsflaapy = flappy as NSString;
nsflaapy.contains("Jay")
nsflaapy.hasPrefix("Jay")
nsflaapy.hasSuffix("Jay")

var jay = (flappy as NSString).substring(with:NSMakeRange(6, 4))

/*
 Multiply line literal
 */
let numbers = """
1
2
3
4
5
"""
print(numbers)
