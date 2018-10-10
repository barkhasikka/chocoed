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
    var activityUIView: ActivityIndicatorUIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        addnewWorkButton.backgroundColor = .clear
        addnewWorkButton.layer.cornerRadius = 10
        addnewWorkButton.layer.borderWidth = 1
        addnewWorkButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        let userID = UserDefaults.standard.integer(forKey: "userid")

        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) -> Void in
            let jsonobject = response["info"] as? NSDictionary;
            self.workExperiences = jsonobject?["userWorkExperienceList"] as? NSArray ?? []
            
            for experience in self.workExperiences {
                self.tableViewData.append(ExistingWorkList(experience as! NSDictionary))
            }
            DispatchQueue.main.async {
               
                self.workListTableView.reloadData()
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
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
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()

            }
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
//       let quizID = UserDefaults.standard.string(forKey: "quiztakenID")
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) in
            let jsonobject = response["info"] as? NSDictionary;
            let quizTaken =  jsonobject?.object(forKey:"quizTestGiven") as? Int ?? -1
            UserDefaults.standard.set(quizTaken, forKey: "quiztakenID")
            
            if quizTaken == 1{
                let dashboardvc = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                DispatchQueue.main.async {
                    let aObjNavi = UINavigationController(rootViewController: dashboardvc)
                    aObjNavi.navigationBar.barTintColor = UIColor.blue
                    self.present(aObjNavi, animated: true, completion: nil)
                    
                }
            } else{
                let profile = self.storyboard?.instantiateViewController(withIdentifier: "profileSuccess") as! ProfileSucessViewController
                DispatchQueue.main.async {
                    
                    self.present(profile, animated: true, completion: nil)
                    
                }
            }
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                
                self.activityUIView.stopAnimation()
            }


        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.stopAnimation()
                self.activityUIView.isHidden = true
            }
        })
    }
    
    
    @IBAction func addNewWorkAction(_ sender: Any) {
        print("add new work clicked")
        let vcGetStarted = storyboard?.instantiateViewController(withIdentifier: "newwork") as! NewWorkExperienceVC

        self.present(vcGetStarted, animated: true, completion: nil)
    }
}
