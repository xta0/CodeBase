import UIKit

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

//Protocol is also a type
class DinnerCrew {
    var members: [Souschef]
    init(members:[Souschef]) {
        self.members = members
    }
}

var roomate = Roomate(hungry: false, name: "Jack")
var crew = DinnerCrew(members: [roomate])

extension Roomate {
    func mixin(vegies:String) -> String {
        return "\(self.name)" + vegies
    }
}
var roomate2 = Roomate(hungry: false, name: "Kate")
print(roomate2.mixin(vegies: "tomato"))
