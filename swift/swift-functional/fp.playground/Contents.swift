import Foundation

// filter
func filterExample() {
    let numbers: [Int] = [1, 2, 3, 4, 5]
    let evenNumbers: [Int] = numbers.filter { $0 % 2 == 0 }
    print(evenNumbers)
}

