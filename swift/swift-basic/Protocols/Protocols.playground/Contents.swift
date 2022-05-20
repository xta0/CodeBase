import UIKit

///////////////
// Protocols
///////////////

///[Property Requirements]
// Protocol中不支持定义property，但是可以约束实现该Protocol对象的同名property的读写类型
// only {get} and {get set} are allowed

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol FullyNamed {
    //The FullyNamed protocol requires a conforming type to provide a `fullName` getter
    var fullName: String { get }
}

struct Person: FullyNamed {
    // fullName is read and write that satisfies the requirements
    var fullName: String
}
let jonh = Person(fullName: "John Reed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    // getter, computed readonly-property
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701:FullyNamed = Starship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)


///Type property also works with Protocol
protocol AnotherProtocol {
    static var someTypeProperty: Int{get set}
}
struct AnotherObject: AnotherProtocol {
    static var someTypeProperty: Int = 100
}

/// [Method Requirements]
/// `mutating` keyword
protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            //mutation
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

/// [Initializer Requirements]
/// Protocol中可以声明`init`构造函数

protocol SomeProtocol2 {
    init (param: Int) //only declaration
}

class SomeSuperClass {
    init (param: Int) {}
}

class SomeClass: SomeSuperClass, SomeProtocol2 {
    //如果是init在protocol中声明了，则init要加上require
    //"required" from SomeProtocol2
    //"override" from SomeSuperClass
    required override init(param: Int) {
        super.init(param: param)
    }
}

protocol Souschef{
    func chop(vegies:String) -> String;
    func resin(vegies:String) -> String;
}

class Roomate:Souschef,Equatable {
    static func == (lhs: Roomate, rhs: Roomate) -> Bool {
        return lhs.name == rhs.name
    }
    var hungry = true
    var name:String
    init(hungry:Bool, name:String) {
        self.hungry = hungry
        self.name = name
    }
    func chop(vegies: String) -> String {
        return "a"
    }
    
    func resin(vegies: String) -> String {
        return "b"
    }
}

/// [Protocols as Types]
/// 1. 用作函数，方法的形参或返回值类型
/// 2. 作为常量，变量或者属性的类型
/// 3. 作为数组，字典或者其它的存储器的元素类型

protocol RandomGenerator {
    func random() -> UInt
}
extension RandomGenerator {
    func random () -> UInt {
        return UInt.random(in: 1...100)
    }
}
class Dice {
    let sides: UInt
    let generator: RandomGenerator
    init (sides: UInt, generator: RandomGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> UInt {
        return generator.random()*sides + 1
    }
}

/// [Adding Protocol Conformance with an Extension]
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

/// [Conditionally Conforming to a Protocol]
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

/// [Declaring Protocol Adoption with an Extension]
/// 如果某个类型已经实现了某个protocol中的函数，但是并没有显示的声明出来，这时候可以加一个空的实现
struct Hamster {
    var name: String
    // Hamster has alread implementd `textualDescription`
    var textualDescription: String {
        return "A hasmster named \(name)"
    }
}
// 声明一个空的extension
extension Hamster: TextRepresentable {}

let obj: TextRepresentable = Hamster(name: "Simon")
print(obj.textualDescription)


/// [Protocol Inheritance]
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

/// [Class-Only Protocols]

// 如果Protocol被声明成从AnyObject继承，则该protocol只能被class实现
protocol SomeClassOnlyProtocol: AnyObject, TextRepresentable {
    // class-only protocol
}

/// [Protocol Composition]
// 用于类型约束，要求某个类型同时具有多个protocol的类型， 用`&`符号

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}
// 要求celebrator的类型为 `Named & Aged`
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

/// [Checking for Protocol Conformance]
// 1. 使用`is`检查object是否conform了某个protocol

protocol HasArea {
    var area: Double { get }
}
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

// Animal does not conform to `HasArea` protocol
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if object is HasArea {
        print("\(object) conforms to the protocl")
    }
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}


/// [Optional Protocol Requirements]
// Optional Protocol用 `@objc`标识

/// Note that @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes.
/// They can’t be adopted by structures or enumerations.
@objc protocol CounterDataSource {
    @objc optional func increment (forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

// 当调用optional Protocol函数时，函数类型会发生变化，例如(Int) -> String将变为((Int) -> String)?
// 这是由于编译器无法知道对象是否实现了这个函数

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        // increment后面的?表示不确定dataSource是否实现了该方法
        // 因此其返回值也是optional的类型
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

// TreeSource实现了CounterDataSource，前提是它从NSObject这个OC类型中继承下来
class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

/// [Protocol Extensions]
// 提供对protocol函数的默认实现

extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

/// [Adding Constraints to Protocol Extensions]
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
