//
//  SignUpViewController.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var educationUIView: UIView!
    @IBOutlet weak var workUIView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        educationUIView.isHidden = false
        workUIView.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func educationButtonAction(_ sender: Any) {
        educationUIView.isHidden = false
        workUIView.isHidden = true
    }
    
    @IBAction func workButtonAction(_ sender: Any) {
        educationUIView.isHidden = true
        workUIView.isHidden = false
    }
    
    
    @IBAction func addNewWorkAction(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "newwork") as! NewWorkExperienceVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func addNewEducationAction(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "neweducation") as! NewEducationExperienceVC
        self.present(nextViewController, animated:true, completion:nil)
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
