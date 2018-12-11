//
//  MyFileViewCell.swift
//  chocoed
//
//  Created by Mahesh Bhople on 09/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class MyFileViewCell: UITableViewCell {
    
    
    @IBOutlet weak var heightOfMyFileDateLabel: NSLayoutConstraint!
    @IBOutlet var btnUpload: UIImageView!
    
    @IBOutlet var lblDate: UILabel!
    
    @IBOutlet var progressView: UIActivityIndicatorView!
    
 
    
    @IBOutlet var msgAck: UIImageView!
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var fileview: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
