//
//  NewWorkExperienceVC.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class NewWorkExperienceVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var funcExpButton: UIButton!
    @IBOutlet weak var currentIndustryButton: UIButton!
    @IBOutlet weak var termsHandeledButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    
    @IBOutlet weak var managementLevelButton: UIButton!
    @IBOutlet weak var tableViewFromButton: UITableView!
    @IBOutlet weak var fromButtonView: UIView!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var textFieldCompany: UITextField!
    var arrayOfValues = ["1990","1991","1992","1993","1994","1995","1996"]
    override func viewDidLoad() {
        super.viewDidLoad()
        fromButtonView.isHidden = true
        let params = [ "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        MakeHttpPostRequest(url: sendOtpApiURL, params: params, completion: {(success, response) -> Void in
            print(response)
        })
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
    
    @IBAction func termsHandledAction(_ sender: Any) {
    }
    @IBAction func currentIndustryButtonAction(_ sender: Any) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfValues.count
    }
    
    @IBAction func myFunctionalExpButtonAction(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellwork") as! WorkExpTableViewCell
        let titlename = arrayOfValues[indexPath .row]
        cell.value.text = titlename
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.fromButtonView.isHidden = true
    }
}
