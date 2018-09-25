//
//  SignUpViewController.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    var tableViewData =  [ExistingEducationList]()

    @IBOutlet weak var educationDetailsTableView: UITableView!
    @IBOutlet weak var viewEdu: UIView!
    @IBOutlet weak var addeducationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewEdu.isHidden = false
        addeducationButton.setTitle("Add New Education", for: .normal)
        addeducationButton.backgroundColor = .clear
        addeducationButton.layer.cornerRadius = 20
        addeducationButton.layer.borderWidth = 1
        addeducationButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        
        let params = ["userId": "\(59)",  "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) -> Void in
            let jsonobject = response["info"] as? NSDictionary;
            let workExperiences = jsonobject?["userEducationList"] as? NSArray ?? []
            
            for experience in workExperiences {
                self.tableViewData.append(ExistingEducationList(experience as! NSDictionary))
            }
            DispatchQueue.main.async {
                self.educationDetailsTableView.reloadData()
            }
            
            //            if let json = try JSONSerialization.jsonObject(with: jsonobject, options: []) as? [String: AnyObject] {
            //                let info = json as? NSDictionary
            //                let workExperiences = info.object(forKey: "userEducationList") as? NSDictionary ?? [:]
            //                print(workExperiences,"PLEASE CHECK THIS VALUE")
            //                for experience in workExperiences {
            //                    //                self.tableViewData.append(ExistingWorkList(experience as! NSDictionary))
            //                }
            //            }
            
            //            print(response.object(forKey: "industrySectorList"), "industry sector list")
            //            response.object(forKey: "functionalDepartmentList")
        })
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
