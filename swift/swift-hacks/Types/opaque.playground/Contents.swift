import UIKit

protocol Employee: Equatable { }
struct Coder: Employee { }
struct Boss: Employee { }

// some sort of Employee but we don't know what
//func login1() -> Employee {
//    return Coder()
//}

// "some" is introduced in Swift 5.1
// A specific sort of Employee (Equatable) and we still don't know what
// But the compiler does
func login() -> some Employee {
    return Coder()
}
