import UIKit
import Foundation

/// Copy-on-Write

var sampleBytes: [UInt8] = [0x8b, 0xad, 0xf0, 0x0d]

// nsdata is a referene type, mutability is not controlled by `let` or `var`
let nsData = NSMutableData(bytes: sampleBytes, length: sampleBytes.count)
var nsOtherData = nsData
// mutating `nsData`, `nsOtherData` is also changed
nsData.append(sampleBytes, length: sampleBytes.count)
// if you want to make a copy, you need to do it explicitly
nsOtherData = nsData.mutableCopy() as! NSMutableData


/// Data is a value type
let value_type_data = Data(bytes: sampleBytes)
let copyData = value_type_data // creat a copy

/// Copy on Write is a "lazy" copy technique, copy happens only when the
/// copied the data gets modified

// no real copy happened
var anotherData = value_type_data
// copy happend
anotherData.append(sampleBytes, count: sampleBytes.count)

struct MyData {
    var data = Box(NSMutableData())
    var dataForWriting: NSMutableData {
        mutating get {
            // check if MyData is the only owner of `data`
            // only works with Obj-C object
            // to use this, we need a wrapper
            if isKnownUniquelyReferenced(&data) {
                return data.unbox
            }
            print("making a copy")
            data = Box(data.unbox.mutableCopy() as! NSMutableData) //deep copy
            return data.unbox
        }
    }
    
    mutating func append(_ bytes:[UInt8]) {
        dataForWriting.append(bytes, length: bytes.count)
    }
}

extension MyData: CustomStringConvertible {
    var description: String {
        return String(describing: data)
    }
}

final class Box<T> {
    let unbox: T
    init(_ value: T) {
        unbox = value
    }
}

var myData = MyData()
//creat a copy, this won't trigger copy on write
//copy internal `data` which is a pointer, shallow copy
// we need to make `append` method a deep copy one
let copyMyData = myData

// this will trigger the deep copy
myData.append(sampleBytes)



