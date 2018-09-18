//
//  LoginViewController.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mobileNumberTextFIeld: UITextField!
    @IBOutlet weak var otpDigitFirstTF: UITextField!
    @IBOutlet weak var otpDigitFourthTF: UITextField!
    @IBOutlet weak var otpDigitThirdTF: UITextField!
    @IBOutlet weak var otpDigitSecondTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileNumberTextFIeld.setBottomBorder()
        otpDigitFirstTF.setBottomBorder()
        otpDigitSecondTF.setBottomBorder()
        otpDigitThirdTF.setBottomBorder()
        otpDigitFourthTF.setBottomBorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
