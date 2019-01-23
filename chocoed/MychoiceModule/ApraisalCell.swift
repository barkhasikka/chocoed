//
//  ApraisalCell.swift
//  chocoed
//
//  Created by Mahesh Bhople on 21/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class ApraisalCell: UITableViewCell {

    @IBOutlet var lblViews: UILabel!
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var blockView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
