import Foundation

/// Protocols use "Protocol Witness Table" to do dynamic dispatching
/// A class can only have one vtable, but many witness tables
protocol Distribution {
    func sample() -> Double
    func sample(count: Int) -> [Double]
}
extension Distribution {
    // default implementation
    func sample(count: Int) -> [Double] {
        return (1...count).map { _ in sample()}
    }
}

struct UniformDistribution: Distribution {
    var range: ClosedRange<Int>
    init(range: ClosedRange<Int>) {
        self.range = range
    }
    func sample() -> Double {
        return Double(Int.random(in: range))
    }
}
let d10 = UniformDistribution(range: 1...10)
d10.sample(count: 100)
