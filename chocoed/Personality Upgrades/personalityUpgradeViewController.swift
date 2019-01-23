//
//  personalityUpgradeViewController.swift
//  chocoed
//
//  Created by Tejal on 11/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class personalityUpgradeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var temp = ""
    var temp1 = ""
    
    var navTitle = ""
    
    @IBAction func back_btn_clicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBOutlet var lblTitle: UILabel!
    
    
    @IBOutlet weak var tabelviewTopicsList: UITableView!
    var arrayCourseTopicList = [CourseTopicList]()
    var activityUIView: ActivityIndicatorUIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        print(temp)
        
        self.lblTitle.text = self.navTitle
        
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        loadApiMyTopicList()

    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
   
 /*   @IBAction func backButton(_ sender: Any) {
        let vcChoice = storyboard?.instantiateViewController(withIdentifier: "mychoice") as? MyChoiceSkillsViewController
        let aObjNavi = UINavigationController(rootViewController: vcChoice!)
        aObjNavi.navigationBar.barTintColor = #colorLiteral(red: 0.08052674438, green: 0.186350315, blue: 0.8756543464, alpha: 1)
        aObjNavi.navigationBar.tintColor = UIColor.white
        aObjNavi.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.present(aObjNavi, animated: true, completion: nil)
        
        
        
    }
 */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func loadApiMyTopicList()
    {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientId = UserDefaults.standard.integer(forKey: "clientid")
        
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)", "clientId": "\(clientId)","courseId" : "\(temp)","calenderId" : "\(temp1)"] as Dictionary<String, String>
        print(params)
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        
        MakeHttpPostRequest(url: getMycourseTopicList, params: params, completion: {(success, response) in
            print(response)
            self.arrayCourseTopicList = [CourseTopicList]()
            let list = response.object(forKey: "list") as? NSArray ?? []
            for (index, courseTopics) in list.enumerated() {
                self.arrayCourseTopicList.append(CourseTopicList(courseTopics as! NSDictionary))
                

            }
            print(self.arrayCourseTopicList.count)
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            
                self.tabelviewTopicsList.reloadData()
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCourseTopicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personalitycell") as! PersonalityUpgradeTableViewCell
        cell.labelName.text = arrayCourseTopicList [indexPath.row].topicName
        
        cell.lblTopicCount.text = "(" + String(arrayCourseTopicList [indexPath.row].subTopicCount) + ") Sub Topics"
        
         cell.lblExamCount.text = "(" + String(arrayCourseTopicList [indexPath.row].testCount) + ") Tests"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        
        let vcnextDetails = self.storyboard?.instantiateViewController(withIdentifier: "TabVC") as? TabVC
        
        choiceTopiceID = arrayCourseTopicList[indexPath.row].topicId
        choiceCourseID = self.temp
        choiceCalID = self.temp1
        choiceTitle = arrayCourseTopicList [indexPath.row].topicName
       
        self.present(vcnextDetails!, animated: true, completion: nil)
        
        
    }
    

  
}
