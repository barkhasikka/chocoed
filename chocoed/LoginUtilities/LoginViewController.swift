//
//  LoginViewController.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate
{
    @IBOutlet weak var labelMobileNo: UILabel!
    
    @IBOutlet weak var otpReceivedLabel: UILabel!
    @IBOutlet weak var receivedOTPUIView: UIView!
    
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
    
    var button: UIButton!
    var otpFromServer = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func sendOTPButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        var userEnteredOTPText = otpDigitFirstTF.text! + otpDigitSecondTF.text! + otpDigitThirdTF.text! + otpDigitFourthTF.text! + otpDigitFifthTF.text! + otpDigitSixthTF.text!
        let userEnteredOTP = Int(userEnteredOTPText)
        if userEnteredOTP == otpFromServer {
            self.sendLanguagesSelected()
            let vcGetStarted = storyboard?.instantiateViewController(withIdentifier: "getstarted") as! GettingStartedViewController
            self.present(vcGetStarted, animated: true, completion: nil)
        }else {
            let alertcontrol = UIAlertController(title: "alert!", message: "Login Failed! Please check your OTP again.", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertcontrol.addAction(alertaction)
            self.present(alertcontrol, animated: true, completion: nil)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isBackspace && textField.text! == "" {
            print("Back space is detected")
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
                otpDigitFourthTF.resignFirstResponder()
            default:
                print("default case")
                break
            }
        }
    }

    func sendOTPAPI() {
        let params = ["phone":"\(mobileNumberTextFIeld.text!)", "access_token":"\(accessToken)"] as Dictionary<String, String>
        MakeHttpPostRequest(url: sendOtpApiURL, params: params, completion: {(success, response) -> Void in
            print(response)
            let temp = ModelClassLoginId()
            
            temp.userId = response.value(forKey: "userId") as? String ?? ""
            temp.otp = response.value(forKey: "otp") as? Int ?? 0
            UserDefaults.standard.set(Int(temp.userId), forKey: "userid")
            self.otpFromServer = temp.otp
        })
        
    }
    @objc
    func hideKeyboard(){
        DispatchQueue.main.async {
                            self.otpReceivedLabel.isHidden = false
                            self.receivedOTPUIView.isHidden = false
                            self.registerButton.isHidden = false
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
    func sendLanguagesSelected()
    {
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        let language1 = UserDefaults.standard.string(forKey: "Language1")
        let language2 = UserDefaults.standard.string(forKey: "Language2")
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientID)","appLanguage":"\(language1!)","learningLanguage":"\(language2!)"] as Dictionary<String, String>
        print(params)
        MakeHttpPostRequest(url: saveLanguageSelected, params: params, completion: {(success, response) -> Void in
            print(response)
            ////            let language = response.object(forKey: "appList") as? NSArray ?? []
            ////
            ////            for languages in language {
            ////                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
            //            }
            
        })
        
    }

}

