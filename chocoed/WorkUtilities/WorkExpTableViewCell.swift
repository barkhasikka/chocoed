//
//  WorkExpTableViewCell.swift
//  chocoed
//
//  Created by Tejal on 22/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class WorkExpTableViewCell: UITableViewCell {

    @IBOutlet weak var value: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class ExistingWorkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var fromToDetailsLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class ExistingEducationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelInstitute: UILabel!
    @IBOutlet weak var labelQualification: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
