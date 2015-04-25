import Foundation
import UIKit

@objc protocol NBBallViewDelegate {
    func ballViewWasSelected(ballView: NBBallView, itemObject: NBItemObject)
}

@objc class NBBallView: UIView {
    var item: NBItemObject
    var delegate: NBBallViewDelegate
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding.")
    }
    
    init(frame: CGRect, item: NBItemObject, delegate: NBBallViewDelegate) {
        self.item = item
        self.delegate = delegate;
        super.init(frame: frame)
        self.layer.cornerRadius = 40.0
        self.backgroundColor = item.color
        self.layer.masksToBounds = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapped:"))
        if (self.item.imageName.length > 0) {
            var imageView = UIImageView(frame: CGRect(
                x: 0,
                y: 0,
                width: self.frame.size.width,
                height: self.frame.size.width));
            self.addSubview(imageView)
            imageView.image = UIImage(named: self.item.imageName as String!)
        }
    }
    
    func tapped(sender: AnyObject) {
        self.delegate.ballViewWasSelected(self, itemObject: self.item)
    }
}