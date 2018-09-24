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

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var profileDataUIViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileDataUIViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileDataUIView: UIView!
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
    
    let picker = YPImagePicker()
    
    
    var fetchedvalueProfile = ModelProfileClass()
    var activeField: UITextField!
    var keyboardHeight: CGFloat!
    var lastOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 20
        submitButton.clipsToBounds = true
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
//        self.profileDataUIViewTopConstraint.constant = -100
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedPopup(tapGestureRecognizer:)))
        imageviewCircle.isUserInteractionEnabled = true
        imageviewCircle.addGestureRecognizer(tapGestureRecognizer)
        
        imageView1.image = UIImage(named: "avatar_1")
        imageView2.image = UIImage(named: "avatar_2")
        imageView3.image = UIImage(named: "avatar_3")
        imageView4.image = UIImage(named: "avatar_4")
        imageView5.image = UIImage(named: "avatar_5")
        imageView6.image = UIImage(named: "avatar_6")
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTappedAvatar1(tapGestureRecognizer:)))
        imageView1.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(tapGestureRecognizer1)
    
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTappedAvatar2(tapGestureRecognizer:)))
        imageView2.isUserInteractionEnabled = true
        imageView2.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTappedAvatar3(tapGestureRecognizer:)))
        imageView3.isUserInteractionEnabled = true
        imageView3.addGestureRecognizer(tapGestureRecognizer3)
        
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(imageTappedAvatar4(tapGestureRecognizer:)))
        imageView4.isUserInteractionEnabled = true
        imageView4.addGestureRecognizer(tapGestureRecognizer4)
        
        
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(imageTappedAvatar5(tapGestureRecognizer:)))
        imageView5.isUserInteractionEnabled = true
        imageView5.addGestureRecognizer(tapGestureRecognizer5)
        
        
        let tapGestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(imageTappedAvatar6(tapGestureRecognizer:)))
        imageView6.isUserInteractionEnabled = true
        imageView6.addGestureRecognizer(tapGestureRecognizer6)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        print("Please select image")
        // Your action
        
        popUpView.isHidden = false
    
        //code of YPImagePickerView
        picker.didSelectImage = { [unowned picker] img in
            // image picked
            print(img.size)
            self.imageviewCircle.image = img
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)

        self.popUpView.isHidden = true
    }
    
    
    @objc func imageTappedPopup(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Please select image")
        self.popUpView.isHidden =  false
      
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func imageTappedAvatar1(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Please select image")
        
        imageviewCircle.image = imageView1.image
        self.popUpView.isHidden = true
        // Your action
    }
    @objc func imageTappedAvatar6(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Please select image")
        
        imageviewCircle.image = imageView6.image
        self.popUpView.isHidden = true
        // Your action
    }
    @objc func imageTappedAvatar2(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Please select image")
        
        imageviewCircle.image = imageView2.image
        self.popUpView.isHidden = true
        // Your action
    }
    @objc func imageTappedAvatar3(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Please select image")
        
        imageviewCircle.image = imageView3.image
        self.popUpView.isHidden = true
        // Your action
    }
    @objc func imageTappedAvatar4(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Please select image")
        
        imageviewCircle.image = imageView4.image
        self.popUpView.isHidden = true
        // Your action
    }
    @objc func imageTappedAvatar5(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Please select image")
        
        imageviewCircle.image = imageView5.image
        self.popUpView.isHidden = true
        // Your action
    }

    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
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
        print(imageviewCircle.frame.width, "width is here", imageviewCircle.frame.height)
        imageviewCircle.layer.cornerRadius = imageviewCircle.frame.width / 2
        imageviewCircle.clipsToBounds = true
        imageviewCircle.image = image
    }
   
    func GetUserInfo() {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID)
        let params = ["userId": "\(userID)",  "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) in
            do {
                print(response ,"get profile info reply")
                let jsonobject = response["info"] as? NSDictionary;
                print("====",jsonobject)
                let temp = ModelProfileClass()
                temp.firstName = jsonobject?.object(forKey: "firstName") as? String ?? ""
                temp.lastName = jsonobject?.object(forKey: "lastName") as? String ?? ""
                temp.email = jsonobject?.object(forKey: "email") as? String ?? ""
                temp.mobile = jsonobject?.object(forKey: "mobile") as? String ?? ""
                DispatchQueue.main.async(execute: {
                    self.textfieldFirstName.text = temp.firstName
                    self.textfieldLastName.text = temp.lastName
                    self.textfieldEmailId.text = temp.email
                    self.textfieldMobileNo.text = temp.mobile
                })
            }catch let error {
                print(error.localizedDescription)
            }
        })
    }
    
    
    
    @IBAction func submitButtonAction(_ sender: Any){
     
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            let keyBoardY = self.view.frame.height - keyboardHeight
            print("Value of keyboard Y", keyBoardY)
            print("Y of active field keyboard will show", (self.activeField?.frame.origin.y)! + (self.activeField?.frame.height)!)
            
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
//                self.profileDataUIViewHeightConstraint.constant += self.keyboardHeight
            })
            // move if keyboard hide input field
//            let distanceToBottom = self.profileDataUIView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
//            let collapseSpace = keyboardHeight - distanceToBottom
//            if collapseSpace < 0 {
//                // no collapse
//                return
//            }
//            // set new offset for scroll view
//            UIView.animate(withDuration: 0.3, animations: {
//                // scroll to the position above keyboard 10 points
////                self.profileDataUIView.safeAreaInsets.bottom = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
//            })
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
               let  keyboardHeight = keyboardSize.height
                let keyBoardY = self.view.frame.height - keyboardHeight
                print("Value of keyboard Y", keyBoardY)
                let y = self.activeField?.frame.origin.y
                let height = self.activeField?.frame.height
                print("Y of active field", y! + height!)
            }
            
//            self.profileDataUIViewHeightConstraint.constant -= self.keyboardHeight
//            self.profileDataUIView.safeAreaInsets.bottom = self.lastOffset
        }
        keyboardHeight = nil
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
