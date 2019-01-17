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
    
    
    @IBOutlet var insertView: UIView!
    

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
    
    let datePicker = UIDatePicker()


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
        
        self.createDatePicker()
        
       /* let ownNominationAllowed = UserDefaults.standard.bool(forKey: "ownNominationAllowed") ?? false
        
        if ownNominationAllowed == false {
            
            self.insertView.isHidden = true
            self.NominateButton.isHidden = true
            self.OrLabel.isHidden = true
            
        }else{
            
            self.insertView.isHidden = false
            self.NominateButton.isHidden = false
            self.OrLabel.isHidden = false
        } */
        
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    func createDatePicker(){
        //for format of date
        
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
        var dateComponent = DateComponents()
        dateComponent.year = -100
        
        let maxdate  =  Calendar.current.date(byAdding: dateComponent, to: Date())
        
        datePicker.minimumDate = maxdate
        
        ageText.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //add done button
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(toolBarAction) )
        toolbar.setItems([donebutton], animated: true)
        ageText.inputAccessoryView = toolbar
        
    }
    
    @objc func toolBarAction(){
        //formate the date in text
        print("123")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        ageText.text = dateFormatter.string(from: datePicker.date)
        print("\(String(describing: ageText.text))")
        self.view.endEditing(true)
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
    
    
    @IBAction func backButton(_ sender: Any) {
    
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: startVC)
        aObjNavi.navigationBar.barTintColor = UIColor.blue
        self.present(aObjNavi, animated: true, completion: nil)
    }
    
    @IBAction func nominateButtonAction(_ sender: Any) {
        
        NominateUser()
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "nomineeView") as? NomineeDetailsViewController
//        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func SelectPollButtonAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ngoNominee") as? NominationOfNGOViewController
        
        self.present(vc!, animated: true, completion: nil)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showALert(){
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        let alertcontrol = UIAlertController(title: "AlertKey".localizableString(loc: language!), message: "alertFieldsFilled".localizableString(loc: language!), preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "OkKey".localizableString(loc: language!), style: .default) { (action) in
        }
        alertcontrol.addAction(alertaction)
        self.present(alertcontrol, animated: true, completion: nil)
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
        
        if firstname.count == 0
        {
            self.showALert()
        }
        
        if lastName.count == 0
        {
            self.showALert()
        }
        
        if age.count == 0
        {
            self.showALert()
        }
        
        if mobileno.count == 0
        {
            self.showALert()
        }
        
        if govtId.count == 0
        {
            self.showALert()
        }
        
        if self.ngoDataFetch.occupation.count == 0{
            
            self.showALert()

        }
        
        if self.ngoDataFetch.langLearning.count == 0{
            
            self.showALert()
            
        }
        
        
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)", "firstName": "\(firstname)", "lastName": "\(lastName)", "birthDate": "\(age)", "govId" : "\(govtId)", "occupation": "\(self.ngoDataFetch.occupation)", "learningLanguage" : "\(self.ngoDataFetch.langLearning)", "mobileNumber" : "\(mobileno)", "ngoId": "0","nominationUserId":"0"] as Dictionary<String, String>
        
        print(params)
        
            activityUIView.isHidden = false
            activityUIView.startAnimation()
            MakeHttpPostRequest(url: nominateUser, params: params, completion: {(success, response) -> Void in
                print(response)
                DispatchQueue.main.async {
                    
                    self.NominateButton.isEnabled = true
                    
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                    
                    let language = UserDefaults.standard.string(forKey: "currentlanguage")
                    let alertView = UIAlertController(title: "AlertKey".localizableString(loc: language!), message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName), \("nominatethankKey".localizableString(loc: language!))", preferredStyle: .alert)
                    
                    
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        
                        let dashboardvc = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                        DispatchQueue.main.async {
                            let aObjNavi = UINavigationController(rootViewController: dashboardvc)
                            aObjNavi.navigationBar.barTintColor = UIColor.blue
                            self.present(aObjNavi, animated: true, completion: nil)
                        }
                        
                    })
                    
                    
                    alertView.addAction(action)
                    self.present(alertView, animated: true, completion: nil)
                    
                    
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
