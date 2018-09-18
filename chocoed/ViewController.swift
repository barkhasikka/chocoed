//
//  ViewController.swift
//  chocoed
//
//  Created by barkha sikka on 17/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
}

