import UIKit

//structure
struct Point{
    var x,y: Double
}

struct Size{
    var width,height :Int
}

/*
 ====
 Constructor
 ====
 Struct自带构造函数
 */
struct Rect{
    var origin:Point
    var sz : Size
    var taggedPoints:[Point]
    
    var area:Double{
        return (Double)(sz.height * sz.height)
    }
    func isBiggerThanRect(other:Rect) -> Bool{
        return self.area > other.area
    }
    
    //mutating:
    //Struct are designed to be immutable by default, meaning you can not mutate struct member variables in
    //an instance method.You can add "mutating" keyword to let the compiler allow this happen
    mutating func addTaggedPoint(point:Point){
        self.taggedPoints.append(point)
    }
    
    var description: String {
        return "\(origin.x)"
    }
}
var rt = Rect(origin: Point(x: 10, y: 10), sz: Size(width: 100, height: 100), taggedPoints: [])
rt.taggedPoints.append(Point(x: 100, y: 100))
print(rt.taggedPoints)


//difference between class and structure

//1, structure can not inherite from another stuctures
//2, how values pass around:

//structure -> value : pass by copy (copy on write)
//class -> object : pass by reference

class Window
{
    init(){
        self.frame = Rect(origin: Point(x:10,y:10), sz: Size(width: 100, height: 100), taggedPoints: [Point]())
        self.title = "111"
    }
    var frame :Rect
    var title :String
}

//w1 is a reference to Window class
var w1 = Window()

let w2 = Window()
w2.title = "123"

//wrong: w2 = w1  -> w2 = Window* const  w1

var newFrame = w1.frame
//newFrame is a value
newFrame.origin.x = 20.0
print(w1.frame)


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


