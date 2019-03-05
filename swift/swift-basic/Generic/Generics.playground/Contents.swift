// Playground - noun: a place where people can play

import Foundation

///////////////
/// Generics
///////////////

/// [Generic Functions]
//generic:函数名称后面声明<T>
func SWAP<T>(_ x:inout T, _ y: inout T )
{
    let tmp = x
    x = y
    y = tmp
}

var a = 42
var b = 43
SWAP(&a, &b)
print(a,b)

/// [Type Constraints]
// 对泛型T进行类型约束
class SomeClass {}
func someFunction<T: SomeClass, U: Equatable> (someT: T, someU: U){
    // T is subclass of SomeClass
    // U must conforms Equatable
}
let strList:[String] = ["a","c","d"]
// add constraint to type 'T'
func indexOf<T: Equatable>(target:T,array:[T]) ->Int?{
    for(index,value) in array.enumerated(){
        if value == target{
            return index
        }
    }
    return nil
}

let indexStr = indexOf(target: "c", array: strList)!
let indexInt = indexOf(target: 3, array: [1,2,3])!

/// [Generic Types]

// Generic Stack class Template
struct Stack<T> {
    var items = [T]()
    mutating func push(_ item:T) {
        items.append(item)
    }
    mutating func pop() ->T{
        return items.removeLast()
    }
}
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")



// Generic Ordered map
struct OrderedDictionary<KeyType:Hashable,ValueType>{
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType:ValueType]
    
    // a linked list as index
    var array = ArrayType()
    var dicationary = DictionaryType()
    var count:Int{
        return array.count
    }
    
    //mutating:
    //Struct are designed to be immutable by default, meaning you can not mutate struct member variables in
    //an instance method.You can add "mutating" keyword to let the compiler allow this happen
    
    mutating func insert(value: ValueType,forkey key: KeyType,atIndex index:Int) -> ValueType?{
        var adjustedIndex = index
        let existingValue = self.dicationary[key];
        if existingValue != nil {
            let existingIndex = self.array.firstIndex(of: key)!
            if existingIndex < index{
                adjustedIndex -= 1
            }
            // if the old value exists, remove it
            array.remove(at: existingIndex)
        }
        self.array.insert(key, at: adjustedIndex)
        self.dicationary[key] = value
        return existingValue
    }
    
    mutating func removeAtIndex(index:Int) -> (KeyType,ValueType){
        precondition(index < self.array.count, "Index out of bounds")
        let key = self.array.remove(at: index)
        //确定value不为空，则直接使用!符号
        let value = dicationary.removeValue(forKey: key)!
        return (key,value)
    }
    
    //实现dictionary的access
    //实现subscription接口 => dict[key]=value
    subscript(key: KeyType) -> ValueType?{
        get{
            return self.dicationary[key]
        }
        set{
            let index = self.array.firstIndex(of: key)
            if index == nil  {
                self.array.append(key)
            }
            //newValue是一个implicity参数
            self.dicationary[key] = newValue
        }
    }
    
    // value = dict[0]
    // 按index访问，返回一个tuple
    subscript(index:Int) -> (KeyType,ValueType)?{
        get{
            precondition(index < self.array.count, "Index out of bounds")
            let key = self.array[index]
            let value = self.dicationary[key]!
            return (key,value)
        }
        set{
            precondition(newValue != nil, "new value is nil!")
            let newTuple:(KeyType,ValueType) = newValue!
            if index < self.array.count{
                let key = self.array[index]
                // remove the key from array
                self.array.remove(at: index)
                // remove corespond value for key
                self.dicationary.removeValue(forKey: key)
                // insert new key to the array with given index
                self.array.insert(newTuple.0, at: index)
                // udpate the dictionary with new k-v
                self.dicationary[newTuple.0] = newTuple.1
            }
            else{
                self.array.append(newTuple.0)
                self.dicationary[newTuple.0] = newTuple.1
            }
        }
    }
}

var orderedDict = OrderedDictionary<String, String>()
orderedDict.insert(value: "dog", forkey: "Monday", atIndex: 0)
orderedDict.insert(value: "cat", forkey: "Tuesday", atIndex: 1)
var dogIndex:(String,String) = orderedDict[0]!
print(dogIndex)
orderedDict["Thursday"] = "pig"

/// [Extending a Generic Type]
// extend 类模板时，类型参数T仍然有效
extension Stack {
    var top: T? {
        return items.isEmpty ? nil : items[items.count-1]
    }
}



