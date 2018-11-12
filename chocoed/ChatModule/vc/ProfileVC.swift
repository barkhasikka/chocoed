//
//  ProfileVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 10/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {
    
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var profileImage: UIImageView!
    
    var contactMobileNumber : String = ""
    var profileiMage : String = ""
    var name : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lblName.text = self.name
        self.profileImage.sd_setImage(with : URL(string: self.profileiMage))
        self.profileImage.contentMode = .scaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back_btn_clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func media_btn_clicked(_ sender: Any) {
        
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "MediaVC") as? MediaVC {
            vcNewSectionStarted.number = self.contactMobileNumber
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
    }
    @IBAction func block_btn_clicked(_ sender: Any) {
    }
    
}
