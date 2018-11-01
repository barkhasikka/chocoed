//
//  FriendCell.swift
//  chocoed
//
//  Created by Mahesh Bhople on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet var friendImage: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var last_msg: UILabel!
    
    @IBOutlet var lastMsgImage: UIImageView!
    
    
    @IBOutlet var read_count: UILabel!
    
    @IBOutlet var last_msg_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
