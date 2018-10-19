//
//  CommonUIElements.swift
//  chocoed
//
//  Created by barkha sikka on 25/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit


extension UIButton {
    
    func centerVerticallyHere(padding: CGFloat = 0.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        print("imageview size", imageViewSize, "label size", titleLabelSize, "total height", totalHeight)
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 20,
            bottom: 10,
            right: 0.0
        )
        print(self.titleEdgeInsets)
        self.titleEdgeInsets = UIEdgeInsets(
            top: 20,
            left: -40,
            bottom: -40,
            right: 0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
    func centerVerticallyWithoutLabel() {
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0.0
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
       
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0,
            right: 0.0
        )
    }
    
}

class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
      //  self.setImage(UIImage(named: "avatar_2.png"), for: .normal)
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.layer.cornerRadius = 8
        self.clipsToBounds =  true
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
}

class BoldLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.textAlignment = .left
        self.font = UIFont(name: "Halvetica", size: 17)
        self.textColor = UIColor.blue
    }
}

class imagetoButton : UIButton{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
        print("im required init")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
         print("in override init")
    }
    
    func initializeLabel() {
        print("image to button")
       // let playButton  = UIButton(type: .custom)
       // self..setImage(UIImage(named: "play.png"), for: .normal)
        
        
        self.setBackgroundImage(UIImage(named: "loginButtonBackground" ), for: .normal)
        self.layer.cornerRadius = 20
        self.clipsToBounds =  true
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.1264051212, green: 0.3580443426, blue: 1, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

class ShadowView : UIView{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
       // let viewShadow = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
      //  viewShadow.center = self.view.center
       // viewShadow.backgroundColor = UIColor.yellow
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
    }
}

class DraggableImageView: UIImageView {
    
    
    var dragStartPositionRelativeToCenter : CGPoint?
    
    override init(image: UIImage!) {
        super.init(image: image)
        
        self.isUserInteractionEnabled = true   //< w00000t!!!1
        
//        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePan:"))
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(nizer:))))
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePan(nizer: UIPanGestureRecognizer!) {
        if nizer.state == UIGestureRecognizerState.began {
            let locationInView = nizer.location(in: superview)
            dragStartPositionRelativeToCenter = CGPoint(x: locationInView.x - center.x, y: locationInView.y - center.y)
            layer.shadowOffset = CGSize(width: 0, height: 20)
            layer.shadowOpacity = 0.3
            layer.shadowRadius = 6
            
            return
        }
        
        if nizer.state == UIGestureRecognizerState.ended {
            dragStartPositionRelativeToCenter = nil
            
            layer.shadowOffset = CGSize(width: 0, height: 3)
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 2
            
            return
        }
        
        let locationInView = nizer.location(in: superview)
        
        UIView.animate(withDuration: 0.1) {
            self.center = CGPoint(x: locationInView.x - self.dragStartPositionRelativeToCenter!.x,
                                  y: locationInView.y - self.dragStartPositionRelativeToCenter!.y)
        }
}
}

//class BackgroundView : UIView{
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        applyBackground()
//    }
//    
//    func applyBackground() {
//        print(self.frame, "blah blah blah blah")
////        self.backgroundColor = UIColor(patternImage: UIImage(named: "back_circle_behind picture.png")!)
////        var imageView : UIImageView!
////        imageView = UIImageView(frame: self.bounds)
////        imageView.clipsToBounds = true
////        imageView.image = UIImage(named: "back_circle_behind picture")
////        imageView.center = self.center
////        self.addSubview(imageView)
////        self.sendSubview(toBack: imageView)
////        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        
//          let backgroundImage = UIImageView(frame: frame)
//          backgroundImage.image = UIImage(named: "back_circle_behind picture")
//          backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
//          self.insertSubview(backgroundImage, at: 0 )
//    }
//}


