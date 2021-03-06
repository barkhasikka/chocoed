//
//  GettingStartedViewController.swift
//  chocoed
//
//  Created by Tejal on 20/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class GettingStartedViewController: UIViewController {

    @IBOutlet weak var getStartedButtonLabel: UIButton!
    @IBOutlet weak var thereIsOnlyYouLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        self.welcomeLabel.text = "WelcomeKey".localizableString(loc: language!)
        self.thereIsOnlyYouLabel.text = "ProfileMsgForUserKey".localizableString(loc: language!)
         self.getStartedButtonLabel.setTitle("GetStartedKey".localizableString(loc: language!), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool{
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func gettingStartedAction(_ sender: Any) {
//        let vcProfile =  self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
//        self.present(vcProfile, animated:true, completion:nil)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
