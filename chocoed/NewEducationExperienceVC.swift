//
//  NewEducationExperienceVC.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class NewEducationExperienceVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var eduTableView: UITableView!
    @IBOutlet weak var viewTableEdu: UIView!
    @IBOutlet weak var buttonQualification: UIButton!
    
    @IBOutlet weak var buttonLocation: UIButton!
    
    @IBOutlet weak var buttonYearofpassing: UIButton!
    
    @IBOutlet weak var eduMediumButton: UIButton!
    @IBOutlet weak var textfieldClgName: UITextField!
    @IBOutlet weak var textfieldBoardUniv: UITextField!
    @IBOutlet weak var buttonSpecification: UIButton!
    var currentSelectedButton: String!
    
    var educationLevel, location, mediumOfEducation, specialisation, state, yearOfCompletion,boardUniversity,nameOfInstitute : String!
    var tableViewData =  [NewWorkExperienceTableView]()
    var educationLevel1 = [FieldsOfEducation]()
    var specializationList = [FieldsOfEducation]()
    var stateList = [FieldsOfEducation]()
    var mediumOfEduList = [FieldsOfEducation]()
    var PassingYears: [NewWorkExperienceTableView] = [NewWorkExperienceTableView("1990"), NewWorkExperienceTableView("1991"), NewWorkExperienceTableView("1991")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTableEdu.isHidden = true
        getDropdownList()
        
    }
    
    
    func getDropdownList(){
        let params = ["access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        MakeHttpPostRequest(url: userDropDown , params: params, completion: {(success, response) -> Void in
        print(response)
            let educationLevelList = response.object(forKey: "educationLevelList") as? NSArray ?? []
            let specialisationList = response.object(forKey: "specializationList") as? NSArray ?? []
            let mediumOfEducationList = response.object(forKey: "mediumOfEducationList") as? NSArray ?? []
            let statelist = response.object(forKey: "statelist") as? NSArray ?? []
            
            for education in educationLevelList {
                self.educationLevel1.append(FieldsOfEducation( education as! NSDictionary))
            }
            
            for specialisation in specialisationList {
                self.specializationList.append(FieldsOfEducation(specialisation as! NSDictionary))
            }
            
            for statelist in statelist {
                self.stateList.append(FieldsOfEducation(statelist as! NSDictionary))
            }
            
            for mediumEdu in mediumOfEducationList {
                self.mediumOfEduList.append(FieldsOfEducation(mediumEdu as! NSDictionary))
            }
            })

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celledu") as! EducationExpTableViewCell
        let titlename = tableViewData[indexPath .row]
        cell.valueEdu.text = titlename.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewTableEdu.isHidden = true
        
        switch currentSelectedButton {
        case "Qualification":
            educationLevel = self.educationLevel1[indexPath.row].name
                buttonQualification.setTitle(self.educationLevel1[indexPath.row].name, for: .normal)
        case "EducationMedium":
            mediumOfEducation = self.mediumOfEduList[indexPath.row].name
            eduMediumButton.setTitle(self.mediumOfEduList[indexPath.row].name, for: .normal)
        case "Specialization":
             specialisation = self.specializationList[indexPath.row].name
            buttonSpecification.setTitle(self.specializationList[indexPath.row].name, for: .normal)
        case "YearofPassing":
            yearOfCompletion = self.PassingYears[indexPath.row].title
            buttonYearofpassing.setTitle(self.PassingYears[indexPath.row].title, for: .normal)
        default:
            print("whoops")
        }
        self.viewTableEdu.isHidden = true

     }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func qualificationButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        viewTableEdu.isHidden = false
        tableViewData =  [NewWorkExperienceTableView]()
        for qualify in  self.educationLevel1{
            tableViewData.append(NewWorkExperienceTableView(qualify.name))
        }
        self.eduTableView.reloadData()
        currentSelectedButton = "Qualification"
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        
         }
    @IBAction func EduMediumButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        viewTableEdu.isHidden = false
        tableViewData =  [NewWorkExperienceTableView]()
        for medium in  self.mediumOfEduList {
            tableViewData.append(NewWorkExperienceTableView(medium.name))
        }
        self.eduTableView.reloadData()
          currentSelectedButton = "EducationMedium"
    }

    @IBAction func spectificationButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        viewTableEdu.isHidden = false
        tableViewData =  [NewWorkExperienceTableView]()
        for specifications in  self.specializationList {
            tableViewData.append(NewWorkExperienceTableView(specifications.name))
        }
        self.eduTableView.reloadData()
          currentSelectedButton = "Specialization"
        
    }
    @IBAction func YearOfPassingButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        viewTableEdu.isHidden = false
        tableViewData = PassingYears
        self.eduTableView.reloadData()
        currentSelectedButton = "YearofPassing"
    }
    @IBAction func buttonSave(_ sender: Any) {
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let nameOfInstitute = "Tejal"
        let nameofBoardUniv = "Ohara"
        
        let params = [ "access_token":"03db0f67032a1e3a82f28b476a8b81ea", "userId": "\(59)","clientId":"\(16)", "educationLevel": "\(educationLevel!)", "boardUniversity": "\(nameofBoardUniv)", "location": "Pune", "mediumOfEducation" : "\(mediumOfEducation!)", "nameOfInstitute": "\(nameOfInstitute)", "specialisation" : "\(specialisation!)", "state" : "\(state!)", "id": "","yearOfCompletion":"\(yearOfCompletion!)"] as Dictionary<String, String>
        MakeHttpPostRequest(url: saveEducationExp, params: params, completion: {(success, response) -> Void in
            print(response, "SAVE WORK RESPONSE")
            let vcGetStarted = self.storyboard?.instantiateViewController(withIdentifier: "work") as! WorkExpClickedViewController
            
            self.present(vcGetStarted, animated: true, completion: nil)
        })
    }
}
