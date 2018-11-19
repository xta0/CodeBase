/*
 Optionals
 */

let lists:Array = ["a","b","c"];
//str is an optional type
var str = lists.last;

if let str = str{
    //str is not optional
    print(str);
}
//still optional here

/*
 guard
 */
func sayHello(numberOfTimes: Int) {
    guard numberOfTimes > 0 else {
        return
    }
    
    for _ in 1...numberOfTimes {
        print("Hello!")
    }
}
sayHello(numberOfTimes: 1);

//with optional bindings
