//
//  LoginViewController.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var topOutlet: NSLayoutConstraint!
    @IBOutlet weak var labelMobileNo: UILabel!
    @IBOutlet weak var otpReceivedLabel: UILabel!
    @IBOutlet weak var receivedOTPUIView: UIView!
    var temp = ModelClassLoginId()
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var sendOTPButton: UIButton!
    @IBOutlet weak var labelInstruct: UILabel!
    @IBOutlet weak var imageViewMessage: UIImageView!
    @IBOutlet weak var mobileNumberTextFIeld: UITextField!
    @IBOutlet weak var otpDigitFirstTF: UITextField!
    @IBOutlet weak var otpDigitSecondTF: UITextField!
    @IBOutlet weak var otpDigitThirdTF: UITextField!
    @IBOutlet weak var otpDigitSixthTF: UITextField!
    @IBOutlet weak var otpDigitFifthTF: UITextField!
    @IBOutlet weak var otpDigitFourthTF: UITextField!
    @IBOutlet weak var labelOTPReceived: UILabel!
    var activityUIView: ActivityIndicatorUIView!
    
    var button: UIButton!
    var otpFromServer = -1
    
    
    @IBOutlet var btnResend: UIButton!
    
    @IBAction func resend_clicked(_ sender: Any) {
        
        sendOTPAPI()
        self.btnResend.isHidden = true;
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnResend.isHidden = true;

        var language = UserDefaults.standard.string(forKey: "currentlanguage")
        

         if language == nil {
            UserDefaults.standard.set("en", forKey: "currentlanguage")
            language = "en"
        }
        
        self.labelMobileNo.text = "MobileNoKey".localizableString(loc: language!)

        
        self.labelInstruct.text = "RequestOfEnterMobileNoKey".localizableString(loc: language!)
        self.registerButton.setTitle("\("LoginButtonKey".localizableString(loc: language!))", for:.normal)
        self.otpReceivedLabel.text = "InputChocoedTokenKey".localizableString(loc: language!)

        self.btnResend.setTitle("\("ResendKey".localizableString(loc: language!))", for:.normal)
        
        
        registerButton.isEnabled = false
        self.mobileNumberTextFIeld.text = textfieldMbNumber
        otpReceivedLabel.isHidden = true
        receivedOTPUIView.isHidden = true
        registerButton.isHidden = true
        registerButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button = UIButton()
        button.setTitle("Return", for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.frame = CGRect(x: 0, y: 163, width: 106, height: 53)
        button.adjustsImageWhenHighlighted = false
        //button.addTarget(self, action: #selector(self.sendOTPAPI), for: UIControlEvents.touchUpInside)
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        self.addDoneButtonOnKeyboard()
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
////        ConstraintsofUI()
        mobileNumberTextFIeld.setBottomBorder()
        otpDigitFirstTF.setBottomBorder()
        otpDigitSecondTF.setBottomBorder()
        otpDigitThirdTF.setBottomBorder()
        otpDigitFourthTF.setBottomBorder()
        otpDigitFifthTF.setBottomBorder()
        otpDigitSixthTF.setBottomBorder()
        otpDigitFirstTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpDigitSecondTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpDigitThirdTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpDigitFourthTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpDigitFifthTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpDigitSixthTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        
        
        mobileNumberTextFIeld.becomeFirstResponder()
        
        
       
    }
    
    
    
   
    override var shouldAutorotate: Bool{
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func sendOTPButtonAction(_ sender: Any) {
        
      
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        var userEnteredOTPText = otpDigitFirstTF.text! + otpDigitSecondTF.text! + otpDigitThirdTF.text! + otpDigitFourthTF.text! + otpDigitFifthTF.text! + otpDigitSixthTF.text!
        let userEnteredOTP = Int(userEnteredOTPText)
        if userEnteredOTP == otpFromServer {
            
        
            
            let storedUserMobileNo = self.mobileNumberTextFIeld.text
            UserDefaults.standard.set(storedUserMobileNo, forKey: "mobileno")
            UserDefaults.standard.set(Int(self.temp.userId), forKey: "userid")
            self.GetUserInfo()
            
//            let vcGetStarted = storyboard?.instantiateViewController(withIdentifier: "getstarted") as! GettingStartedViewController
//            self.present(vcGetStarted, animated: true, completion: nil)
            
            
        }else {
            let alertcontrol = UIAlertController(title: "RecheckKey".localizableString(loc: language!), message: "IncorrectIdKey".localizableString(loc: language!), preferredStyle: UIAlertControllerStyle.alert)
           
            alertcontrol.addAction(UIAlertAction(title: "OkKey".localizableString(loc: language!), style: UIAlertActionStyle.default,handler: nil))
           
            self.present(alertcontrol, animated: true, completion: nil)
            
           
            
        }
    }
    
    func GetUserInfo() {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) in
            print(response)
            let jsonobject = response["info"] as? NSDictionary;
            let temp = ModelProfileClass()
            temp.firstName = jsonobject?.object(forKey: "firstName") as? String ?? ""
            temp.lastName = jsonobject?.object(forKey: "lastName") as? String ?? ""
            temp.email = jsonobject?.object(forKey: "email") as? String ?? ""
            temp.mobile = jsonobject?.object(forKey: "mobile") as? String ?? ""
//            temp.isnominee = jsonobject?.object(forKey: "isNominatedUser") as? Int ?? 0
            let clientId = jsonobject?.object(forKey: "clientId") as? String ?? ""
            let url = jsonobject?.object(forKey: "profileImageUrl") as? String ?? ""
            
            let quizTaken =  jsonobject?.object(forKey:"quizTestGiven") as? Int ?? -1
            UserDefaults.standard.set(quizTaken, forKey: "quiztakenID")
            let quizID = UserDefaults.standard.string(forKey: "quiztakenID")
            print(quizID, quizTaken)
            let fileUrl = URL(string: url)
            UserDefaults.standard.set(Int(clientId), forKey: "clientid")
            
            UserDefaults.standard.set(temp.mobile, forKey: "mobileno")


            
            USERDETAILS = UserDetails(email: temp.email, firstName: temp.firstName, lastname: temp.lastName, imageurl: url, mobile : temp.mobile)
//                                      isNominee: temp.isnominee)
            
            let isFirstTimeUser =  jsonobject?.object(forKey:"isFirstTimeUser") as? String ?? "true"
            //self.sendLanguagesSelected()
            print(isFirstTimeUser, "<<<<<<<---- first time user flag")
            
             let userType = jsonobject?.object(forKey: "userType") as? Int ?? 0
             UserDefaults.standard.set(userType, forKey: "userType")
            
             let priLang = jsonobject?.object(forKey: "clientLanguage") as? String ?? ""
             UserDefaults.standard.set(priLang, forKey: "Language2")
             let secLang = jsonobject?.object(forKey: "learningLanguage") as? String ?? ""
             UserDefaults.standard.set(priLang, forKey: "Language3")

            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
            
            if isFirstTimeUser == "true" {
                self.secondaryFuncDemoFirstTime()

            }else {
                
                if secLang == "" {
                    
                    // secondary
                    
                    self.secondaryFuncNormalUser(quiz: quizTaken)
                    
                   /* let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                    nextViewController.type = "secondary"
                    nextViewController.back = "quiz"
                    nextViewController.quizTaken = quizTaken
                    self.present(nextViewController, animated:true, completion:nil) */

                    
                } else{
                    
                    
                    if quizTaken == 1 {
                        print("1")
                        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                        let aObjNavi = UINavigationController(rootViewController: startVC)
                        aObjNavi.navigationBar.barTintColor = UIColor.blue
                        DispatchQueue.main.async {
                            self.present(aObjNavi, animated: true, completion: nil)
                            
                        }
                        
                    } else {
                        
                        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
                        DispatchQueue.main.async {
                            self.present(startVC, animated: true, completion: nil)
                        }
                        
                        
                    }
                    
                    
                }

             
               
                
              
                
                
                
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

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isBackspace && textField.text! == "" {
            switch textField{
            case otpDigitSecondTF:
                otpDigitSecondTF.resignFirstResponder()
                otpDigitFirstTF.becomeFirstResponder()
                
            case otpDigitThirdTF :
                otpDigitSecondTF.becomeFirstResponder()
                
            case otpDigitFourthTF :
                otpDigitThirdTF.becomeFirstResponder()
                
            case otpDigitFifthTF :
                otpDigitFourthTF.becomeFirstResponder()
                
            case otpDigitSixthTF :
                otpDigitFifthTF.becomeFirstResponder()
            default:
                print("default case")
                break
            }
        }
        
        
        let charsLimit = 10
        
        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        return newLength <= charsLimit
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        otpDigitFirstTF.becomeFirstResponder()
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        
        if text?.utf16.count == 1 {
            switch textField{
            case otpDigitFirstTF:
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 1, animations: {
                    self.topOutlet.constant = 55
                    self.view.layoutIfNeeded()
                })
                otpDigitSecondTF.becomeFirstResponder()
                
            case otpDigitSecondTF:
                otpDigitThirdTF.becomeFirstResponder()
            
            case otpDigitThirdTF :
                otpDigitFourthTF.becomeFirstResponder()
                
            case otpDigitFourthTF :
                otpDigitFifthTF.becomeFirstResponder()
                
            case otpDigitFifthTF :
                otpDigitSixthTF.becomeFirstResponder()
                
            case otpDigitSixthTF :
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 1, animations: {
                    self.topOutlet.constant = 96
                    self.view.layoutIfNeeded()
                })
                otpDigitSixthTF.resignFirstResponder()
            default:
                print("default case")
                break
            }
        }
    }

    func sendOTPAPI() {
        
        
        let startingLength = mobileNumberTextFIeld.text?.count ?? 0
        if startingLength != 10 {
             let language = UserDefaults.standard.string(forKey: "currentlanguage")
            let alertcontroller = UIAlertController(title: "AlertKey".localizableString(loc: language!), message: "EnterValidMobileKey".localizableString(loc: language!), preferredStyle: UIAlertControllerStyle.alert)
           
            alertcontroller.addAction(UIAlertAction(title: "OkKey".localizableString(loc: language!), style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertcontroller, animated: true, completion: nil)

        }else {
            
            var deviceId = UIDevice.current.identifierForVendor?.uuidString
            
            if deviceId == nil {
                
                deviceId = ""
            }

            
            let params = ["phone":"\(mobileNumberTextFIeld.text!)", "access_token":"\(accessToken)","deviceId":"\(deviceId!)"] as Dictionary<String, String>
            print(params)
            activityUIView.isHidden = false
            activityUIView.startAnimation()
            MakeHttpPostRequest(url: sendOtpApiURL, params: params, completion: {(success, response) -> Void in
                print(response)
                 self.temp.userId = response.value(forKey: "userId") as? String ?? ""
                self.temp.otp = response.value(forKey: "otp") as? Int ?? 0
                self.otpFromServer = self.temp.otp
                
                DispatchQueue.main.async {
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                    self.registerButton.isEnabled = true
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
    @objc
    func hideKeyboard(){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, animations: {
            self.topOutlet.constant = 96
            self.view.layoutIfNeeded()
        })
        DispatchQueue.main.async {
            self.otpReceivedLabel.isHidden = false
            self.receivedOTPUIView.isHidden = false
            self.registerButton.isHidden = false
            self.btnResend.isHidden = false;
            
        }
        self.view.endEditing(true)
        sendOTPAPI()
    }
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.sendOTPAPI))
//
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.hideKeyboard))
        

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.mobileNumberTextFIeld.inputAccessoryView = doneToolbar
        
    }
    
    
   
    
    func sendLanguagesSelected() {
        
        self.sendFcm()
        
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        let language1 = UserDefaults.standard.string(forKey: "Language1")
        let language2 = UserDefaults.standard.string(forKey: "Language2")
        
        var params =  Dictionary<String, String>()
        if language1 != nil && language2 != nil
        {
          
       
            params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientID)","appLanguage":"\(language1!)","learningLanguage":"\(language2!)"] as Dictionary<String, String>
            print(params)

        
        DispatchQueue.main.async {
            self.activityUIView.isHidden = false
            self.activityUIView.startAnimation()
        }
        MakeHttpPostRequest(url: saveLanguageSelected, params: params, completion: {(success, response) -> Void in
            print(response)
            
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
        
    }
    
    private func secondaryFuncNormalUser(quiz : Int){
        
        var clientid = UserDefaults.standard.string(forKey: "clientid")
        var userid = UserDefaults.standard.string(forKey: "userid")
        
        if clientid == nil {
            clientid = ""
        }
        
        if userid == nil {
            userid = ""
        }
        
       
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid!)"] as Dictionary<String, String>
        print(params)

        MakeHttpPostRequest(url: getLanguageListCall, params: params, completion: {(success, response) -> Void in
            print(response)
            
            
                
                let language = response.object(forKey: "secondaryList") as? NSArray ?? []
                var arr = [LanguageList]()
                for languages in language {
                    arr.append(LanguageList( languages as! NSDictionary))
                }
            
            DispatchQueue.main.async {

                if arr.count == 1 {
                    let text = arr[0].dbname
                    UserDefaults.standard.set(text, forKey: "Language3")
                    
                    if quiz == 1 {
                        print("1")
                        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                        let aObjNavi = UINavigationController(rootViewController: startVC)
                        aObjNavi.navigationBar.barTintColor = UIColor.blue
                        DispatchQueue.main.async {
                            self.present(aObjNavi, animated: true, completion: nil)
                            
                        }
                        
                        
                    } else {
                        
                        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
                        DispatchQueue.main.async {
                            self.present(startVC, animated: true, completion: nil)
                        }
                        
                        
                        
                    }
                    
                    
                }else{
                    
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                    nextViewController.type = "secondary"
                    nextViewController.back = "quiz"
                    nextViewController.quizTaken = quiz
                    DispatchQueue.main.async {
                    self.present(nextViewController, animated:true, completion:nil)
                    }

                }
                
            }
                
            
            
        }, errorHandler: {(message) -> Void in
            
        })
        
        
    }
    
    
    private func secondaryFuncNormalUserFirstTime(){
        
        var clientid = UserDefaults.standard.string(forKey: "clientid")
        var userid = UserDefaults.standard.string(forKey: "userid")
        
        if clientid == nil {
            clientid = ""
        }
        
        if userid == nil {
            userid = ""
        }
        
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid!)"] as Dictionary<String, String>
        print(params)

        MakeHttpPostRequest(url: getLanguageListCall, params: params, completion: {(success, response) -> Void in
            print(response)
            
            
            
            let language = response.object(forKey: "secondaryList") as? NSArray ?? []
            var arr = [LanguageList]()
            for languages in language {
                arr.append(LanguageList( languages as! NSDictionary))
            }
            
            DispatchQueue.main.async {
                
                if arr.count == 1 {
                    
                    let text = arr[0].dbname
                    UserDefaults.standard.set(text, forKey: "Language3")
                    
                    
                    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "MasterVC") as! RootUIPageViewController
                    DispatchQueue.main.async {
                    self.present(startVC, animated: true, completion: nil)
                    }
                    
                    
                }else{
                    
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                    nextViewController.type = "secondary"
                    nextViewController.back = "getstarted"
                    DispatchQueue.main.async {
                    self.present(nextViewController, animated:true, completion:nil)
                    }
                    
                }
                
            }
            
            
            
        }, errorHandler: {(message) -> Void in
            
        })
        
        
    }
    
    
    private func secondaryFuncDemoFirstTime(){
        
        var clientid = UserDefaults.standard.string(forKey: "clientid")
        var userid = UserDefaults.standard.string(forKey: "userid")
        
        if clientid == nil {
            clientid = ""
        }
        
        if userid == nil {
            userid = ""
        }
        
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid!)"] as Dictionary<String, String>
        
        print(params)
        
        MakeHttpPostRequest(url: getLanguageListCall, params: params, completion: {(success, response) -> Void in
            print(response)
            
            let languagepri = response.object(forKey: "primaryList") as? NSArray ?? []
            var arrpri = [LanguageList]()
            for languages in languagepri {
                arrpri.append(LanguageList( languages as! NSDictionary))
            }
            
            if arrpri.count == 1 {
                
                let text = arrpri[0].dbname
                UserDefaults.standard.set(text, forKey: "Language2")
                
                
                let language = response.object(forKey: "secondaryList") as? NSArray ?? []
                var arr = [LanguageList]()
                for languages in language {
                    arr.append(LanguageList( languages as! NSDictionary))
                }
                
                if arr.count == 1 {
                    
                    let text = arr[0].dbname
                    UserDefaults.standard.set(text, forKey: "Language3")
                    
                    DispatchQueue.main.async {
                    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "MasterVC") as! RootUIPageViewController
                    self.present(startVC, animated: true, completion: nil)
                    }
                    
                }else{
                    
                    DispatchQueue.main.async {
                    
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                    nextViewController.type = "secondary"
                    nextViewController.back = "getstarted"
                    self.present(nextViewController, animated:true, completion:nil)
                        
                    }
                }
                

            }else{
                
                DispatchQueue.main.async {
                    
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                    nextViewController.type = "firsttime"
                    nextViewController.back = "getstarted"
                    self.present(nextViewController, animated:true, completion:nil)

                }
                
            }
            
        }, errorHandler: {(message) -> Void in
            
        })
        
        
    }
    
    func sendFcm() {
     
        
        var params =  Dictionary<String, String>()
        

        let userID = UserDefaults.standard.integer(forKey: "userid")
        var fcm = UserDefaults.standard.string(forKey: "fcm")
        
        if fcm == nil {
            
            fcm = ""
        }
        
        var deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        if deviceId == nil {
            
            deviceId = ""
        }
        


        
        params = ["access_token":"\(accessToken)","device_id":"\(deviceId!)","device_type":"iPhone","device_info":"iPhone","device_token":"\(fcm!)","userId":"\(userID)"] as Dictionary<String, String>
        print(params)
        
        MakeHttpPostRequest(url: saveDeviceToken, params: params, completion: {(success, response) -> Void in
            print(response)
            
            
        }, errorHandler: {(message) -> Void in
            
        })
        
      
       }

}


