//
//  myTextReplyCell.swift
//  chocoed
//
//  Created by Mahesh Bhople on 14/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class myTextReplyCell: UITableViewCell {
    
    
    
    @IBOutlet var replyView: UIView!
    
    
    @IBOutlet var mainView: UIView!
    
    
    @IBOutlet var replyTitle: UILabel!
    
    @IBOutlet var imgReplyType: UIImageView!
    
    @IBOutlet var replyFile: UIImageView!
    
    @IBOutlet var lblreplyMsg: UILabel!
    
    
    @IBOutlet var lblMsg: UILabel!
    
    @IBOutlet var lbltime: UILabel!
    
    
    @IBOutlet var imgAck: UIImageView!
    
    
    @IBOutlet var imgProfile: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
