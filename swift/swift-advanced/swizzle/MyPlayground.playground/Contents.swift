import UIKit

var greeting = "Hello, playground"

class AppDelegate {
    @objc dynamic func f1() {
        print("this is f1")
    }
}
extension AppDelegate {
    @objc dynamic func f2() {
        print("this is f2")
    }
}

let defaultInstace = class_getInstanceMethod(AppDelegate.self, #selector(AppDelegate.f1))
let newInstance = class_getInstanceMethod(AppDelegate.self, #selector(AppDelegate.f2))

if let instance1 = defaultInstace, let instance2 = newInstance {
    method_exchangeImplementations(instance1, instance2)
    let ap1 = AppDelegate()
    ap1.f1()
}


//class AppDelegate3: UIViewController {
//    @objc func f3() {
//        print("this is f3")
//    }
//}
//class AppDelegate4 {
//    @objc func f4() {
//        print("this is f4")
//    }
//}
//
//let defaultInstace3 = class_getInstanceMethod(AppDelegate3.self, #selector(AppDelegate3.f3))
//let newInstance4 = class_getInstanceMethod(AppDelegate4.self, #selector(AppDelegate4.f4))
//
//if let instance3 = defaultInstace3, let instance4 = newInstance4 {
//    method_exchangeImplementations(instance3, instance4)
//    let ap3 = AppDelegate3()
//    ap3.f3()
//}
