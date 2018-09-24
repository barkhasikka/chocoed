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
    var teamsHandled = [FieldsOfWork]()
    var levelOfManagement = [FieldsOfWork]()
    var functionalDepartmentList = [FieldsOfWork]()
    var industrySectorList = [FieldsOfWork]()
    var fromToYears: [NewWorkExperienceTableView] = [NewWorkExperienceTableView("1990"), NewWorkExperienceTableView("1991"), NewWorkExperienceTableView("1991")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromButtonView.isHidden = true
        let params = [ "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        MakeHttpPostRequest(url: userDropDown, params: params, completion: {(success, response) -> Void in
            let levelOfManagement = response.object(forKey: "levelOfManagemet") as? NSArray ?? []
            let teamsHandled = response.object(forKey: "teamsHandledList") as? NSArray ?? []
            let functionalDepartmentList = response.object(forKey: "functionalDepartmentList") as? NSArray ?? []
            let industrySectorList = response.object(forKey: "industrySectorList") as? NSArray ?? []
           
            for teamHandledSize in teamsHandled {
                self.teamsHandled.append(FieldsOfWork(teamHandledSize as! NSDictionary))
            }
            
            for teamHandledSize in levelOfManagement {
                self.levelOfManagement.append(FieldsOfWork(teamHandledSize as! NSDictionary))
            }
            
            for teamHandledSize in functionalDepartmentList {
                self.functionalDepartmentList.append(FieldsOfWork(teamHandledSize as! NSDictionary))
            }
            
            for teamHandledSize in industrySectorList {
                self.industrySectorList.append(FieldsOfWork(teamHandledSize as! NSDictionary))
            }
            
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
        tableViewData = fromToYears
        tableViewFromButton.reloadData()
    }
    
    @IBAction func toButtonAction(_ sender: Any) {
        fromButtonView.isHidden = false
        tableViewData = fromToYears
        tableViewFromButton.reloadData()
    }
    
    @IBAction func ManagementLevelButtonAction(_ sender: Any) {
        fromButtonView.isHidden = false
        tableViewData =  [NewWorkExperienceTableView]()
        for teamHandledSize in  self.levelOfManagement {
            tableViewData.append(NewWorkExperienceTableView(teamHandledSize.name))
        }
        tableViewFromButton.reloadData()
    }
    
    @IBAction func termsHandledAction(_ sender: Any) {
        fromButtonView.isHidden = false
        tableViewData =  [NewWorkExperienceTableView]()
        for teamHandledSize in  self.teamsHandled {
            tableViewData.append(NewWorkExperienceTableView(teamHandledSize.name))
        }
        tableViewFromButton.reloadData()
    }
    
    @IBAction func currentIndustryButtonAction(_ sender: Any) {
        fromButtonView.isHidden = false
        tableViewData =  [NewWorkExperienceTableView]()
        for teamHandledSize in  self.industrySectorList {
            tableViewData.append(NewWorkExperienceTableView(teamHandledSize.name))
        }
        tableViewFromButton.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
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
