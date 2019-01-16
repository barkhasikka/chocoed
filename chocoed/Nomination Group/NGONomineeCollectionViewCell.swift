//
//  NGONomineeCollectionViewCell.swift
//  chocoed
//
//  Created by Tejal on 03/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class NGONomineeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewImg: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        self.view.layer.borderWidth = 2
        //        self.view.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        //
        let backgroundImage = UIImageView(frame: frame)
        
        backgroundImage.image = UIImage(named: "card_bg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
        self.viewBack.insertSubview(backgroundImage, at: 0 )
    }
    
}
