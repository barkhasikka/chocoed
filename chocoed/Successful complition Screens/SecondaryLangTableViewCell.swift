//
//  SecondaryLangTableViewCell.swift
//  chocoed
//
//  Created by Tejal on 30/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class SecondaryLangTableViewCell: UITableViewCell {

    @IBOutlet weak var dbNameLabel: UILabel!
    @IBOutlet weak var labelSecLanguage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
