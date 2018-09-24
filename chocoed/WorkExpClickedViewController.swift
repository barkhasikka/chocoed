//
//  WorkExpClickedViewController.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class WorkExpClickedViewController: UIViewController {
    
    @IBOutlet weak var addnewWorkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addnewWorkButton.backgroundColor = .clear
        addnewWorkButton.layer.cornerRadius = 20
        addnewWorkButton.layer.borderWidth = 1
        addnewWorkButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(59)",  "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) in
            let jsonobject = response["info"] as? NSDictionary;
            print(jsonobject,"PLEASE CHECK THIS VALUE")
            let workExperiences = response.object(forKey: "userWorkExperienceList") as? NSArray ?? []
        })
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

@IBAction func nextButtonAction(_ sender: Any) {
}
    
    
    @IBAction func addNewWorkAction(_ sender: Any) {
        print("add new work clicked")
        let vcGetStarted = storyboard?.instantiateViewController(withIdentifier: "newwork") as! NewWorkExperienceVC
        
        self.present(vcGetStarted, animated: true, completion: nil)
    }
}
