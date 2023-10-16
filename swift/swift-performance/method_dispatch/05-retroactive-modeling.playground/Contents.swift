import CoreGraphics

/// Swift中的extension可以实现protocol
/// 语法为 extension xx : protocol

struct Circle {
    var origin: CGPoint
    var radius: CGFloat
}

let circle = Circle(origin: .zero, radius: 10)
let rect = CGRect(origin: .zero, size: CGSize(width: 300, height: 300))

/// 即使Circle和CGRect在定义完成后
/// 仍然可以让他们conform一个protocol
protocol Geometry {
    var origin: CGPoint {get set}
    func area() -> CGFloat
}

extension Circle: Geometry {
    func area() -> CGFloat {
        return .pi * radius * radius
    }
    // 由于Circle已经有origin的property，因此不需要在这里实现
    // CGRect 同理
}

extension CGRect: Geometry {
    func area() -> CGFloat {
        return size.width * size.height
    }
}

/// 使用Geometry做类型
let shapes: [Geometry] = [circle, rect]
let area = shapes.reduce(0, {$0 + $1.area()})
print("\(area)")
