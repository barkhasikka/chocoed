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

    func sendOTPAPI()
    {
        let url = NSURL(string: "\(sendOtpApiURL)")
        
        //create the session object
        let session = URLSession.shared
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: url! as URL)
        let params = ["phone":"\(mobileNumberTextFIeld.text!)"] as Dictionary<String, String>
        
        let parameters = ["method" : "MobileApiServices.Register","params" :  [params],"id": 1] as Dictionary<String, AnyObject>
        request.httpMethod = "POST" //set http method as POST
        
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            print("DATA ONE", data1)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print("CONVERTED STRING----", convertedString!)
            request.httpBody = convertedString?.data(using: String.Encoding.utf8)
            // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print("error in serialization==",error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                print("error in the request", error ?? "")
                DispatchQueue.main.async(execute: {
                    let alertcontrol = UIAlertController(title: "alert!", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertcontrol.addAction(alertaction)
                    self.present(alertcontrol, animated: true, completion: nil)
                })
                return
            }
            
            guard let data = data else {
                print("something is wrong")
                DispatchQueue.main.async(execute: {
                    let alertcontrol = UIAlertController(title: "alert!", message: "AppId not found", preferredStyle: .alert)
                    let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alertcontrol.addAction(alertaction)
                    self.present(alertcontrol, animated: true, completion: nil)
                })
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                // do whatever with the status code
                print(statusCode)
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                    print(json)
                    
                    let jsonobject = json["result"] as? NSDictionary
                    let appid = jsonobject?.object(forKey: "AppID") as? String ?? ""
                    
                    print(appid)
                    UserDefaults.standard.set("\(appid)", forKey: "APPID")
                    DispatchQueue.main.async(execute: {
                        let viewcontrollerMain = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
                        self.present(viewcontrollerMain!, animated: true, completion: nil)
                    })
                }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async(execute: {
                    let alertcontrol = UIAlertController(title: "alert!", message: error.localizedDescription, preferredStyle: .alert)
                    let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alertcontrol.addAction(alertaction)
                    self.present(alertcontrol, animated: true, completion: nil)
                })
            }
        }
        task.resume()
    }
    
}

