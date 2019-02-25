import UIKit

///////////////
// Protocols
///////////////

///[Property Requirements]
// Protocol中不支持定义property，但是可以约束实现该Protocol对象的同名property的读写类型

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol FullyNamed {
    //The FullyNamed protocol requires a conforming type to provide a `fullName` getter
    var fullName: String { get }
}

struct Person: FullyNamed {
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
