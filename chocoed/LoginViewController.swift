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
    override func viewDidLoad() {
        super.viewDidLoad()
        ConstraintsofUI()
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
        
        
    }
    
    func ConstraintsofUI()
    {
        imageViewMessage.translatesAutoresizingMaskIntoConstraints = false
        imageViewMessage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageViewMessage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageViewMessage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        imageViewMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        labelInstruct.translatesAutoresizingMaskIntoConstraints = false
        labelInstruct.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelInstruct.topAnchor.constraint(equalTo: imageViewMessage.bottomAnchor, constant: 20).isActive = true
        labelInstruct.heightAnchor.constraint(equalToConstant: 50).isActive =  true
        
        labelMobileNo.translatesAutoresizingMaskIntoConstraints = false
        labelMobileNo.bottomAnchor.constraint(equalTo: mobileNumberTextFIeld.bottomAnchor, constant: 10).isActive = true
        labelMobileNo.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        labelMobileNo.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -16).isActive = true

        mobileNumberTextFIeld.translatesAutoresizingMaskIntoConstraints = false
        mobileNumberTextFIeld.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mobileNumberTextFIeld.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        mobileNumberTextFIeld.topAnchor.constraint(equalTo: labelMobileNo.bottomAnchor, constant: 5).isActive = true
        mobileNumberTextFIeld.setBottomBorder()
        otpDigitFirstTF.setBottomBorder()
        otpDigitSecondTF.setBottomBorder()
        otpDigitThirdTF.setBottomBorder()
        otpDigitFourthTF.setBottomBorder()
        mobileNumberTextFIeld.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true


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
        
        otpDigitFirstTF.translatesAutoresizingMaskIntoConstraints =  false
        otpDigitSecondTF.translatesAutoresizingMaskIntoConstraints =  false
        otpDigitThirdTF.translatesAutoresizingMaskIntoConstraints =  false
        otpDigitFourthTF.translatesAutoresizingMaskIntoConstraints =  false
        
        otpDigitFirstTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        otpDigitSecondTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26).isActive = true
        otpDigitThirdTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        otpDigitFourthTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46).isActive = true
        
        otpDigitFirstTF.widthAnchor.constraint(equalToConstant: 40).isActive = true
        otpDigitSecondTF.widthAnchor.constraint(equalToConstant: 40).isActive = true
        otpDigitThirdTF.widthAnchor.constraint(equalToConstant: 40).isActive = true
        otpDigitFourthTF.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        otpDigitFirstTF.topAnchor.constraint(equalTo: labelOTPReceived.bottomAnchor, constant: 15).isActive = true
        otpDigitSecondTF.topAnchor.constraint(equalTo: labelOTPReceived.bottomAnchor, constant: 15).isActive = true
        otpDigitThirdTF.topAnchor.constraint(equalTo: labelOTPReceived.bottomAnchor, constant: 15).isActive = true
        otpDigitFourthTF.topAnchor.constraint(equalTo: labelOTPReceived.bottomAnchor, constant: 15).isActive = true
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let charsLimit = 10
        
        let startingLength = mobileNumberTextFIeld.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        return newLength <= charsLimit
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        otpDigitFirstTF.becomeFirstResponder()
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

   
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
