//
//  NewWorkExperienceVC.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import DropDown

class NewWorkExperienceVC: UIViewController {
    
//    var companyName = "", fromYear = "", toYear = "", functionalDepartment = "", industrySector = "", managementLevel = "", teamSize = ""
    
    
    @IBOutlet weak var letUsKnowLabel1: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var tolabel: UILabel!
    @IBOutlet weak var managementLabel: UILabel!
    
    @IBOutlet weak var functionalLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var teamsHandledLabel: UILabel!
    @IBOutlet weak var funcExpButton: UIButton!
    @IBOutlet weak var currentIndustryButton: UIButton!
    @IBOutlet weak var teamsHandeledButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var managementLevelButton: UIButton!
    @IBOutlet weak var textFieldCompany: UITextField!
    var activityUIView: ActivityIndicatorUIView!
    var currentSelectedButton: String!
    
    @IBOutlet weak var saveButton: imagetoButton!
    var tableViewData =  [String]()
    var teamsHandled = [FieldsOfWork]()
    var levelOfManagement = [FieldsOfWork]()
    var functionalDepartmentList = [FieldsOfWork]()
    var industrySectorList = [FieldsOfWork]()
    var fromToYears: [String] = []
    var selectedWorkExperience = WorkFields()
    var dropDown: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        self.letUsKnowLabel1.text = "हमें अपने काम के अनुभव के बारे में बताएं!".localizableString(loc: language!)
        self.companyLabel.text = "कंपनी का नाम".localizableString(loc: language!)
        self.textFieldCompany.text = "कंपनी का नाम डालें".localizableString(loc: language!)
        
        
        

        
        
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        textFieldCompany.setBottomBorder()
        dropDown = DropDown()
        dropDown.direction = .any
        dropDown.dismissMode = .automatic
        dropDown.hide()
        for i in 1950 ..< 2019
        {
            self.fromToYears.append(String(i))
        
        }
        print(fromToYears)
        
