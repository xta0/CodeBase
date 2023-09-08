import UIKit

var greeting = "Hello, playground"

import Foundation

struct ScanEntry {
    let parent: ScanEntry?
    var parentOffset: Int
    let address: Pointer
    var index: Int
}

struct ScanResult {
//    let entry:
}
//func scan_mem<T>(var x: T, limit: Int) -> void {
//    withUnsafePointer(to: <#T##T#>, <#T##(UnsafePointer<T>) -> Result#>)
//}

func dump_mem<T>(x: T) {
    print("Dumping \(x)")
}
