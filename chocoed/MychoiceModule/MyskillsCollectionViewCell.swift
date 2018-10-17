//
//  MyskillsCollectionViewCell.swift
//  chocoed
//
//  Created by Tejal on 10/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class MyskillsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.borderWidth = 2
        self.view.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    
    
}
