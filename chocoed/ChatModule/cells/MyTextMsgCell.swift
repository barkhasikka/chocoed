//
//  MyTextMsgCell.swift
//  chocoed
//
//  Created by Mahesh Bhople on 08/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class MyTextMsgCell: UITableViewCell {
    
    
    @IBOutlet var profileImga: UIImageView!
    @IBOutlet var lblMsg: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
    var item: Msg? {
        didSet {
            guard  let item = item else {
                return
            }
            
            lblMsg?.text = item.msg
            lblTime?.text = item.created
        }
    }
    
    
    
}
