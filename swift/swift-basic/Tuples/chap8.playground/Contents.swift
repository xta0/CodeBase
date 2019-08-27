import UIKit

/*
 =====
 tuples
 =====
 */

/*
 1. mutable tuple vs immutable tuple
 2. after a tuple is created, we can't add or delete elements in it
 3. we can mutate the value of mutated tuple, but can't change its type
 4. element's type can be type of any
 */

/*
 unnamed tuples
 */
let tipAndTotal = (4.00,25)

//access
print(tipAndTotal.0)
print(tipAndTotal.1)

// create a const tuple
let result =  (1, "no access")
print(result)
print(result.0)
print(result.1)
//result.0 = 100 //can't mutate a const tuples

//binding
let(a,b) = tipAndTotal
print(a)
print(b)

/*
named tuples
*/
var tipAndTotal2:(tipAmt:Double,total:Double) = (3.00,200)

print(tipAndTotal2.tipAmt)
print(tipAndTotal2.total)

//tipAndTotal2 is a mutable tuple
tipAndTotal2.0 = 100
print(tipAndTotal2.tipAmt)


//any can be any type
var input: (tensor:Any, size: Int) = ([[1,2],[3.4]], 4)
print(input.0)
input.tensor = "[1,2],[3,4]" //legal, because the type is any
print(input.0)


//tuple as return values
let total = 21.19
let taxPct = 0.06
let subtotal = total / (taxPct + 1)

func calcTipWithTipPct(tip: Double) -> (tipAmt:Double,total:Double)
{
    let tipAmt = subtotal * tip
    let finalTotal = total + tipAmt
    
    return(tipAmt,finalTotal)
}

//tuple vs. class
func return3values() -> (a:String,b:String,c:String)
{
    return ("a","b","c")
    
}

let error = (404,"Not Found")

//pattern matching
switch error
{
case(200,_):
    print("success")
case(_,"Not Found"):
    print("err")
case(300...399,_):
    print("Redirect")
case(500,let description):
    print("\(description),please")
case let (code,description):
    print("\(code),\(description)")
}

var name1 = "Ray"
var name2 = "Wenderlich"

(name1,name2) = ("Brain","Moakley")
(name1,name2) = (name2,name1)



