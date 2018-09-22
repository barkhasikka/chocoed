//
//  NewWorkExperienceVC.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class NewWorkExperienceVC: UIViewController {

    @IBOutlet weak var tableViewFromButton: UITableView!
    @IBOutlet weak var fromButtonView: UIView!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var textFieldCompany: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        fromButtonView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fromButtonAction(_ sender: Any) {
        fromButtonView.isHidden = false
        
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
