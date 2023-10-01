// Playground - noun: a place where people can play

import UIKit

/*
====
Value Types
====
 */

//default type is int
enum PrimaryColor: String{
    case Red = "Red"
    case Blue
    case Yellow
    // use enum as name space. cyan is not switch-case-able
    static let Cyan = "Cyan"
}

let blueColor = PrimaryColor(rawValue: "Blue")
print(blueColor ?? "Invalid Color")
let blackColor = PrimaryColor(rawValue: "Black")
print(blackColor ?? "Invalid Color")

print(PrimaryColor.Blue.rawValue)
print(PrimaryColor.Cyan)

var color = [PrimaryColor: Any]()
color[.Blue] = "23"

func bar(_ color : [String: Any]) {
    print(color.keys)
}

let stringKeyedPrimaryColor = color.reduce(into: [String: Any]()) { (result, entry) in
    result[entry.key.rawValue] = entry.value
}
bar(stringKeyedPrimaryColor)

enum Suit{
    case Clubs,Diamonds,Hearts,Spades
}

var cardSuit1 = Suit.Diamonds
let cardSuit2:Suit = .Clubs

/*
====
Iteration
====
*/
enum CompassPoint: CaseIterable {
    case north
    case south
    case east
    case west
}
let numberOfDirections = CompassPoint.allCases.count
for direction in CompassPoint.allCases {
    print(direction)
}


/*
 ====
 Enum value can only be checked by using switch statement
 ====
 switch必须穷举enum的所有分支
 */
switch cardSuit1{
case .Clubs:
    print("Clubs")
case .Diamonds:
    print("Diamonds")
case .Hearts:
    print("Hearts")
case .Spades:
    print("Spades")
}


enum Rank:Int
{
    case Ace = 1
    case two,three,four
}

let rwVal = Rank.three.rawValue
print("raw:\(rwVal)")

let orank = Rank(rawValue: 3) //optional

if let rank = orank
{
    print(rank.rawValue)
}

/*
 ====
 associated values
 ====
 */
enum Rank2
{
    case Ace
    case Num(Int)
    case Jack,Queen,King
}
//
let rank4 = Rank2.Num(3)
print(rank4)

/*
 ====
 Associated data is accessed through a switch statement using "let"
 ====
 */
switch(rank4)
{
case .Ace:
    print ("ACE")
case .Jack:
    print ("Jack")
case .Queen:
    print ("Queen")
case .King :
    print ("King")
case .Num(let val):
    print( String(val) )
}

/*
 ====
 Specify default "self" value
 ====
*/
enum Rating : Int
{
    case Terrible = 1
    case Average
    case Epic
    
    init(){
        self = .Average
    }
    
    mutating func switchToEpic (){
        self = .Epic
    }
}

var myRating = Rating()
print(myRating)
myRating.switchToEpic()
print(myRating)

/*
 ====
 Methods & Properties
 ====
 Enum可以定义method和computed property，不能定义stored property
 */
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: Int)
    case drink(String, ounces: Int)
    case cookie

    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
        case .hamburger(let pattyCount):
            return pattyCount == number
        case .fries, .cookie: //combine to one case
            return true
        case .drink(_, let ounces):
            return ounces == 16
        }
    }
    //stored property
    var calories: Int {
        return 100
    }
}


enum Dummy {
    static func dummy(){
        print("dummy")
    }
}
Dummy.dummy()


