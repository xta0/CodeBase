import UIKit
import Foundation

//================================
// Either or
//================================
/**
 Say we have a Message struct which only contains userId and content. As we keep adding new features to the app, we need to add more and more properties to the Message struct. This is not a good approach because we are adding more and more properties to the Message struct which is not scalable. We need to find a better way to model the Message struct.
 */
struct Message {
    let userId: String
    let content: String?
    let date: Date
    let hasJointed: Bool
    let hasLeft: Bool
    let isBeingDrafted: Bool
    let isSendingBalloons: Bool
}

/**
 A message can only be one or another in the business rule.
 It is also possible that the system will produce an invalid message.
 In this example, the join Message shouldn't contain the content, but somehow it does.
 We don't have compile time garantee that the message is in the right state.
 */
let joinMessage = Message(userId: "1", content: "Hi there", date: Date(), hasJointed: true, hasLeft: true, isBeingDrafted: false, isSendingBalloons: false)

/**
 This makes the Message type a either or situation.
 */
enum Message2 {
    case join
    case leave
    case text
    case draft
    case balloon
}

/**
 We can add a tuple to each case. In swift, this is called associated value.
 */
enum Message3 {
    case join(userId: String, date: Date)
    case leave(userId: String, date: Date)
    case text(userId: String, content: String?, date: Date)
    case draft(userId: String, date: Date)
    case balloon(userId: String, date: Date)
}

let textMessage = Message3.join(userId: "1", date: Date())
print(textMessage)

/**
 When we want to work with the messages, we can use a switch case on them and unwrap its inner values
 Associated data is accessed through a switch statement using "let"
 */
switch(textMessage){
case let .text(userId, content, date):
    print("userId: \(userId), content: \(String(describing: content)), date: \(date)")
case let .draft(userId, date):
    print("userId: \(userId), date: \(date)")
case let .join(userId, date):
    print("userId: \(userId), date: \(date)")
case let .leave(userId, date):
    print("userId: \(userId), date: \(date)")
case let .balloon(userId, date):
    print("userId: \(userId), date: \(date)")
}

/**
If we just want to check if a message matches a single case, we can use the `if case let` syntax
*/
if case let .text(userId, content, date) = textMessage {
    print("userId: \(userId), content: \(String(describing: content)), date: \(date)")
}

/*
 Deciding between enum and struct
 
 (1) If we catch up outselves pattern matching often on a single case, we should consider using a struct instead of an enum.
 (2) Keep in mind that the associated values of an enum are contains without additional logic. You don't get free initializers of properties; you'd have to mannually add these.
 (3) If you find yourself adding more and more properties to a struct, consider using an enum instead.
 */

//================================
// Use Enum for polymorphism
//================================

// Compile time polymorphsim

// Image that you'd like to store two different types in an array, such as a Date and Range<Date>

let now = Date()
let hourFromNow = Date(timeIntervalSinceNow: 3600)

// now i wanted to create an array that hold both elements
enum DateType {
    case singleDate(Date)
    case dateRange(Range<Date>)
}

let dates: [DateType]  = [
    DateType.singleDate(now),
    DateType.dateRange(now..<hourFromNow)
]

struct MyStruct<T: Numeric> {
    var int = 99
    var double = 88.0
    var array = [1,2]
    var generics: T = 1_000
    var string = "String"
}
var variable = MyStruct<Double>()
var values = [String:Any]()
print(variable)

let mirror = Mirror(reflecting: variable)
for (name, value) in mirror.children {
    values[name!] = value
}
print(values)
