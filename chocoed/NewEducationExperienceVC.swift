//
//  NewEducationExperienceVC.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import DropDown
class NewEducationExperienceVC: UIViewController {
    @IBOutlet weak var buttonQualification: UIButton!
    @IBOutlet weak var buttonYearofpassing: UIButton!
    @IBOutlet weak var eduMediumButton: UIButton!
    @IBOutlet weak var buttonSpecification: UIButton!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var textfieldClgName: UITextField!
    @IBOutlet weak var textfieldBoardUniv: UITextField!
    
    @IBOutlet weak var labelPassing: UILabel!
    @IBOutlet weak var labelSpecialization: UILabel!
    @IBOutlet weak var labelEducation: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelBoard: UILabel!
    @IBOutlet weak var labelCollegeNAme: UILabel!
    @IBOutlet weak var labelQualification: UILabel!
    var currentSelectedButton: String!
    
    var dropDown: DropDown!
//    var educationLevel = "", location = "", mediumOfEducation = "", specialisation = "", state = "", yearOfCompletion = "",boardUniversity="",nameOfInstitute=""
    var tableViewData =  [String]()
    var educationLevel1 = [FieldsOfEducation]()
    var specializationList = [FieldsOfEducation]()
    var stateList = [FieldsOfEducation]()
    var mediumOfEduList = [FieldsOfEducation]()
    var PassingYears: [String] = [("1990"), ("1991"), ("1992")]
    
    var selectedEducation = EducationFields()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDropdownList()
        dropDown = DropDown()
        dropDown.direction = .any
        dropDown.dismissMode = .automatic
        dropDown.hide()
        
        if selectedEducation != nil && selectedEducation.id != "" {
            initView()
        }
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            switch self.currentSelectedButton {
            case "Qualification":
                self.selectedEducation.educationLevel = self.educationLevel1[index].name
                print(self.selectedEducation.educationLevel)
                if self.selectedEducation.educationLevel == "10th Standard Board" || self.selectedEducation.educationLevel == "12th Standard Board / Diploma"
                {
                    self.buttonSpecification.isHidden = true
                    self.labelSpecialization.isHidden = true
                }
                else
                {
                    self.buttonSpecification.isHidden = false
                    self.labelSpecialization.isHidden = false
                }
                
                self.buttonQualification.setTitle(self.educationLevel1[index].name, for: .normal)
            case "EducationMedium":
                self.selectedEducation.mediumOfEducation = self.mediumOfEduList[index].name
                self.eduMediumButton.setTitle(self.mediumOfEduList[index].name, for: .normal)
            case "Specialization":
                self.selectedEducation.specialisation = self.specializationList[index].name
                self.buttonSpecification.setTitle(self.specializationList[index].name, for: .normal)
            case "YearofPassing":
                self.selectedEducation.yearOfCompletion = self.PassingYears[index]
                self.buttonYearofpassing.setTitle(self.PassingYears[index], for: .normal)
            default:
                print("whoops")
            }
        }
    }
    
    func initView() {
        self.buttonQualification.setTitle(selectedEducation.educationLevel, for: .normal)
        self.eduMediumButton.setTitle(selectedEducation.mediumOfEducation, for: .normal)
        self.buttonSpecification.setTitle(selectedEducation.specialisation, for: .normal)
        self.buttonYearofpassing.setTitle(selectedEducation.yearOfCompletion, for: .normal)
        self.locationTextField.text = selectedEducation.location
        self.textfieldClgName.text = selectedEducation.nameOfInstitute
        self.textfieldBoardUniv.text = selectedEducation.boardUniversity
    }
    
    
    func getDropdownList(){
        let params = ["access_token":"\(accessToken)"] as Dictionary<String, String>
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
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableViewData.count
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "celledu") as! EducationExpTableViewCell
//        let titlename = tableViewData[indexPath .row]
//        cell.valueEdu.text = titlename.title
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.viewTableEdu.isHidden = true
//
//        switch currentSelectedButton {
//        case "Qualification":
//            educationLevel = self.educationLevel1[indexPath.row].name
//                buttonQualification.setTitle(self.educationLevel1[indexPath.row].name, for: .normal)
//        case "EducationMedium":
//            mediumOfEducation = self.mediumOfEduList[indexPath.row].name
//            eduMediumButton.setTitle(self.mediumOfEduList[indexPath.row].name, for: .normal)
//        case "Specialization":
//             specialisation = self.specializationList[indexPath.row].name
//            buttonSpecification.setTitle(self.specializationList[indexPath.row].name, for: .normal)
//        case "YearofPassing":
//            yearOfCompletion = self.PassingYears[indexPath.row].title
//            buttonYearofpassing.setTitle(self.PassingYears[indexPath.row].title, for: .normal)
//        default:
//            print("whoops")
//        }
//        self.viewTableEdu.isHidden = true
//
//     }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func qualificationButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        tableViewData =  [String]()
       
        for qualify in self.educationLevel1{
            tableViewData.append((qualify.name))
        }
        currentSelectedButton = "Qualification"
        dropDown.show()
        dropDown.anchorView = buttonQualification
        dropDown.dataSource = tableViewData
       
     }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func EduMediumButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        tableViewData =  [String]()
        for medium in  self.mediumOfEduList {
            tableViewData.append((medium.name))
        }
        currentSelectedButton = "EducationMedium"
        dropDown.show()
        dropDown.anchorView = eduMediumButton
        dropDown.dataSource = tableViewData
    }

    @IBAction func spectificationButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        tableViewData =  [String]()
        for specifications in  self.specializationList {
            tableViewData.append((specifications.name))
        }
        currentSelectedButton = "Specialization"
        dropDown.show()
        dropDown.anchorView = buttonSpecification
        dropDown.dataSource = tableViewData
    }
    @IBAction func YearOfPassingButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        currentSelectedButton = "YearofPassing"
        dropDown.show()
        dropDown.anchorView = buttonSpecification
        dropDown.dataSource = PassingYears
    }
    @IBAction func buttonSave(_ sender: Any) {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let nameOfInstitute = textfieldClgName.text!
        let nameofBoardUniv = textfieldBoardUniv.text!
        let location = locationTextField.text!
        
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)", "educationLevel": "\(self.selectedEducation.educationLevel)", "boardUniversity": "\(nameofBoardUniv)", "location": "\(location)", "mediumOfEducation" : "\(self.selectedEducation.mediumOfEducation)", "nameOfInstitute": "\(nameOfInstitute)", "specialisation" : "\(self.selectedEducation.specialisation)", "state" : "\(self.selectedEducation.state)", "id": "\(self.selectedEducation.id )","yearOfCompletion":"\(self.selectedEducation.yearOfCompletion)"] as Dictionary<String, String>

        MakeHttpPostRequest(url: saveEducationExp, params: params, completion: {(success, response) -> Void in
            DispatchQueue.main.async {
                let vcGetStarted = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
                
                self.present(vcGetStarted, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func cancelButtonAction(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
