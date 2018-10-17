//
//  LanguageTableViewCell.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var labelLanguage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}


class CommonLanguageTableViewCell: UITableViewCell {
    
    var labelLanguage: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        labelLanguage = UILabel()
        addSubview(labelLanguage)
    }
}
