//
//  CommonUIElements.swift
//  chocoed
//
//  Created by barkha sikka on 25/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit


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
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        
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

