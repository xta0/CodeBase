import UIKit

// work with any sort of input and output as long as the input is hashable, accept a function that takes Input and returns Output, and send back a function that accepts Input and returns Output
func memoize<Input: Hashable, Output>(_ function: @escaping (Input) -> Output) -> (Input) -> Output {
    // our item cache
    var storage = [Input: Output]()

    // send back a new closure that does our calculation
    return { input in
        if let cached = storage[input] {
            return cached
        }

        let result = function(input)
        storage[input] = result
        return result
    }
}

func fib(_ n: Int) -> Int {
    if n < 2 {
        return n
    }
    return fib(n-1) + fib(n-2)
}

let memoizedFib = memoize(fib)

let y = memoizedFib(3)
print(y)

