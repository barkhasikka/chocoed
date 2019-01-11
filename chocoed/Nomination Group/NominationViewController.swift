//
//  NominationViewController.swift
//  chocoed
//
//  Created by Tejal on 03/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit
import DropDown

class NominationViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var mobNoLabel: UILabel!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var selectPollButton: imagetoButton!
    @IBOutlet weak var OrLabel: UILabel!
    @IBOutlet weak var NominateButton: imagetoButton!
    @IBOutlet weak var selectLangButton: UIButton!
    @IBOutlet weak var SelectOcupButton: UIButton!
    @IBOutlet weak var govtIdText: UITextField!
    @IBOutlet weak var govtIdLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var LastNameText: UITextField!
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastNameOutlet: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var labelHeaderOutlet: UILabel!
     var tableViewData =  [String]()
    var dropdownValuelang = [FieldsOfDropDownList]()
    var dropdownValueoccupation = [FieldsOfDropDownList]()
    var dropDown: DropDown!
    var ngoDataFetch = NGODropDown()
    var currentSelectedButton: String!
    var activityUIView: ActivityIndicatorUIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
         self.firstnameText.delegate = self;
        firstnameText.setBottomBorder()
        LastNameText.setBottomBorder()
        ageText.setBottomBorder()
        govtIdText.setBottomBorder()
        mobileNo.setBottomBorder()
        
        dropDown = DropDown()
        dropDown.direction = .any
        dropDown.dismissMode = .automatic
        dropDown.hide()
        hideKeyboardWhenTappedAround()
        
        if ngoDataFetch != nil && ngoDataFetch.ngoId != "" {
            print("this is edit")
            initView()
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            switch self.currentSelectedButton {
            case "Occupation":
                self.ngoDataFetch.occupation = item
                self.SelectOcupButton.setTitle(item, for: .normal)
            case "Learning Language":
                self.ngoDataFetch.langLearning = item
                self.selectLangButton.setTitle(item, for: .normal)

            default:
                print("whoops")
            }
        }
        
        
        let params = [ "access_token":"\(accessToken)"] as Dictionary<String, String>

        MakeHttpPostRequest(url: userDropDown, params: params, completion: {(success, response) -> Void in
            
            print(response)
            let occupationList = response.object(forKey: "occupationList") as? NSArray ?? []
            let languageList = response.object(forKey: "languageList") as? NSArray ?? []
            
            for occupationListItems in occupationList {
 self.dropdownValueoccupation.append(FieldsOfDropDownList(occupationListItems as! NSDictionary))
            }
            
            for languageListItems in languageList {
                self.dropdownValuelang.append(FieldsOfDropDownList(languageListItems as! NSDictionary))
            }
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
//                self.activityUIView.isHidden = true
//                self.activityUIView.stopAnimation()
                self.present(alert, animated: true, completion: nil)
                
            }
        })
        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    func initView() {
        self.selectLangButton.setTitle(ngoDataFetch.langLearning, for: .normal)
        self.SelectOcupButton.setTitle(ngoDataFetch.occupation, for: .normal)
            self.firstNameLabel.text = ngoDataFetch.firstName
    }
    @IBAction func SelectLanguage(_ sender: Any) {
        self.view.endEditing(true)
        tableViewData =  [String]()
        for language in self.dropdownValuelang{
            tableViewData.append((language.name))
        }
        currentSelectedButton = "Learning Language"
        dropDown.show()
        dropDown.anchorView = selectLangButton
        dropDown.dataSource = tableViewData

    }
    
    @IBAction func SelectOccupation(_ sender: Any) {
        self.view.endEditing(true)
        tableViewData =  [String]()
        for occupation in self.dropdownValueoccupation{
            tableViewData.append((occupation.name))
        }
        currentSelectedButton = "Occupation"
        dropDown.show()
        dropDown.anchorView = SelectOcupButton
        dropDown.dataSource = tableViewData

    }
    @IBAction func nominateButtonAction(_ sender: Any) {
        
        NominateUser()
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "nomineeView") as? NomineeDetailsViewController
//        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func SelectPollButtonAction(_ sender: Any) {
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func NominateUser(){
        self.NominateButton.isEnabled = false
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let firstname = firstnameText.text!
        let lastName = LastNameText.text!
        let age = ageText.text!
        let mobileno = mobileNo.text!
        let govtId = govtIdText.text!
        
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)", "firstName": "\(firstname)", "lastName": "\(lastName)", "age": "\(age)", "govId" : "\(govtId)", "occupation": "\(self.ngoDataFetch.occupation)", "learningLanguage" : "\(self.ngoDataFetch.langLearning)", "mobileNumber" : "\(mobileno)", "ngoId": "1","nominationUserId":"1"] as Dictionary<String, String>
        
        print(params)
        
            activityUIView.isHidden = false
            activityUIView.startAnimation()
            MakeHttpPostRequest(url: nominateUser, params: params, completion: {(success, response) -> Void in
                print(response)
                DispatchQueue.main.async {
                    
                    self.NominateButton.isEnabled = true
                    
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                    
                    let vcGetStarted = self.storyboard?.instantiateViewController(withIdentifier: "nomineeView") as! NomineeDetailsViewController
                    
                    self.present(vcGetStarted, animated: true, completion: nil)
                }
                
            }, errorHandler: {(message) -> Void in
                let alert = GetAlertWithOKAction(message: message)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                    
                    self.NominateButton.isEnabled = true

                }
            })
        }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {        
        if textField == mobileNo{
        let charsLimit = 10
        
        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        return newLength <= charsLimit
        }
        return true
    }


}
