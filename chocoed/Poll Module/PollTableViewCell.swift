//
//  PollTableViewCell.swift
//  chocoed
//
//  Created by Tejal on 25/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class PollTableViewCell: UITableViewCell {

    @IBOutlet weak var ViewPoll: UIView!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var pollDate: UILabel!
    @IBOutlet weak var pollName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        ViewPoll.layer.cornerRadius = 5
        ViewPoll.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
