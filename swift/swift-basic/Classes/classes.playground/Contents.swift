// Playground - noun: a place where people can play

import UIKit

//declaring a class
class Entity{
    //properties
    var inventory:[String] = []
    
    //all values in swift must have a initial value
    //or it's type must be optional
    var hp:Int?
    var mp:Int? //default value is nil
    var sp:Int = 10
    
    //stored properties
    let title:String = "Senior Achitect"
    let director: String = "James"
    
    init(hp:Int){
        //no need to call super
        self.hp = hp
    }
    
    //methods
    func addItem(item: String, numItems: Int)
    {
        //todo...
        for _ in 0..<numItems
        {
            self.inventory.append(item)
        }
        
    }
    
    func removeItem(item:String)
    {
        //todo...
        let optionalIndex = self.inventory.firstIndex(of: item)
//        let optionalIndex = find(self.inventory,item)
        if let index = optionalIndex
        {
            self.inventory.remove(at: index)
        }
    }
    
}

let entity = Entity(hp: 50)
entity.hp = 100
//作为类的method，第一个参数没有external param name , 第二个参数有
entity.addItem(item: "monster", numItems: 3)

if(entity.mp != n {}il)
{
    let wrapped_mp = entity.mp!
    print(wrapped_mp)
}



//subclass
class Popeye : Entity
{
    let favoriteFood:String
    
    init()
    {
        self.favoriteFood = "Spanish"
        
        //setup all the properties before calling super.init()
        super.init(hp: 100)
    }
    
    func sing()
    {
        print("I'm a Popeye the sailor man")
    }
    
    override func addItem(item: String, numItems: Int) {
        
        if item == self.favoriteFood{
            hp! += 10 * numItems
            
        }
        else
        {
            super.addItem(item: item, numItems: numItems)
        }
    }
    
}

//property observers
class Car
{
    var speed:Double = 0.0
    {
        willSet
        {
            print("will set the speed to : \(speed)")
            
        }
        didSet
        {
            print("did set the speed to : \(speed)")
        }
    }
    
}

let pCar = Car()
pCar.speed = 100


/*
 ====
 Struct
 ====
 */
struct myStruct{
    var myString:String?
    var myInt: Int?
    var myDouble: Double?
}
let ms:myStruct = myStruct(myString: nil, myInt: nil, myDouble:nil);






