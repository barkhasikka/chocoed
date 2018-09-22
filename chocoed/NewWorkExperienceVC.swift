//
//  NewWorkExperienceVC.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class NewWorkExperienceVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableViewFromButton: UITableView!
    @IBOutlet weak var fromButtonView: UIView!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var textFieldCompany: UITextField!
    var arrayOfValues = ["1990","1991","1992","1993","1994","1995","1996"]
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
    
    @IBAction func toButtonAction(_ sender: Any) {
        
        
    }
    @IBAction func ManagementLevelButtonAction(_ sender: Any) {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellwork") as! WorkExpTableViewCell
        let titlename = arrayOfValues[indexPath .row]
        cell.value.text = titlename
        return cell
    }
}
