// Playground - noun: a place where people can play

import UIKit

/*
 *Control Flow
 */


/*
 ====
 for
 ====
 */
let birdGames = ["Angry Birds","Tiny Wings","Flappy Bird"]
let gameTypes = ["COD":"Shooting","COL":"RPG"]

//for in
for i in 1..<10
{
    print("Exclusive: \(i)")
}

//from 1 to 10 include 10
for i in 1...10
{
    print("Exclusive: \(i)")
}

for i in 0..<birdGames.count
{
    let birdGame = birdGames[i]
    print(birdGame)
}

//no {..}
//error: C-style for statement has been removed in Swift 3
//for var i=0 ;i<birdGames.count; i++
//{
//    let birdGame = birdGames[i]
//    print(birdGame)
//}

//itorate arrays
for birdGame in birdGames
{
    print(birdGame)
}

//python style
//itorate using tuple
for (index,birdGame) in birdGames.enumerated()
{
    print("index:\(index) => value:\(birdGame)")
}

//itorate dictionary
for(k,v) in gameTypes
{
    print("\(v) is  \(k) type.")
}

//print only keys
for(k,_) in gameTypes
{
    print("key:\(k)")
}

/*
 ======
 while loop
 ======
 */

var multiplesof3 = 3
while multiplesof3 < 100
{
    print("\(multiplesof3)")
    multiplesof3 += 3
}

//do-while loop

import Foundation

let lastRandom = 5
var random:Int = 4

repeat{
    random = Int(arc4random() % 10)
}while(random == lastRandom)


/*
 =====
 if / if let
 =====
 */

let name = "Ray"
if name.count <= 3{
    print("You Hava a short name")
}
else if name.count <= 6{
    print("You Hava a average name")
}
else{
    print("You Hava a long name")
}

let person:[String:String] = ["name":"Tao", "location":"SF"];
if let name:String = person["name"] {
    print(name)
}

/*
 ====
 guard / guard let
 ====
 */
//guard是一种特殊的if，仅当guard的条件为true时，才执行后面逻辑，否则进入else分支

//1. 检查函数参数
func updateApp1(b:Bool){
    guard b else {
        return
    }
    print("pass updateApp1")
}
updateApp(b: false)
//2. 检查中间结果
func updateApp2(b:Bool){
    let x:[Int] = [1,2,3]
    guard x.count > 3 else{
        return
    }
    print("pass updateApp2")
}
//3. unwrap optional value
func greet(_ person: [String:String]){
    guard let name = person["name"] else{
        return;
    }
    print(name);
    guard let location = person["location"] else{
        return ;
    }
    print (location)
}



greet(person)


/*
 =====
 Switch
 =====
 */

let teamMember = "BC"

//no fallthrough
switch (teamMember)
{
case "BC","Chris B":
    print("Editor")
    
case "Chris LP","Alexis":
    print("Tech Editor")
    
case "Greg","Brain":
    print("Razeware")
    
default:
    print("Tutorial Team")
}

//switch and ranges
switch name.count
{
case 0...3:
    print("You Have a Short Name")
case 4...6:
    print("You Have a average name")
default:
    print("You Hava a long name")
}


//pattern matching and binding
let point = (10,10)

switch point
{
case(0,_):
    print("\(point)")
case(0,let y):
    print("\(y)")
case let (x,y) where x==y:
    print("(\(x),\(y))")
default:
    print("default")
}

//switch and conditional cases
for birdGame in birdGames{
    switch birdGame{
        //error: 'containsString' has been renamed to 'contains(_:)'
        case let x where (x as NSString).contains("Bird"):
            print("found a Bird game")
        default:
            print("found no Bird game")
    }
}

/*
 ======
 API Compatibiliy
 ======
 */
if #available(iOS 10, macOS 10.12, *){
    //use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
    
}else{
    //fallback to earlier iOS and macOS APIs
}

