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
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var sendOTPButton: UIButton!
    @IBOutlet weak var labelInstruct: UILabel!
    @IBOutlet weak var imageViewMessage: UIImageView!
    @IBOutlet weak var mobileNumberTextFIeld: UITextField!
    @IBOutlet weak var otpDigitFirstTF: UITextField!
    @IBOutlet weak var otpDigitSecondTF: UITextField!
    @IBOutlet weak var otpDigitThirdTF: UITextField!
    
    @IBOutlet weak var otpDigitFourthTF: UITextField!
    @IBOutlet weak var labelOTPReceived: UILabel!
    
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button = UIButton()
        button.setTitle("Return", for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.frame = CGRect(x: 0, y: 163, width: 106, height: 53)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(self.sendOTPAPI), for: UIControlEvents.touchUpInside)
        
        self.addDoneButtonOnKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        ConstraintsofUI()
        mobileNumberTextFIeld.setBottomBorder()
        otpDigitFirstTF.setBottomBorder()
        otpDigitSecondTF.setBottomBorder()
        otpDigitThirdTF.setBottomBorder()
        otpDigitFourthTF.setBottomBorder()
        

        otpDigitFirstTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpDigitSecondTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpDigitThirdTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpDigitFourthTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
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
        let vcGetStarted = storyboard?.instantiateViewController(withIdentifier: "getstarted") as! GettingStartedViewController
        
        self.present(vcGetStarted, animated: true, completion: nil)
    }
    
    func ConstraintsofUI()
    {
        imageViewMessage.translatesAutoresizingMaskIntoConstraints = false
        imageViewMessage.heightAnchor.constraint(equalToConstant: 55).isActive = true
        imageViewMessage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageViewMessage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        imageViewMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        labelInstruct.translatesAutoresizingMaskIntoConstraints = false
        labelInstruct.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelInstruct.topAnchor.constraint(equalTo: imageViewMessage.bottomAnchor, constant: 15).isActive = true
        labelInstruct.heightAnchor.constraint(equalToConstant: 50).isActive =  true
        labelInstruct.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        labelInstruct.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

        
        labelMobileNo.translatesAutoresizingMaskIntoConstraints = false
       // labelMobileNo.topAnchor.constraint(equalTo: labelInstruct.bottomAnchor, constant: 5).isActive = true
       //labelMobileNo.topAnchor.constraint(equalTo: mobileNumberTextFIeld.topAnchor, constant: 5).isActive = true
        labelMobileNo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        labelMobileNo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        labelMobileNo.heightAnchor.constraint(equalToConstant: 20)
//        mobileNumberTextFIeld.translatesAutoresizingMaskIntoConstraints = false
//        mobileNumberTextFIeld.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        mobileNumberTextFIeld.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        mobileNumberTextFIeld.topAnchor.constraint(equalTo: labelMobileNo.bottomAnchor, constant: 5).isActive = true
//        mobileNumberTextFIeld.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
//        mobileNumberTextFIeld.heightAnchor.constraint(equalToConstant: 40).isActive = true
//       
        sendOTPButton.translatesAutoresizingMaskIntoConstraints = false
        sendOTPButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250).isActive = true
        sendOTPButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        sendOTPButton.topAnchor.constraint(equalTo: mobileNumberTextFIeld.bottomAnchor, constant: 5).isActive =  true
        sendOTPButton.widthAnchor.constraint(equalToConstant: 60).isActive =  true

        labelOTPReceived.translatesAutoresizingMaskIntoConstraints = false
        labelOTPReceived.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        labelOTPReceived.topAnchor.constraint(equalTo: mobileNumberTextFIeld.bottomAnchor , constant: 30).isActive = true

        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive =  true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerButton.topAnchor.constraint(equalTo: labelOTPReceived.bottomAnchor, constant: 100).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive =  true
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
//        otpDigitFirstTF.translatesAutoresizingMaskIntoConstraints =  false
//        otpDigitSecondTF.translatesAutoresizingMaskIntoConstraints =  false
//        otpDigitThirdTF.translatesAutoresizingMaskIntoConstraints =  false
//        otpDigitFourthTF.translatesAutoresizingMaskIntoConstraints =  false
//
//        otpDigitFirstTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
//        otpDigitSecondTF.leadingAnchor.constraint(equalTo: otpDigitFirstTF.leadingAnchor, constant: 25).isActive = true
//        otpDigitThirdTF.leadingAnchor.constraint(equalTo: otpDigitSecondTF.leadingAnchor, constant: 25).isActive = true
//        otpDigitFourthTF.leadingAnchor.constraint(equalTo: otpDigitThirdTF.leadingAnchor, constant: 25).isActive = true
//
//        otpDigitFirstTF.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -300).isActive = true
//        otpDigitSecondTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -240).isActive = true
//        otpDigitThirdTF.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -180).isActive = true
//        otpDigitFourthTF.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -120).isActive = true
//
//        otpDigitFirstTF.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        otpDigitSecondTF.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        otpDigitThirdTF.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        otpDigitFourthTF.widthAnchor.constraint(equalToConstant: 40).isActive = true
////
//        otpDigitFirstTF.topAnchor.constraint(equalTo: labelOTPReceived.bottomAnchor, constant: 15).isActive = true
//        otpDigitSecondTF.topAnchor.constraint(equalTo: labelOTPReceived.bottomAnchor, constant: 15).isActive = true
//        otpDigitThirdTF.topAnchor.constraint(equalTo: labelOTPReceived.bottomAnchor, constant: 15).isActive = true
//        otpDigitFourthTF.topAnchor.constraint(equalTo: labelOTPReceived.bottomAnchor, constant: 15).isActive = true
//
//        otpDigitFirstTF.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        otpDigitSecondTF.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        otpDigitThirdTF.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        otpDigitFourthTF.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
        
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
        if text?.utf16.count == 1
        {
            switch textField{
            case otpDigitFirstTF:
                otpDigitSecondTF.becomeFirstResponder()
                
            case otpDigitSecondTF:
                otpDigitThirdTF.becomeFirstResponder()
            
            case otpDigitThirdTF :
                otpDigitFourthTF.becomeFirstResponder()
                
            case otpDigitFourthTF :
                otpDigitFourthTF.resignFirstResponder()
            default:
                print("default case")
                break
            }
        }
        else
        {
            
        }
    }

    @objc
    func sendOTPAPI() {
        let params = ["phone":"\(mobileNumberTextFIeld.text!)", "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        let response = MakeHttpPostRequest(url: sendOtpApiURL, params: params)
        print(response)
    }
    
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.sendOTPAPI))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.mobileNumberTextFIeld.inputAccessoryView = doneToolbar
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let viewHeight = self.view.frame.height
         print("value of y is-----", viewHeight, view.safeAreaInsets.bottom)
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

