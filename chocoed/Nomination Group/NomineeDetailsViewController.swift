//
//  NomineeDetailsViewController.swift
//  chocoed
//
//  Created by Tejal on 07/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class NomineeDetailsViewController: UIViewController {

    @IBOutlet weak var nomineeLearningLang: UILabel!
    @IBOutlet weak var nomineeOccupation: UILabel!
    @IBOutlet weak var nomineeGovtid: UILabel!
    @IBOutlet weak var nomineeAge: UILabel!
    @IBOutlet weak var nomineeMobile: UILabel!
    @IBOutlet weak var nomineeName: UILabel!
    @IBOutlet weak var TopicsCompletedNo: UILabel!
    @IBOutlet weak var completedTestNo: UILabel!
    @IBOutlet weak var imgeProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        imgeProfile.image = UIImage(named: "Man1_1")
        imgeProfile.layer.cornerRadius = 42
        imgeProfile.layer.borderWidth = 2
        imgeProfile.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imgeProfile.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
