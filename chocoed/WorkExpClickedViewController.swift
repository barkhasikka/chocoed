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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addnewWorkButton.backgroundColor = .clear
        addnewWorkButton.layer.cornerRadius = 10
        addnewWorkButton.layer.borderWidth = 1
        addnewWorkButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) -> Void in
            let jsonobject = response["info"] as? NSDictionary;
            let workExperiences = jsonobject?["userWorkExperienceList"] as? NSArray ?? []
            
            for experience in workExperiences {
                self.tableViewData.append(ExistingWorkList(experience as! NSDictionary))
            }
            DispatchQueue.main.async {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "existingworktvcell") as! ExistingWorkTableViewCell
        print(tableViewData)
        cell.companyNameLabel.text = tableViewData[indexPath.row].name
        cell.departmentLabel.text = tableViewData[indexPath.row].field
        cell.fromToDetailsLabel.text = tableViewData[indexPath.row].subField
        return cell
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
