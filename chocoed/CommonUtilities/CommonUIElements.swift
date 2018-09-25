//
//  CommonUIElements.swift
//  chocoed
//
//  Created by barkha sikka on 25/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

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