        if selectedWorkExperience != nil && selectedWorkExperience.id != "" {
            print("this is edit")
            initView()
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            switch self.currentSelectedButton {
            case "From":
                self.selectedWorkExperience.fromYear = item
                self.fromButton.setTitle(item, for: .normal)
            case "To":
                self.selectedWorkExperience.toYear = item
                self.toButton.setTitle(item, for: .normal)
            case "ManagementLevel":
                self.selectedWorkExperience.levelOfManagement = item
                self.managementLevelButton.setTitle(item, for: .normal)
            case "TeamsHandled":
                self.selectedWorkExperience.teamSize = item
                self.teamsHandeledButton.setTitle(item, for: .normal)
            case "CurrentIndustry":
                self.selectedWorkExperience.industrySector = item
                self.currentIndustryButton.setTitle(item, for: .normal)
            case "FunctionalDepartment":
                self.selectedWorkExperience.functionalDepartment = item
                self.funcExpButton.setTitle(item, for: .normal)
            default:
                print("whoops")
            }
        }
        
        
        let params = [ "access_token":"\(accessToken)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        
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
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                    self.present(alert, animated: true, completion: nil)
                
            }
        })
    }
    
    override var shouldAutorotate: Bool{
        return false
    }

    func initView() {
        self.fromButton.setTitle(selectedWorkExperience.fromYear, for: .normal)
        self.toButton.setTitle(selectedWorkExperience.toYear, for: .normal)
        self.managementLevelButton.setTitle(selectedWorkExperience.levelOfManagement, for: .normal)
        self.teamsHandeledButton.setTitle(selectedWorkExperience.teamSize, for: .normal)
        self.currentIndustryButton.setTitle(selectedWorkExperience.industrySector, for: .normal)
        self.funcExpButton.setTitle(selectedWorkExperience.functionalDepartment, for: .normal)
        self.textFieldCompany.text = selectedWorkExperience.companyName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fromButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        currentSelectedButton = "From"
        dropDown.show()
        dropDown.anchorView = fromButton
        dropDown.dataSource = fromToYears
    }
    
    @IBAction func toButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        currentSelectedButton = "To"
        dropDown.show()
        dropDown.anchorView = toButton
        dropDown.dataSource = fromToYears
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ManagementLevelButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        var tableViewData =  [String]()
        for teamHandledSize in  self.levelOfManagement {
            tableViewData.append((teamHandledSize.name))
        }
        dropDown.show()
        dropDown.anchorView = managementLevelButton
        dropDown.dataSource = tableViewData
        currentSelectedButton = "ManagementLevel"
    }
    
    @IBAction func teamsHandledAction(_ sender: Any) {
        self.view.endEditing(true)
        var tableViewData =  [String]()
        for teamHandledSize in  self.teamsHandled {
            tableViewData.append((teamHandledSize.name))
        }
        dropDown.show()
        dropDown.anchorView = teamsHandeledButton
        dropDown.dataSource = tableViewData
        currentSelectedButton = "TeamsHandled"
    }
    
    @IBAction func currentIndustryButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        var tableViewData =  [String]()
        
        for teamHandledSize in  self.industrySectorList {
            tableViewData.append(String(teamHandledSize.name))
        }
        dropDown.show()
        dropDown.anchorView = currentIndustryButton
        dropDown.dataSource = tableViewData
        currentSelectedButton = "CurrentIndustry"
    }
    
    @IBAction func myFunctionalExpButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        tableViewData =  [String]()
        for teamHandledSize in  self.functionalDepartmentList {
            tableViewData.append(String(teamHandledSize.name))
        }
        dropDown.show()
        dropDown.anchorView = funcExpButton
        dropDown.dataSource = tableViewData
        currentSelectedButton = "FunctionalDepartment"
    }
    
    @IBAction func addWorkExperience(_ sender: Any) {
        saveButton.isEnabled = false
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        
        let companyName = textFieldCompany.text!
        
        
        if companyName == "" || self.toButton.titleLabel?.text == "Select Year" || self.fromButton.titleLabel?.text == "Select From" || self.managementLevelButton.titleLabel?.text == "Select Management Level" || self.teamsHandeledButton.titleLabel?.text == "Select Tearms Handled" || self.currentIndustryButton.titleLabel?.text == "Select Current Industry" || self.funcExpButton.titleLabel?.text == "Select Functional Experitise"{
//            || self.selectedWorkExperience.industrySector == "" || companyName == "" || self.selectedWorkExperience.fromYear == "" ||  self.selectedWorkExperience.functionalDepartment == "" || self.selectedWorkExperience.levelOfManagement == "" || self.selectedWorkExperience.teamSize == "" ||  self.selectedWorkExperience.id == "" ) {
        
            let alertcontrol = UIAlertController(title: "Alert", message: "Please check all fields are filled.", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default) { (action) in
                print("default")
              
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                
                self.saveButton.isEnabled = true
            }
            alertcontrol.addAction(alertaction)
            self.present(alertcontrol, animated: true, completion: nil)
            
        }
        else{
        let params = ["access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)", "companyName": "\(companyName)", "fromYear": "\(self.selectedWorkExperience.fromYear)", "toYear": "\(self.selectedWorkExperience.toYear)", "functionalDepartment" : "\(self.selectedWorkExperience.functionalDepartment)", "industrySector": "\(self.selectedWorkExperience.industrySector)", "levelOfManagemet" : "\(self.selectedWorkExperience.levelOfManagement)", "teamSize" : "\(self.selectedWorkExperience.teamSize)", "id": "\(self.selectedWorkExperience.id)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: saveWorkExperience, params: params, completion: {(success, response) -> Void in
            print(response, "SAVE WORK RESPONSE")
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                self.saveButton.isEnabled = true
                let vcGetStarted = self.storyboard?.instantiateViewController(withIdentifier: "work") as! WorkExpClickedViewController
                
                self.present(vcGetStarted, animated: true, completion: nil)
            }

//            DispatchQueue.main.async {
//                
//            }
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()

            }
        })
    }
    }
}
