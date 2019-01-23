//
//  DashButtonCollectionViewCell.swift
//  chocoed
//
//  Created by Tejal on 23/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class DashButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonTitle: UILabel!
    @IBOutlet weak var buttonImage: UIButton!
    
    @IBOutlet weak var viewRoundedcorner: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
//
//        self.viewRoundedcorner.layer.cornerRadius = 5
//        self.viewRoundedcorner.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        self.viewRoundedcorner.clipsToBounds = true
        let backgroundImage = UIImageView(frame: frame)
        
        backgroundImage.image = UIImage(named: "card_bg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
        self.viewRoundedcorner.insertSubview(backgroundImage, at: 0 )
        // Initialization code
    }

    
}
