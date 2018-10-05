// Playground - noun: a place where people can play

import UIKit

/*
 *Arrays
 */

//Inferred
let birdGames = ["Angry Birds","Tiny Wings","Flappy Bird"]

//Explicit (long form)
let birdGamesLongExplicit :Array <String> = birdGames

//Explicit (short form)
let birdGamesShortExplicit :[String] = birdGames

//Empty
let birdEmptyGames :[String] = []

//Empty
var numbers = Array<Double>.init()
var moreNumbers = [Double]()

//Count of Array
let count = birdGames.count

//index of any object
//swift 3.0
let index1 = birdGames.index(of:"Angry Birds")
//swift 4.0
let index_first = birdGames.firstIndex(of: "Tiny Wings")
let index_last = birdGames.lastIndex(of: "Flappy Bird")

//Accessing Arrays
let first = birdGames[0]
let last = birdGames[birdGames.count - 1]

//contains
let b = birdGames .contains("Tiny Wings")


//Immutable vs. Mutable Arrays
let immutable = birdGames

var mutable = birdGames
mutable.append("Angry Me")
mutable.insert("King Kong", at: 2)

//append a list
mutable +=  ["1","2"]

//modifying Arrays
mutable.insert("Angry Birds Rio", at: 1)
mutable.remove(at: 0)

//sort by passing lambda
mutable.sort{a,b in a<b}

//replace
mutable[0...1] = ["Kobe","Jeremy","Nash"]
print(mutable)

//typealias
typealias StringList = [String]
var genericList = StringList()
genericList.append("haha")
print(genericList)


/*
 * ObjC Array
 */
import Foundation

var list:NSMutableArray = NSMutableArray()
list.add("string")
print(list.contains("string"))

