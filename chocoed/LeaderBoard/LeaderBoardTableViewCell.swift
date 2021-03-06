//
//  LeaderBoardTableViewCell.swift
//  chocoed
//
//  Created by Tejal on 27/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {

    
    @IBOutlet var friendICon: UIImageView!
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var noofTest: UILabel!
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var noofCOurses: UILabel!
    @IBOutlet weak var CoursesImage: UIImageView!
    @IBOutlet weak var noOfWeek: UILabel!
    @IBOutlet weak var weekImage: UIImageView!
    @IBOutlet weak var NameLeader: UILabel!
    @IBOutlet weak var imageViewLeader: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageViewLeader.layer.cornerRadius = 30
        imageViewLeader.clipsToBounds = true
        
        rank.layer.cornerRadius = 10
        rank.clipsToBounds = true
        rank.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.4235294118, blue: 0.7254901961, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class LeaderBoardAddContactTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var checkUncheckImageView: UIImageView!
    @IBOutlet weak var imageOfContact: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageOfContact.layer.cornerRadius = 30
        imageOfContact.clipsToBounds = true
    }
    
}
