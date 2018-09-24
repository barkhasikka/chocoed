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
    var tableViewData =  [NewWorkExperienceTableView]()
    var teamsHandled: NSArray = []
    var levelOfManagement: NSArray = []
    var functionalDepartmentList: NSArray = []
    var industrySectorList: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params = [ "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        MakeHttpPostRequest(url: userDropDown, params: params, completion: {(success, response) -> Void in
            self.levelOfManagement = response.object(forKey: "levelOfManagemet") as? NSArray ?? []
            self.teamsHandled = response.object(forKey: "teamsHandledList") as? NSArray ?? []
            self.functionalDepartmentList = response.object(forKey: "functionalDepartmentList") as? NSArray ?? []
            self.industrySectorList = response.object(forKey: "industrySectorList") as? NSArray ?? []
//            for teamHandledSize in teamsHandledResponse {
//                self.teamsHandled.append(TeamsHandledAndLevelOfManagement(teamHandledSize as! NSDictionary))
//            }
            
//            print(response.object(forKey: "industrySectorList"), "industry sector list")
//            response.object(forKey: "functionalDepartmentList")
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
        return teamsHandled.count
    }
    
    @IBAction func myFunctionalExpButtonAction(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellwork") as! WorkExpTableViewCell
        let titlename = tableViewData[indexPath .row]
        cell.value.text = titlename.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.fromButtonView.isHidden = true
    }
}
