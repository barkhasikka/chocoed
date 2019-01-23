//
//  SponsershipViewController.swift
//  chocoed
//
//  Created by Tejal on 18/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit
import DropDown

protocol AddContactProtocol1 {
    func setUserData()
}


class SponsershipViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet var txtFirstName: UITextField!
    
    @IBOutlet var txtLastName: UITextField!
    
    
    @IBOutlet var txtMobileNumber: UITextField!
    
    @IBOutlet var txtBirthdate: UITextField!
    
    @IBOutlet var btnOccupation: UIButton!
    
    @IBOutlet var txtGovtID: UITextField!
    
    
    @IBOutlet var btnLang: UIButton!
    
    
    @IBAction func btnOccupationClikced(_ sender: Any) {
        
        self.view.endEditing(true)
        tableViewData =  [String]()
        for occupation in self.dropdownValueoccupation{
            tableViewData.append((occupation.name))
        }
        currentSelectedButton = "Occupation"
        dropDown.show()
        dropDown.anchorView = btnOccupation
        dropDown.dataSource = tableViewData
    }
    
    @IBAction func btnLangClicked(_ sender: Any) {
        
        self.view.endEditing(true)
        tableViewData =  [String]()
        for language in self.dropdownValuelang{
            tableViewData.append((language.name))
        }
        currentSelectedButton = "Learning Language"
        dropDown.show()
        dropDown.anchorView = btnLang
        dropDown.dataSource = tableViewData
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    var delegate:AddContactProtocol?
    
    var tableViewData =  [String]()
    var dropdownValuelang = [FieldsOfDropDownList]()
    var dropdownValueoccupation = [FieldsOfDropDownList]()
    var dropDown: DropDown!
    var ngoDataFetch = NGODropDown()
    var currentSelectedButton: String!
    let datePicker = UIDatePicker()


    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        txtFirstName.delegate = self;
        txtFirstName.setBottomBorder()
        txtLastName.setBottomBorder()
        txtBirthdate.setBottomBorder()
        txtGovtID.setBottomBorder()
        txtMobileNumber.setBottomBorder()
        
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
                self.btnOccupation.setTitle(item, for: .normal)
            case "Learning Language":
                self.ngoDataFetch.langLearning = item
                self.btnLang.setTitle(item, for: .normal)
                
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
        
        txtBirthdate.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //add done button
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(toolBarAction) )
        toolbar.setItems([donebutton], animated: true)
        txtBirthdate.inputAccessoryView = toolbar
        
    }
    
    @objc func toolBarAction(){
        //formate the date in text
        print("123")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txtBirthdate.text = dateFormatter.string(from: datePicker.date)
        print("\(String(describing: txtBirthdate.text))")
        self.view.endEditing(true)
    }
    
    func initView() {
        self.btnLang.setTitle(ngoDataFetch.langLearning, for: .normal)
        self.btnOccupation.setTitle(ngoDataFetch.occupation, for: .normal)
        self.txtFirstName.text = ngoDataFetch.firstName
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMobileNumber{
            let charsLimit = 10
            
            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            return newLength <= charsLimit
        }
        return true
    }

    
    
    
    @IBAction func addBtn_clicked(_ sender: Any) {
        
        let firstname = txtFirstName.text!
        let lastName = txtLastName.text!
        let age = txtBirthdate.text!
        let mobileno = txtMobileNumber.text!
        let govtId = txtGovtID.text!
        
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
    
        
        UserList = NgoUserDetails(birthDate:age,ngoId:"0",firstName:firstname,lastName:lastName,mobileNumber:mobileno,govtId:govtId,userID:"0",age:age,occupation:self.ngoDataFetch.occupation,learningLanguage:self.ngoDataFetch.langLearning,profileImageUrl:"")
        
        GlobalUsersList.append(UserList)

        delegate?.setUserData()
        dismiss(animated: true, completion: nil)
        
        
    }
    

  
}
