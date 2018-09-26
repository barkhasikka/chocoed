//
//  CommonUIElements.swift
//  chocoed
//
//  Created by barkha sikka on 25/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class AddNewButtonLabel: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.titleLabel?.font = UIFont(name: "Helvetica", size: 18)
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.backgroundColor = .white
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
        self.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
