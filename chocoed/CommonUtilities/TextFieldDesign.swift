//
//  TextFieldDesign.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = UITextBorderStyle.none;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
//
extension UIView{
    func applyBackground(){
        print("frames",self.frame)
        let backgroundImage = UIImageView(frame: self.bounds)
        backgroundImage.image = UIImage(named: "card_bg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
        self.insertSubview(backgroundImage, at: 0 )

        
    }
    func removeBackground(){
        for v in self.subviews
        {
            if v is UIImageView{
                let viv = v as? UIImageView
                if viv?.image ==  UIImage(named: "card_bg") {
                    v.removeFromSuperview()
                }
            }
        }
    }
}

extension String{
    func  localizableString(loc: String) -> String {
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}


