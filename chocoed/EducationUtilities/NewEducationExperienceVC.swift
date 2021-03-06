
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
    
    
    @IBOutlet weak var letUsKnowLabel: UILabel!
    @IBOutlet weak var buttonQualification: UIButton!
    @IBOutlet weak var buttonYearofpassing: UIButton!
    @IBOutlet weak var eduMediumButton: UIButton!
    @IBOutlet weak var buttonSpecification: UIButton!
    
    @IBOutlet weak var outletofConstraints: NSLayoutConstraint!
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
    
    @IBOutlet weak var yearOfPassingLabel: UILabel!
    var currentSelectedButton: String!
    
    @IBOutlet weak var savebutton: imagetoButton!
    var activityUIView: ActivityIndicatorUIView!
    var dropDown: DropDown!
//    var educationLevel = "", location = "", mediumOfEducation = "", specialisation = "", state = "", yearOfCompletion = "",boardUniversity="",nameOfInstitute=""
    var tableViewData =  [String]()
    var educationLevel1 = [FieldsOfEducation]()
    var specializationList = [FieldsOfEducation]()
    var stateList = [FieldsOfEducation]()
    var mediumOfEduList = [FieldsOfEducation]()
    var PassingYears: [String] = []
    var selectedEducation = EducationFields()
    
    var originalSpecilization = [FieldsOfEducation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        self.letUsKnowLabel.text = "EducationTopMsgKey".localizableString(loc: language!)
        self.labelQualification.text = "QulificationKey".localizableString(loc: language!)
        self.labelCollegeNAme.text = "NameofCollegeKey".localizableString(loc: language!)
        self.labelBoard.text = "NameofBoardUniversityKey".localizableString(loc: language!)
        self.labelLocation.text = "LocationKey".localizableString(loc: language!)
        self.labelEducation.text = "EduactionMediumKey".localizableString(loc: language!)
        self.labelSpecialization.text = "SpecializationKey".localizableString(loc: language!)
        self.yearOfPassingLabel.text = "YearofPassKey".localizableString(loc: language!)
        self.savebutton.setTitle("saveButtonKey".localizableString(loc: language!), for: .normal)
        self.textfieldClgName.placeholder = "EnterNameClgKey".localizableString(loc: language!)
        self.textfieldBoardUniv.placeholder = "EnterBoardKey".localizableString(loc: language!)
        self.locationTextField.placeholder = "EnterLocationKey".localizableString(loc: language!)
        self.buttonQualification.setTitle("SelectQualificationButtonKey".localizableString(loc: language!), for: .normal)
      //  self.textfieldClgName.text = "EnterNameClgKey".localizableString(loc: language!)
        //self.textfieldBoardUniv.text = "EnterBoardKey".localizableString(loc: language!)
        //self.locationTextField.text = "EnterLocationKey".localizableString(loc: language!)
        self.eduMediumButton.setTitle("SelectEduMediumKey".localizableString(loc: language!), for: .normal)
        self.buttonSpecification.setTitle("SelectSpecialixationKey".localizableString(loc: language!), for: .normal)
        self.buttonYearofpassing.setTitle("SelectYearPassingButtonKey".localizableString(loc: language!), for: .normal)
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        getDropdownList()
        dropDown = DropDown()
        dropDown.direction = .any
        dropDown.dismissMode = .automatic
        dropDown.hide()
        dropDown.layer.cornerRadius = 8
        dropDown.clipsToBounds =  true
        dropDown.layer.borderWidth = 5
        dropDown.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        locationTextField.setBottomBorder()
        textfieldClgName.setBottomBorder()
        textfieldBoardUniv.setBottomBorder()
       
        for i in 1950 ..< 2019
        {
            self.PassingYears.append(String(i))
        }
        
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
                    
                        self.view.layoutIfNeeded()
                        UIView.animate(withDuration: 1, animations: {
                    self.outletofConstraints.constant = -50
                        self.view.layoutIfNeeded()
                    })
                   // self.labelPassing.topAnchor.constraint(equalTo: self.eduMediumButton.bottomAnchor , constant: 30 )
                    
                }
                else if self.selectedEducation.educationLevel == "Graduation / Degree"
                {
                    self.buttonSpecification.isHidden = false
                    self.labelSpecialization.isHidden = false
                   
                        self.view.layoutIfNeeded()
                        UIView.animate(withDuration: 1, animations: {
                    self.outletofConstraints.constant = 40
                        self.view.layoutIfNeeded()
                    })
                    
                    
                    
                    if self.specializationList.count > 0 {
                        self.specializationList.removeAll()
                    }
                    
                    for spec in self.originalSpecilization {
                        
                        if spec.type == "1" {
                            self.specializationList.append(spec)
                        }
                        
                    }
                    
                    
                   // self.labelSpecialization.topAnchor.constraint(equalTo: self.eduMediumButton.bottomAnchor , constant: 30 )
                    
                }else if self.selectedEducation.educationLevel == "Post Graduation"
                {
                    self.buttonSpecification.isHidden = false
                    self.labelSpecialization.isHidden = false
                    
                    self.view.layoutIfNeeded()
                    UIView.animate(withDuration: 1, animations: {
                        self.outletofConstraints.constant = 40
                        self.view.layoutIfNeeded()
                    })
                    
                    
                    if self.specializationList.count > 0 {
                        self.specializationList.removeAll()
                    }
                    
                    for spec in self.originalSpecilization {
                        
                        if spec.type == "2" {
                            
                            self.specializationList.append(spec)

                        }
                        
                    }
                    
                    // self.labelSpecialization.topAnchor.constraint(equalTo: self.eduMediumButton.bottomAnchor , constant: 30 )
                }else
                {
                    self.buttonSpecification.isHidden = false
                    self.labelSpecialization.isHidden = false
                    
                    self.view.layoutIfNeeded()
                    UIView.animate(withDuration: 1, animations: {
                        self.outletofConstraints.constant = 40
                        self.view.layoutIfNeeded()
                    })
                    // self.labelSpecialization.topAnchor.constraint(equalTo: self.eduMediumButton.bottomAnchor , constant: 30 )
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
    
    override var shouldAutorotate: Bool{
        return false
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
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: userDropDown , params: params, completion: {(success, response) -> Void in
        print(response)
            let educationLevelList = response.object(forKey: "educationLevelList") as? NSArray ?? []
            let specialisationList = response.object(forKey: "specializationList") as? NSArray ?? []
            let mediumOfEducationList = response.object(forKey: "languageList") as? NSArray ?? []
            let statelist = response.object(forKey: "statelist") as? NSArray ?? []
            
            for education in educationLevelList {
                self.educationLevel1.append(FieldsOfEducation( education as! NSDictionary))
            }
            
            for specialisation in specialisationList {
                self.specializationList.append(FieldsOfEducation(specialisation as! NSDictionary))
            }
            
            self.originalSpecilization = self.specializationList
            
            for statelist in statelist {
                self.stateList.append(FieldsOfEducation(statelist as! NSDictionary))
            }
            
            for mediumEdu in mediumOfEducationList {
                self.mediumOfEduList.append(FieldsOfEducation(mediumEdu as! NSDictionary))
            }
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
        
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()

            }
        })
    }
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
        savebutton.isEnabled = false
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let nameOfInstitute = textfieldClgName.text!
        let nameofBoardUniv = textfieldBoardUniv.text!
        let location = locationTextField.text!
        
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)", "educationLevel": "\(self.selectedEducation.educationLevel)", "boardUniversity": "\(nameofBoardUniv)", "location": "\(location)", "mediumOfEducation" : "\(self.selectedEducation.mediumOfEducation)", "nameOfInstitute": "\(nameOfInstitute)", "specialisation" : "\(self.selectedEducation.specialisation)", "state" : "\(self.selectedEducation.state)", "id": "\(self.selectedEducation.id )","yearOfCompletion":"\(self.selectedEducation.yearOfCompletion)"] as Dictionary<String, String>
        
        print(params)
        
        if self.selectedEducation.educationLevel == "" || nameofBoardUniv == "" || location == "" || self.selectedEducation.mediumOfEducation == "" || nameOfInstitute == ""  || self.selectedEducation.yearOfCompletion == "" {
            
            
            let language = UserDefaults.standard.string(forKey: "currentlanguage")
            

            
            let alertcontrol = UIAlertController(title: "AlertKey".localizableString(loc: language!), message: "alertFieldsFilled".localizableString(loc: language!), preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OkKey".localizableString(loc: language!), style: .default) { (action) in
                print("default")
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                
                self.savebutton.isEnabled = true
            }
            alertcontrol.addAction(alertaction)
            self.present(alertcontrol, animated: true, completion: nil)
            
        }else{
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)", "educationLevel": "\(self.selectedEducation.educationLevel)", "boardUniversity": "\(nameofBoardUniv)", "location": "\(location)", "mediumOfEducation" : "\(self.selectedEducation.mediumOfEducation)", "nameOfInstitute": "\(nameOfInstitute)", "specialisation" : "\(self.selectedEducation.specialisation)", "state" : "\(self.selectedEducation.state)", "id": "\(self.selectedEducation.id )","yearOfCompletion":"\(self.selectedEducation.yearOfCompletion)"] as Dictionary<String, String>
            activityUIView.isHidden = false
            activityUIView.startAnimation()
            MakeHttpPostRequest(url: saveEducationExp, params: params, completion: {(success, response) -> Void in
            DispatchQueue.main.async {

            self.savebutton.isEnabled = true
                
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                
                let vcGetStarted = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
                
                self.present(vcGetStarted, animated: true, completion: nil)
            }
            
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
    
    @IBAction func cancelButtonAction(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
