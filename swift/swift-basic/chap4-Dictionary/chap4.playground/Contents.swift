// Playground - noun: a place where people can play

/**Dictonary**/

//1. An empty dictionary
var game = [String: Int]()
var averageLifeSpanDict = [String:Range<Int>]()
let gameTypesExplicity3 = Dictionary<String,String>()
//2.Inferred
let gameTypes = ["COD":"Shooting","COL":"RPG"]
//3. Explicity (long)
let gameTypesExplicit1:Dictionary<String,String> = ["COD":"Shooting","COL":"RPG"]
//4. explicity (short)
let gameTypesExplicit2:[String:String] = ["COD":"Shooting","COL":"RPG"]

//set values
game["COD"]=123;
game["HeartStone"]=230;

game["StarCraft"] = 33;
let x = game.updateValue(33, forKey: "COD")
print(type(of: x))

//remove values
game["COD"] = nil;
//remove keys
game.removeValue(forKey: "COD")

//get values
//optional
let optionalGameType = gameTypes["COD"]
if let definiteGameType = optionalGameType{
    print(definiteGameType)
}
//count
print(game.count)

/*loop*/
//1, loop keys


/*
 * Set
 */
var cutlery:Set = ["fork","knife","spoon"]
var flowers:Set<Character> = ["Rose","Spoon"]
