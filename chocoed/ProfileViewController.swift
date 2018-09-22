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
    
    
    @IBAction func submitButtonAction(_ sender: Any){
        let userID = UserDefaults.standard.integer(forKey: "userid")
//
//        let params = ["userId":"\(userID)", "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
//        let response = MakeHttpPostRequest(url: getUserInfo, params: params)
//        print(response)
//        let vcEduProf = storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
//
            let url = URL(string: "\(getUserInfo)")
            
            var request = URLRequest(url: url!)
            
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) {(data : Data?, response : URLResponse?,error : Error?) in
                
                if error == nil
                {
                    print("unable to fetch")
                    
                }
                
                do
                {
                    let rootdictionary = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(rootdictionary)
                    
//                    let rootarray = rootdictionary.object(forKey: "listEvent") as! NSArray
//
//                    for item in rootarray
//                    {
//
//                        let obj = item as! NSDictionary
//                        let temp = NGOEventDetails()
//                        temp.eventid = obj.object(forKey: "EventID") as? Int
//
//                        temp.eventname = obj.object(forKey: "EventName") as? String ?? ""
//
//
//                        temp.amountraised = obj.object(forKey: "AmountToBeRaised") as? String ?? ""
//                        temp.category = obj.object(forKey: "Category") as? String ?? ""
//                        temp.decription = obj.object(forKey: "Description") as? String ?? ""
//                        temp.startdate = obj.object(forKey: "StartDate") as? String ?? ""
//                        temp.enddate = obj.object(forKey: "EndDate") as? String ?? ""
//                        temp.milestone = (obj.object(forKey: "Milestone") as? NSArray ?? [])
//
                    
                        //                do {
                        //                    if let data = data,
                        //                        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                        //                        let blogs = json["blxogs"] as? [[String: Any]] {
                        //                        for blog in blogs {
                        //                            if let name = blog["name"] as? String {
                        //                                names.append(name)
                        //                            }
                        //                        }
                        //                    }
                        //                } catch {
                        //                    print("Error deserializing JSON: \(error)")
                        //                }
                        //
                        //                print(names)
                        //
                    
                }
            }
            
            task.resume()
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
