//
//  MytagUlistTableViewCell.swift
//  chocoed
//
//  Created by Tejal on 05/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class MytagUlistTableViewCell: UITableViewCell {

    @IBOutlet weak var viewRoundedcorner: UIView!
    @IBOutlet weak var imagePin: UIImageView!
    @IBOutlet weak var labelDiscription: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var gradiantImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    self.viewRoundedcorner.layer.cornerRadius = 5
    self.viewRoundedcorner.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    self.viewRoundedcorner.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
