import UIKit
import Foundation

/// abstract class
protocol Shape {
    func draw(context: CGContext)
    var boundingBox: CGRect { get }
    func rotate(by angle: CGFloat) -> Shape
}

extension Shape {
    func image() -> UIImage {
        let renderer = UIGraphicsImageRenderer (bounds: boundingBox)
        return renderer.image {
            draw(context: $0.cgContext)
        }
    }
    
    /// methods in protocol extention are staticly dispatched
    func rotate(by angle: CGFloat) -> Shape{
        return TransformedShape(original: self, transform: CGAffineTransform(rotationAngle: angle))
    }
}


/// a wrapper of object that conforms to the Shape protocol
struct TransformedShape {
    var original: Shape
    var transform: CGAffineTransform
}
extension TransformedShape: Shape {
    var boundingBox: CGRect {
        return original.boundingBox.applying(transform)
    }
    func draw(context: CGContext) {
        context.saveGState()
        context.concatenate(transform)
        original.draw(context: context)
        context.restoreGState()
    }
}

struct Rectangle: Shape {
    var origin: CGPoint
    var size: CGSize
    var color: UIColor = .red
    
    var boundingBox: CGRect {
        return CGRect(origin: origin, size: size)
    }
    func draw(context: CGContext) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.fill(boundingBox)
        context.restoreGState()
    }
}

struct Circle: Shape {
    var center: CGPoint
    var radius: CGFloat
    var color: UIColor = .red
    
    var boundingBox: CGRect {
        return CGRect(x: center.x - radius, y: center.y - radius, width: radius*2, height: radius*2)
    }
    func draw(context: CGContext) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.fillEllipse(in:boundingBox)
        context.restoreGState()
    }
    
    // for the Circle shape, overrides the rotate method and simply returns `self`
    func rotate(by angle: CGFloat) -> Shape {
        return self
    }
}



let rect: Shape = Rectangle(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 200), color: .green)
rect.rotate(by: CGFloat(M_PI/6)).image()

let circle: Shape = Circle(center: CGPoint(x: 100, y: 100), radius: 100, color: .yellow)
circle.rotate(by: CGFloat(M_PI)).image()




