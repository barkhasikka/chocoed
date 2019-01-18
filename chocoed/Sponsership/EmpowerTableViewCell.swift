//
//  EmpowerTableViewCell.swift
//  chocoed
//
//  Created by Tejal on 18/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class EmpowerTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewEmpower: UIImageView!
    @IBOutlet weak var amountlabel: UILabel!
    @IBOutlet weak var NameofContact: UILabel!
    
    @IBOutlet weak var labelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
