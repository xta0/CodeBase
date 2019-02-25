import Foundation
import UIKit

/// Class Based Design

/// abstract class
class Shape {
    func draw(context: CGContext) {
        fatalError("Subclass needs to override this method")
    }
    var boundingBox: CGRect {
        fatalError("Subclass needs to override this method")
    }
    func image() -> UIImage {
        let renderer = UIGraphicsImageRenderer (bounds: boundingBox)
        return renderer.image {
            draw(context: $0.cgContext)
        }
    }
}

class Rectangle: Shape {
    var origin: CGPoint
    var size: CGSize
    var color: UIColor = .red
    
    init(origin: CGPoint, size: CGSize) {
        self.origin = origin
        self.size = size
    }
    override var boundingBox: CGRect {
        return CGRect(origin: origin, size: size)
    }
    override func draw(context: CGContext) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.fill(boundingBox)
        context.restoreGState()
    }
}

class Circle: Shape {
    var center: CGPoint
    var radius: CGFloat
    var color: UIColor = .red
    
    init(center: CGPoint, radius: CGFloat) {
        self.center = center
        self.radius = radius
    }
    override var boundingBox: CGRect {
        return CGRect(x: center.x - radius, y: center.y - radius, width: radius*2, height: radius*2)
    }
    override func draw(context: CGContext) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.fillEllipse(in:boundingBox)
        context.restoreGState()
    }
}

let rect = Rectangle(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 200))
rect.image()

let circle = Circle(center: CGPoint(x: 50, y: 50), radius: 100)
circle.image()



