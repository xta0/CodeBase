import UIKit

protocol HeaderView {
    func setTitle(_ string: String)
}

class ParallaxView: UIView {
    let headerView: UIView & HeaderView
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
