import UIKit

/*
 =====
 tuples
 =====
 */


/*
 unnamed tuples
 */
let tipAndTotal = (4.00,25)

//access
print(tipAndTotal.0)
print(tipAndTotal.1)


//binding
let(a,b) = tipAndTotal
print(a)
print(b)

/*
named tuples
*/
let tipAndTotal2:(tipAmt:Double,total:Double) = (3.00,200)

print(tipAndTotal2.tipAmt)
print(tipAndTotal2.total)

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



