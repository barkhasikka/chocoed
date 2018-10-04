//
//  WorkExpClickedViewController.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class WorkExpClickedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var workListTableView: UITableView!
    @IBOutlet weak var addnewWorkButton: UIButton!
    var tableViewData =  [ExistingWorkList]()
    var workExperiences: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addnewWorkButton.backgroundColor = .clear
        addnewWorkButton.layer.cornerRadius = 10
        addnewWorkButton.layer.borderWidth = 1
        addnewWorkButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)

        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) -> Void in
            let jsonobject = response["info"] as? NSDictionary;
            self.workExperiences = jsonobject?["userWorkExperienceList"] as? NSArray ?? []
            
            for experience in self.workExperiences {
                self.tableViewData.append(ExistingWorkList(experience as! NSDictionary))
            }
            DispatchQueue.main.async {
                myActivityIndicator.stopAnimating()
                myActivityIndicator.hidesWhenStopped = true
                self.workListTableView.reloadData()
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
    

    @IBAction func PreviousButtonAction(_ sender: Any) {
        
        let vcprev = storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.present(vcprev, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "existingworktvcell") as! ExistingWorkTableViewCell
        print(tableViewData)
        cell.companyNameLabel.text = tableViewData[indexPath.row].name
        cell.departmentLabel.text = tableViewData[indexPath.row].field
        cell.fromToDetailsLabel.text = tableViewData[indexPath.row].subField
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = WorkFields(self.workExperiences[indexPath.row] as! NSDictionary)
        print(data, "converted data is here")
        let vcGetStarted = storyboard?.instantiateViewController(withIdentifier: "newwork") as! NewWorkExperienceVC
        vcGetStarted.selectedWorkExperience = data
        self.present(vcGetStarted, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
    }
    
    
    @IBAction func addNewWorkAction(_ sender: Any) {
        print("add new work clicked")
        let vcGetStarted = storyboard?.instantiateViewController(withIdentifier: "newwork") as! NewWorkExperienceVC

        self.present(vcGetStarted, animated: true, completion: nil)
    }
}
