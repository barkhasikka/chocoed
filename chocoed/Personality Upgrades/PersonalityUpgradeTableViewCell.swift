//
//  PersonalityUpgradeTableViewCell.swift
//  chocoed
//
//  Created by Tejal on 11/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class PersonalityUpgradeTableViewCell: UITableViewCell {
    
    

    @IBOutlet var lblExamCount: UILabel!
    @IBOutlet var lblTopicCount: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
class TopicStatusTableViewCell: UITableViewCell {
    
    @IBOutlet var blockView: UIView!
    @IBOutlet var lblViews: UILabel!
    @IBOutlet weak var viewTopics: UIView!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
