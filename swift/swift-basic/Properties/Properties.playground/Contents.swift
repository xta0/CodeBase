import UIKit

/*
 Three types of properties
 
 1. Stored Property
    - struct
    - class
 2. Computed Property
    - struct
    - class
    - enums
 3. Type Property
    - associated with the type itself
    - Protocol
    - Class
    - ...
 */

/*
 ====
 Stored Properties
 ====
 */

// store property 不需要定义时初始化，需要通过构造函数进行初始化
struct FixedLengthRange{
    var firstValue: Int
    let length: Int //let is constant
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue - 6;

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)

// this will report an error, even though firstValue is a variable property
// This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.
// 如果一个instance是value type的，并且它是使用`let`声明的，即是它有property是`var`的，仍然不能改变它的property，如果是reference type的，则可以
//rangeOfFourItems.firstValue = 6;

/*
 ====
 Lazy Stored Properties
 ====
 */
// property的 lazy loading, 如果propery是lazy的，那么它只能用`var`定义，`let`要求定义即初始化
class DataImporter {
    var filename = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
print(manager.importer.filename)

/*
 [Note]:
 If a property marked with the lazy modifier is accessed by multiple threads
 simultaneously and the property has not yet been initialized,
 there is no guarantee that the property will be initialized only once.
 */

/*
 ====
 Computed Properties
 ====
 */
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

struct Card{
    var selected:Bool = false
}

let cards:[Card] = [Card(selected: true),Card(selected: true)]

for var card in cards {
    card.selected = true
}

print(cards[1].selected)


/*
 ====
 Properties Observers
 ====
 */

//lazy var does not have didset mathod



/*
 ====
 Type Properties
 ====
 */
/// You can also define properties that belong to the type itself,
/// not to any one instance of that type. There will only ever be one copy of these properties, no matter how many instances of that type you create.
/// These kinds of properties are called type properties.

/// Type property是和类型相关的property，类型是static，所有instance共享。类似类的静态成员
/// Type property也可以分为stored property和computed property
/// 如果是stored property, 定义必须初始化
/// 如果是computed property，`class` 关键字可以支持子类override

struct SomeStructure {
    var storedInstanceProperty: String
    static var storedTypeProperty = "Some Value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"
