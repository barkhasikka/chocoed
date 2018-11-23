//
//  FriendFileView.swift
//  chocoed
//
//  Created by Mahesh Bhople on 09/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class FriendFileView: UITableViewCell {
    
    
    
    
    @IBOutlet var lblDate: UILabel!
    
    
    @IBOutlet var btnDownload: UIButton!
    
    
    @IBOutlet var progressView: UIActivityIndicatorView!
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var fileView: UIImageView!
    @IBOutlet var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
