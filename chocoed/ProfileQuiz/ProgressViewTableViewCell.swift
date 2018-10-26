//
//  ProgressViewTableViewCell.swift
//  chocoed
//
//  Created by Tejal on 26/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ProgressViewTableViewCell: UITableViewCell {

    @IBOutlet weak var Steps: UILabel!
    @IBOutlet weak var noofSteps: UILabel!
    @IBOutlet weak var namePerson: UILabel!
    @IBOutlet weak var imagePerson: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
