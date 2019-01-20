// Playground - noun: a place where people can play

import UIKit

/*
 * Enums (Value Type)
 */

//default type is int
enum PrimaryColor{
    case Red
    case Blue
    case Yellow
}
enum Suit{
    case Clubs,Diamonds,Hearts,Spades
}

var cardSuit1 = Suit.Diamonds
let cardSuit2:Suit = .Clubs

switch cardSuit1
{
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

let orank = Rank(rawValue: 3) //optional

if let rank = orank
{
    print(rank.rawValue)
}

//associated values
enum Rank2
{
    case Ace
    case Num(Int)
    case Jack,Queen,King
    func description() ->String
    {
        switch(self)
        {
        case .Ace:
            return "ACE"
        case .Jack:
            return "JACK"
        case .Queen:
            return "Queue"
        case .King :
            return "King"
            
        case .Num(let val):
            return String(val)
        }
        
    }
}
//
let rank4 = Rank2.Num(3)
rank4.description()


//default values
enum Rating : Int
{
    case Terrible = 1
    case Average
    case Epic
    
    init()
    {
        self = .Average
    }
}

let myRating = Rating()
myRating.rawValue



/*
 Struct (Value Type)
 */
struct PictureFrame{
    var width = 5
    var height = 7
    var thickness: Double = 1.5
    var area: Int{
        get{
            return width*height
        }
    }
}
var p = PictureFrame()
print(p.area)
var p2 = p; //copy
p2.width = 10
print(p.area) //no change

struct Beer{
    var style = "Pale Ale"
    var percentAlcohol = 5
    static var cheerDict = ["English":"Cheers!","German":"Prost"]
    var suggestedVolumePreserving:String {
        get {
            return "\(12/(percentAlcohol/5)) ounces"
        }
    }
    static func cheers(language: String){
        if let cheers = cheerDict[language]{
            print("\(cheers)")
        }
    }
}
var happyBeer = Beer(style: "Lager", percentAlcohol:6)
print(happyBeer.suggestedVolumePreserving)
Beer.cheers(language: "English")

