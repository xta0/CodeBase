import UIKit
import Foundation

/// Polymorphism in Swift
/// 1. Static Dispatch
/// 2. Dynamic Dispatch (vtable)
/// 3. Message Dispatch (obj-c runtime)

class Distribution {
    func sample() -> Double {
        fatalError("Must override")
    }
    func sample(count: Int) -> [Double] {
        return (1...count).map { _ in sample() }
    }
}

class UniformDistribution: Distribution {
    var range: ClosedRange<Int>
    init (range: ClosedRange<Int>){
        self.range = range
    }
    // virtual dispatch
    override func sample() -> Double {
        return Double(Int.random(in: range))
    }
}

let d20 = UniformDistribution (range: 1...20)
d20.sample()

// if the method is defined in the category, it can't be inherited
class Shape {
    func draw() {
        fatalError("Must Override")
    }
}
extension Shape {
    // the extension methods won't be put into the v-table
    // so it can't be inherited
    func area() -> Double {
        fatalError("Must Override")
    }
    // the @objc keyword will allow the override
    // but will change the dispatch type to message dispatch
    @objc func area1() -> Double {
        fatalError("Must Override")
    }
}

class Rectangle: Shape {
    override func draw() {
        print("draw Rectangle")
    }
    // Overriding non-@objc declarations from extensions is not supported
    // override func area() -> Double {}
    
    // don't need the @objc keyword for override
    override func area1() -> Double {
        print("Rectangle Area")
        return 0
    }
}

class DrawableBase: NSObject {
    // even though this class is an Obj-C class
    // the method is dispatched via the v-table
    func draw(){
        fatalError("Must override")
    }
}

class Circle: DrawableBase {
    override func draw() {
        
    }
}
