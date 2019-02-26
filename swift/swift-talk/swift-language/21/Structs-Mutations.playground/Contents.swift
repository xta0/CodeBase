import UIKit
import Foundation

var x = [3,1,2]
let y = x
// sort will mutate x in place, but y is unchanged
x.sort()
// sorted will return a new array, leave y unchanged
let z = y.sorted()

struct Account {
    var balance: Int
    // instead of mutating `balance`, return a new Account instance
    func depositing(amount: Int) -> Account {
        return Account(balance: balance+amount)
    }
    // mutating version
    mutating func deposit(amount: Int){
        balance += amount
    }
}

// in this way, we can use method chaining to make it more functional
let balance = Account(balance: 0).depositing(amount: 100).depositing(amount: 100).balance
print(balance)

// use `inout` to mutate from outside
// `inout`并不是直接修改传入的对象的指针，而是在函数中copy一份数据，修改该份数据之后，在函数返回前再copy回去
func deposite(amount: Int, into account: inout Account){
    account.balance += amount
}
var account = Account(balance: 10)
deposite(amount: 100, into: &account)
account.balance
