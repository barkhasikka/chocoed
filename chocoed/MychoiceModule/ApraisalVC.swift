//
//  ApraisalVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 21/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class ApraisalVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var lblTitle: UILabel!
    
    
    @IBOutlet var tableView: UITableView!
    
    var arrayCourseSubTopicList = [TopicListExam]()
    var activityUIView: ActivityIndicatorUIView!
    var topicid = ""
    var courseid = ""
    var calanderid = ""
    var tableRowPosition = -1;
    var navTitle = ""
    
    @IBAction func back_btn_clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topicid = choiceTopiceID
        self.courseid = choiceCourseID
        self.calanderid = choiceCalID
        self.navTitle = choiceTitle
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.lblTitle.text = navTitle
        
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadApiMyTopicStatusList()
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait
    }
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadApiMyTopicStatusList()
    {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientId = UserDefaults.standard.integer(forKey: "clientid")
        
        
        if self.arrayCourseSubTopicList.count > 0 {
            self.arrayCourseSubTopicList.removeAll()
        }
        
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)", "clientId": "\(clientId)","courseId" : "\(courseid)","topicId" : "\(topicid)","calenderId": "\(calanderid)"] as Dictionary<String, String>
        print(params)
        
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        
        MakeHttpPostRequest(url: getMyAllAssesments, params: params, completion: {(success, response) in
            print(response)
            let list = response.object(forKey: "list") as? NSArray ?? []
            for (index, courseSubTopics) in list.enumerated() {
                self.arrayCourseSubTopicList.append(TopicListExam(courseSubTopics as! NSDictionary))
            }
            print(self.arrayCourseSubTopicList.count)
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                self.tableView.reloadData()
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
        return arrayCourseSubTopicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApraisalCell") as! ApraisalCell
        
        
            
            cell.lblViews.text = ""
            cell.imageview.image = UIImage(named: "ic_assessment")
            cell.labelName.text = arrayCourseSubTopicList[indexPath.row].examName
            
            cell.labelStatus.text = arrayCourseSubTopicList[indexPath.row].examStatus
            if cell.labelStatus.text == "Completed"{
                cell.labelStatus.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }else if cell.labelStatus.text == "Inprogress" {
                cell.labelStatus.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }else{
                cell.labelStatus.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
            
       
        
        if arrayCourseSubTopicList[indexPath.row].examStatus == "Completed"
        {
            cell.blockView.isHidden = true
        }else{
            cell.blockView.isHidden = false
            
        }
        
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableRowPosition = indexPath.row
        
        
            print("exam")
            
            if arrayCourseSubTopicList[indexPath.row].examStatus == "Completed"{
                
                /*  let alert = GetAlertWithOKAction(message: "Dear \(USERDETAILS.firstName) You have already completed this assessment.")
                 self.present(alert, animated: true, completion: nil)
                 tableView.deselectRow(at: indexPath, animated: false)
                 */
                
                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "WevViewVC") as? WevViewVC {
                    vcNewSectionStarted.currentExamID=Int(arrayCourseSubTopicList[indexPath.row].examId)!
                    vcNewSectionStarted.fromType = "choice"
                    vcNewSectionStarted.calenderId = arrayCourseSubTopicList[indexPath.row].calenderId
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                }
                
            }else{
                
                let language = UserDefaults.standard.string(forKey: "currentlanguage")
                
                let alert = GetAlertWithOKAction(message:" \("DearKey".localizableString(loc: language!)) \(USERDETAILS.firstName),\("AssessmentYetToCompelteKey".localizableString(loc: language!)) ")
                self.present(alert, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: false)
                
            }
            
      
        
    }
    
    
    

}
