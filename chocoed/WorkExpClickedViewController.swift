//
//  WorkExpClickedViewController.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class WorkExpClickedViewController: UIViewController {

    @IBOutlet weak var addNewWorkUIButton: UIButton!
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var educationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func PreviousButtonAction(_ sender: Any) {
        
        let vcprev = storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
        
        self.present(vcprev, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addNewWorkAction(_ sender: Any) {
        print("add new work clicked")
        let vcGetStarted = storyboard?.instantiateViewController(withIdentifier: "newwork") as! NewWorkExperienceVC
        
        self.present(vcGetStarted, animated: true, completion: nil)
    }
}
