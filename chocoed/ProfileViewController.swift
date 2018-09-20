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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageviewCircle.isUserInteractionEnabled = true
        imageviewCircle.addGestureRecognizer(tapGestureRecognizer)
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Please select image")
        // Your action
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
    func imageviewCircular()
    {
        let image = UIImage(named: "no_image")
        imageviewCircle.layer.borderWidth = 1.0
        imageviewCircle.layer.masksToBounds = false
        imageviewCircle.layer.borderColor = UIColor.white.cgColor
        imageviewCircle.layer.cornerRadius = (image?.size.width)! / 3.2
        imageviewCircle.clipsToBounds = true
    }
    @IBAction func submitButtonAction(_ sender: Any) {
        
        
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
