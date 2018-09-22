//
//  ProfileViewController.swift
//  chocoed
//
//  Created by Tejal on 20/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import YPImagePicker

class ProfileViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var ButtonChoose: UIButton!
    @IBOutlet weak var imageviewCircle: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var textfieldMobileNo: UITextField!
    @IBOutlet weak var textfieldEmailId: UITextField!
    @IBOutlet weak var textfieldLastName: UITextField!
    @IBOutlet weak var textfieldFirstName: UITextField!
    @IBOutlet weak var labelMobileno: UILabel!
    @IBOutlet weak var labelEmailId: UILabel!
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var labelFirstName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 20
        submitButton.clipsToBounds = true
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)

        imageviewCircular()
        
        textfieldFirstName.setBottomBorder()
        textfieldLastName.setBottomBorder()
        textfieldEmailId.setBottomBorder()
        textfieldMobileNo.setBottomBorder()
        
        labelFirstName.isHidden = true
        labelLastName.isHidden = true
        labelEmailId.isHidden = true
        labelMobileno.isHidden = true
        
        self.hideKeyboardWhenTappedAround()
        self.popUpView.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageviewCircle.isUserInteractionEnabled = true
        imageviewCircle.addGestureRecognizer(tapGestureRecognizer)
        imageView1.image = UIImage(named: "avatar_1")
        imageView2.image = UIImage(named: "avatar_2")
        imageView3.image = UIImage(named: "avatar_3")
        imageView4.image = UIImage(named: "avatar_4")
        imageView5.image = UIImage(named: "avatar_5")
        imageView6.image = UIImage(named: "avatar_6")
        
        GetUserInfo()
        
       }

    @IBAction func CloseAction(_ sender: Any) {
        self.popUpView.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Please select image")
        // Your action
        
        popUpView.isHidden = false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1
        {
        labelFirstName.isHidden = false
        }
        else if textField.tag == 2
        {
        labelLastName.isHidden = false
        }
        else if textField.tag == 3
        {
        labelEmailId.isHidden = false
        }
        else if textField.tag == 4
        {
        labelMobileno.isHidden = false
        }
    }
    func imageviewCircular(){
        let image = UIImage(named: "no_image")
        imageviewCircle.layer.borderWidth = 1.0
        imageviewCircle.layer.masksToBounds = false
        imageviewCircle.layer.borderColor = UIColor.white.cgColor
        imageviewCircle.layer.cornerRadius = (image?.size.width)! / 3.2
        imageviewCircle.clipsToBounds = true
    }
   
    func GetUserInfo()
    {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        //
        //        let params = ["userId":"\(userID)", "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        //        let response = MakeHttpPostRequest(url: getUserInfo, params: params)
        //        print(response)
        //        let vcEduProf = storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
        //
        
        let url = NSURL(string: "\(getUserInfo)")
        
        //create the session object
        let session = URLSession.shared
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        let params = ["userId": "\(59)",  "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        
        do {
            let httpBody =  try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            let httpBodyString = String(data: httpBody, encoding: String.Encoding.utf8)
            request.httpBody = httpBodyString?.data(using: String.Encoding.utf8)
            
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
                    
                   let jsonobject = json["info"] as? NSDictionary
                    
      //              let rootarray = jsonobject?.object(forKey: "email") as? String ?? ""
                    
//                    for item in rootarray
//                    {
                    
//                        let obj = item as! NSDictionary
//                        let temp = NGOEventDetails()
//                        temp.eventid = obj.object(forKey: "EventID") as? Int
//
//                        temp.eventname = obj.object(forKey: "EventName") as? String ?? ""
                //    }
                    }
            }catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    
    @IBAction func submitButtonAction(_ sender: Any){
     
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
