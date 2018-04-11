// Playground - noun: a place where people can play

/**Create**/

//1. An empty dictionary
var game = [String: Int]()
let gameTypesExplicity3 = Dictionary<String,String>()
//2.Inferred
let gameTypes = ["COD":"Shooting","COL":"RPG"]
//3. Explicity (long)
let gameTypesExplicit1:Dictionary<String,String> = ["COD":"Shooting","COL":"RPG"]
//4. explicity (short)
let gameTypesExplicit2:[String:String] = ["COD":"Shooting","COL":"RPG"]

/**set values**/
game["COD"]=123;
game["HeartStone"]=230;

/**Accessing**/
let optionalGameType = gameTypes["COD"]

if let definiteGameType = optionalGameType{
    print(definiteGameType)
}

/*loop*/
//1, loop keys

//Immutable vs. mutable

let immutable = gameTypes
var mutable   = gameTypes
//insert
mutable["KOF"] = "Combat"
//remove
mutable["KOF"] = nil
