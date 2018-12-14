//
//  TopicsStatusViewController.swift
//  chocoed
//
//  Created by Tejal on 12/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class TopicsStatusViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableviewTopics: UITableView!
    var arrayCourseSubTopicList = [TopicList]()
    var activityUIView: ActivityIndicatorUIView!
    var topicid = ""
    var courseid = ""
    var calanderid = ""
    var tableRowPosition = -1;
    
    var navTitle = ""
    
    @IBAction func back_btn_clicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

        
    }
    

    @IBOutlet var lblTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.lblTitle.text = navTitle
        
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
       // loadApiMyTopicStatusList()
        
        
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
        
        MakeHttpPostRequest(url: getMySubTopics, params: params, completion: {(success, response) in
            print(response)
            self.arrayCourseSubTopicList = [TopicList]()
            let list = response.object(forKey: "list") as? NSArray ?? []
            for (index, courseSubTopics) in list.enumerated() {
                self.arrayCourseSubTopicList.append(TopicList(courseSubTopics as! NSDictionary))
            }
            print(self.arrayCourseSubTopicList.count)
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                self.tableviewTopics.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "topiccell") as! TopicStatusTableViewCell
        cell.labelName.text = arrayCourseSubTopicList[indexPath.row].subTopicName
        
        let topicID = String(arrayCourseSubTopicList[indexPath.row].topicId)
        
        if topicID == ""
        {
            
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

        }else{
            
            cell.lblViews.text = String(arrayCourseSubTopicList[indexPath.row].videoViewCount)+" views"
            cell.imageview.image = UIImage(named: "computer")
            cell.labelName.text = arrayCourseSubTopicList[indexPath.row].subTopicName
            
            cell.labelStatus.text = arrayCourseSubTopicList[indexPath.row].topicStatus
            if cell.labelStatus.text == "Completed"{
                cell.labelStatus.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }else if cell.labelStatus.text == "Inprogress" {
                cell.labelStatus.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }else{
                cell.labelStatus.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
            

        }
        
        if arrayCourseSubTopicList[indexPath.row].examStatus == "Completed" ||
           arrayCourseSubTopicList[indexPath.row].topicStatus == "Completed"
        {
            cell.blockView.isHidden = true
        }else{
            cell.blockView.isHidden = false

        }


        
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableRowPosition = indexPath.row

        
        let topicid = String(arrayCourseSubTopicList[indexPath.row].topicId)
       
        if topicid == "" {
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
            
        }else{
            
            let language = UserDefaults.standard.string(forKey: "currentlanguage")
            
            print("video")
            if arrayCourseSubTopicList[indexPath.row].videoViewCount >=  arrayCourseSubTopicList[indexPath.row].videoViewLimit{
                
                let alertcontrol = UIAlertController(title: "".localizableString(loc: language!), message: " \("DearKey".localizableString(loc: language!)) \(USERDETAILS.firstName), \("awaitedAssessmentKey".localizableString(loc: language!))", preferredStyle: .alert)
                let alertaction = UIAlertAction(title: "okAlertKey".localizableString(loc: language!), style: .default, handler: nil)
                alertcontrol.addAction(alertaction)
                
                self.present(alertcontrol, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: false)
                
                
                
            }else if arrayCourseSubTopicList[indexPath.row].videoViewCount > 0 {
            
                self.revwindVideo()
                tableView.deselectRow(at: indexPath, animated: false)
  
            }else {
                
                let alert = GetAlertWithOKAction(message: "\("DearKey".localizableString(loc: language!) ) \(USERDETAILS.firstName), \("yetToLearnKey".localizableString(loc: language!))")
                self.present(alert, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: false)
                
            }
            
            
        }

    }
    
    
    
    func revwindVideo() {
        
        let userAppLang1 = UserDefaults.standard.string(forKey: "Language2")
        let userAppLang2 = UserDefaults.standard.string(forKey: "Language3")
        
        
        if userAppLang1 == userAppLang2 {
            
            // same language
            
            currentSelectedLang = userAppLang1!
            
            // directly play vide
            
            if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC {
                vcNewSectionStarted.arrayTopic = self.arrayCourseSubTopicList
                vcNewSectionStarted.currentPosition = self.tableRowPosition
                vcNewSectionStarted.courseId = courseid
                vcNewSectionStarted.fromType = "choice"
                vcNewSectionStarted.selectedTopicId = self.arrayCourseSubTopicList[self.tableRowPosition].topicId
                self.present(vcNewSectionStarted, animated: true, completion: nil)
            }
            
            
          
            
        }else{
            
            let language = UserDefaults.standard.string(forKey: "currentlanguage")
            
            let alertView = UIAlertController(title: "\("AwesomeCommitmentKey".localizableString(loc: language!))", message: "\("watchAgainInLangKey".localizableString(loc: language!))", preferredStyle: .alert)
            let action = UIAlertAction(title: "\("cancelKey".localizableString(loc: language!))", style: .default, handler: { (alert) in
                
            })
            alertView.addAction(action)
            
            let actionSure = UIAlertAction(title: userAppLang1, style: .default, handler: { (alert) in
                
                currentSelectedLang = userAppLang1!
                
                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC {
                    vcNewSectionStarted.arrayTopic = self.arrayCourseSubTopicList
                    vcNewSectionStarted.currentPosition = self.tableRowPosition
                    vcNewSectionStarted.courseId = self.courseid
                    vcNewSectionStarted.fromType = "choice"
                    vcNewSectionStarted.selectedTopicId = self.arrayCourseSubTopicList[self.tableRowPosition].topicId
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                }
                
               // play video
                
            })
            alertView.addAction(actionSure)
            
            let actionSure1 = UIAlertAction(title: userAppLang2, style: .default, handler: { (alert) in
                
                currentSelectedLang = userAppLang2!
                
                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC {
                    vcNewSectionStarted.arrayTopic = self.arrayCourseSubTopicList
                    vcNewSectionStarted.currentPosition = self.tableRowPosition
                    vcNewSectionStarted.courseId = self.courseid
                    vcNewSectionStarted.fromType = "choice"
                    vcNewSectionStarted.selectedTopicId = self.arrayCourseSubTopicList[self.tableRowPosition].topicId
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                }
                
                // play video
                
               
                
            })
            alertView.addAction(actionSure1)
            
            self.present(alertView, animated: true, completion: nil)
            
        }
    }
    
    
    
    
}
