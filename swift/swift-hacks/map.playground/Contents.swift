import UIKit


func lengthOf(strings: [String]) -> [Int] {
    return strings.map { $0.count }
}

// optional map
// if the original type is optional, the mapped type is also optional
let i: Int? = 10
let j = i.map { $0 * 2 }
print(j) //optional(20)

func fetchUsername(id: Int) -> String? {
    if id == 1989 {
        return "Taylor Swift"
    } else{
        return nil
    }
}

var username: String? = fetchUsername(id: 1989)
let formattedUsername = username.map { "Welcome, \($0)!" } ?? "Unknown user"
print(formattedUsername)

/// CompactMap

/// Swift has a specialized form of map() called compactMap(), which applies a compacting step once the map() operation has completed: all optionals get unwrapped, and any that contained nil get discarded.”

let albums: [String?] = ["Fearless", nil, "Speak Now", nil, "Red"]
let result = albums.map { $0 }
print(result) //albums is optional, so the result is also an array of optional strings
// [Optional("Fearless"), nil, Optional("Speak Now"), nil, Optional("Red")]

let result2 = albums.compactMap { $0 }
print(result2) // result2 is now of type [String]
// ["Fearless", "Speak Now", "Red"]

let scores = ["100", "90", "Fish", "85"]
let compactMapScores = scores.compactMap { Int($0) }
// in this case, after mapping, "Fish" becomes nil, so it'll be filtered out
print(compactMapScores)


/// flatMap

let numbers = [[1, 2], [3, 4], [5, 6]]
let joined = Array(numbers.joined())
// [1, 2, 3, 4, 5, 6]

/// The flatMap() method on sequences is effectively the combination of using map() and joined() in a single call, in that order. It maps items in array A into array B using a function you provide, then joins the results using concatenation.
let joined2 = numbers.flatMap { $0 }
print(joined2)

/// Optional flat map
// if your transformation closure returns an optional, flatMap() will combine that optional with the existing optional, whereas map() will keep them both”

let stringNumber: String? = "5"
let intNumber = stringNumber.map { Int($0) }
print(intNumber)
// intNumber is Optional(Optional(Int))
let flatMapNumber = stringNumber.flatMap { Int($0) }
print(flatMapNumber)
// flatMapNumber is Optional(Int)

/// If you’re not sure whether to use map() or flatMap() with your optional value, the simple rule is this: if your transformation closure returns an optional you should use flatMap(), to avoid optional optionals.
