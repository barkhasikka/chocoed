//
//  ContentCell.swift
//  chocoed
//
//  Created by Mahesh Bhople on 14/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet var videoView: UIView!
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var lblDesc: UILabel!
    
    @IBOutlet var lblCount: UILabel!
    
    @IBOutlet var lblTopicStatus: UILabel!
    
    @IBOutlet var blockView: UIView!
    @IBOutlet var lblExamStatus: UILabel!
    @IBOutlet var lblExamDetails: UILabel!
    @IBOutlet var lblExam: UILabel!
    @IBOutlet var examView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
