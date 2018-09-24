//
//  SignUpViewController.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var addeducationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addeducationButton.backgroundColor = .clear
        addeducationButton.layer.cornerRadius = 20
        addeducationButton.layer.borderWidth = 1
        addeducationButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewEducationAction(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "neweducation") as! NewEducationExperienceVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        let vcnext = storyboard?.instantiateViewController(withIdentifier: "work") as! WorkExpClickedViewController
        
        self.present(vcnext, animated: true, completion: nil)
        
    }

}
