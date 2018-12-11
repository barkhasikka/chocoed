//
//  FriendTextReplyCell.swift
//  chocoed
//
//  Created by Mahesh Bhople on 14/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class FriendTextReplyCell: UITableViewCell {

    @IBOutlet weak var heightOfFrinedReplyDateConstraints: NSLayoutConstraint!
    @IBOutlet var lblDate: UILabel!
    
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var replyTitle: UILabel!
    
    
    @IBOutlet var msgTime: UILabel!
    @IBOutlet var msg: UILabel!
    @IBOutlet var replyFile: UIImageView!
    
    @IBOutlet var replyType: UIImageView!
    @IBOutlet var replyMsg: UILabel!
    
    @IBOutlet var replyView: UIView!
    
    @IBOutlet var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
