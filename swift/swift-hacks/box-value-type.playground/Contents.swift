import UIKit

/*
 Boxing and unboxing can be helpful if you’re facing significant referencing counting performance issues.
 If a struct contains an object as one of its properties, that object is reference counted
 
 For something small this isn’t a problem, but if your struct has lots of objects as properties – let’s say 10
 then suddenly ARC has to do 10 reference increments and decrements each time your struct is copied. In this
 situation, boxing your struct in a wrapper object simplifies things dramatically, because ARC would only need to
 manipulate the reference count for the box, not for all the individual properties.
 */

// Box the value type into a ref type, so the value type can be shared across
final class Box<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}
extension Box: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        value.description
    }
}

extension Box: Equatable where T: Equatable {
    static func == (lhs: Box, rhs: Box) -> Bool {
        return lhs.value == rhs.value
    }
}

extension Box: Comparable where T: Comparable {
    static func <(lhs: Box, rhs: Box) -> Bool {
        lhs.value < rhs.value
    }
}

extension Box: Hashable where T: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

extension Box: Identifiable where T: Identifiable {
    var id: T.ID { value.id }
}


struct Store {
    let name: String
    let address: String
    var isOpen: Bool
}

struct HomeScreen {
    var store: Box<Store>
}

struct PurchaseScreen {
    var store: Box<Store>
}






