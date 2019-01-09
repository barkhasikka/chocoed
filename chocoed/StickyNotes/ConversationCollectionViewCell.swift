//
//  ConversationCollectionViewCell.swift
//  chocoed
//
//  Created by Tejal on 07/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class ConversationCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        self.view.layer.borderWidth = 2
        //        self.view.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        //
        let backgroundImage = UIImageView(frame: frame)
        
        backgroundImage.image = UIImage(named: "card_bg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
        self.view.insertSubview(backgroundImage, at: 0 )
    }

}
