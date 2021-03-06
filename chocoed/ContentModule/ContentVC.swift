//
//  ContentVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 14/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ContentVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    
    @IBOutlet var popupView: UIView!
    @IBAction func laterBtn_clicked(_ sender: Any) {
        self.popupView.isHidden = true
    }
    
    @IBAction func upgrade_clicked(_ sender: Any) {
        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        self.present(v1, animated: true, completion: nil)
    }

    @IBOutlet weak var imageViewView: UIView!
    @IBOutlet var tblView: UITableView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnPrev: UIButton!
    @IBOutlet var lblActiveDate: UILabel!
    
    @IBOutlet var lblEmpty: UILabel!
    
    @IBOutlet weak var myplanlabel: UILabel!
    
    @IBOutlet var imgCourse: UIImageView!
    
    @IBOutlet var lblCourseTitle: UILabel!
    
    var previousDayStatus = -1
    var courseId = ""
    var courseName = ""
    var courseImage = ""
    var toDate = ""
    var fromdate = ""
    var currentPositionDate = ""
    
    var selectedDate =  ""
    
    var isMatch = false
    var currentPositon = -1
    var tableRowPosition = -1;
    var datesBetweenArray = [Date]()
    var arrayTopic = [TopicList]()
    var arrayPendingExamList = [ExamList]()
    var arrayBehaviouralQuestion = [Question]()
    var activityUIView: ActivityIndicatorUIView!
    
    var thirdDayDate = Date()
    var isThirdOrGreater = false
    var isPopupShow : Int = 0


    
    
    @IBAction func back_btn_clicked(_ sender: Any) {
        
        let startVC = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: startVC)
        aObjNavi.navigationBar.barTintColor = UIColor.blue
        self.present(aObjNavi, animated: true, completion: nil)
        
    }
    
    @IBAction func prev_btn_clicked(_ sender: Any) {
        
        if self.currentPositon == 0 {
            self.btnPrev.isHidden = true
            return
        }
        self.btnNext.isHidden = false
        self.currentPositon =  self.currentPositon - 1 ;
        self.loadSingleDayTopic()
        
    }
    @IBAction func next_btn_clicked(_ sender: Any) {
        
        if self.currentPositon > datesBetweenArray.count{
            self.btnNext.isHidden = true
            return
        }
        
        self.currentPositon =  self.currentPositon + 1 ;
        
        if self.currentPositon == datesBetweenArray.count{
            self.btnNext.isHidden = true
            return
        }
        
        self.btnPrev.isHidden = false
        self.loadSingleDayTopic()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
       /* if (self.isMovingFromParentViewController) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        } */
        
       
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
 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.popupView.isHidden = true
        self.popupView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        print(UserDefaults.standard.string(forKey: "Language1")!)
        print(UserDefaults.standard.string(forKey: "Language2")!)
        print(UserDefaults.standard.string(forKey: "Language3")!)
        
        let backgroundImage = UIImageView(frame: self.imageViewView.bounds)
        backgroundImage.image = UIImage(named: "dashboard_header")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.imageViewView.insertSubview(backgroundImage, at: 0)
        
        self.isPopupShow = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        myplanlabel.text = "MyPlanKey".localizableString(loc: language!)
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        
        
        if isLoadExamFromVideo == "1"
        {
            let language = UserDefaults.standard.string(forKey: "currentlanguage")
            

            
            let alertView = UIAlertController(title: "AlertKey".localizableString(loc: language!), message: "alertAssessment".localizableString(loc: language!), preferredStyle: .alert)
            
            let action = UIAlertAction(title: "alertNotNow".localizableString(loc: language!), style: .default, handler: { (alert) in
                
                // closed player
                
                isLoadExamFromVideo = ""
                isLoadCalendarId = ""
                isLoadExamId = ""
                isLoadExamName = ""
                self.loadCourseData();

                
            })
            alertView.addAction(action)
            
            let actionSure = UIAlertAction(title: "alertYes".localizableString(loc: language!), style: .default, handler: { (alert) in
                
                self.courseId = currentCourseId
                self.selectedDate = currentTopiceDate
            
                self.loadExam(calendarid: isLoadCalendarId,examID: isLoadExamId, examName: isLoadExamName)
                
                isLoadExamFromVideo = ""
                
                
                
            })
            alertView.addAction(actionSure)
            self.present(alertView, animated: true, completion: nil)
            
           
            
        }else{
          
         loadCourseData();

        }
        
    }
    
    private func showUpgradePopup(){
        
        self.popupView.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTopic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        
        
        let userType = Int(UserDefaults.standard.string(forKey: "userType")!)
        if userType == 2{
            if self.isThirdOrGreater == true {
                self.showUpgradePopup()
            }
        }
        
        var showLockLayout = true
        
  
        if self.previousDayStatus == 99 || self.previousDayStatus == 2 {
            
            if indexPath.row == 0 {
                
                showLockLayout = false
                
                
            }else{
                
                var index = indexPath.row - 1
                
                while index >= 0 {
                    
            if self.arrayTopic[index].topicId != "0"{

                    
                    if self.arrayTopic[index].videoViewCount > 0 {
                        
                        showLockLayout = false
                        
                        
                    }else{
                        
                        showLockLayout = true
                    }
                
                break
                
            }else{
                
                showLockLayout = false

                
            }
                
                    
                    index = index - 1
                }
                
               
            }
            
            
        }
        
        if showLockLayout == true{
            
            cell.blockView.isHidden = false
            self.arrayTopic[indexPath.row].isBlock = true
            
            
        }else{
            
            cell.blockView.isHidden = true
            self.arrayTopic[indexPath.row].isBlock = false
            
        }
        
        
        if arrayTopic[indexPath.row].topicId == "0"
        {
            
            cell.videoView.isHidden = true
            cell.examView.isHidden = false
            
        }else{
            
            cell.videoView.isHidden = false
            cell.examView.isHidden = true
            
            if arrayTopic[indexPath.row].topicStatus != "Pending"{

                print("<<<<<<<>>>>>>>>>>",arrayTopic[indexPath.row].topicStatus)
                let userType = Int(UserDefaults.standard.string(forKey: "userType")!)
                if userType == 2{
                    self.showUpgradePopup()
                }
            }
        }
        
        
        cell.examView.layer.cornerRadius = 6
        cell.videoView.layer.cornerRadius = 6
        cell.blockView.layer.cornerRadius = 6
        
        
        cell.lblTitle.text=arrayTopic[indexPath.row].topicName
        cell.lblDesc.text=arrayTopic[indexPath.row].subTopicName
        cell.lblTopicStatus.text=arrayTopic[indexPath.row].topicStatus
        cell.lblCount.text="Views:"+String(arrayTopic[indexPath.row].videoViewCount)
        cell.lblExam.text="Assessment"
        
        if arrayTopic[indexPath.row].topicStatus == "Pending"{
            
            cell.lblTopicStatus.textColor = UIColor.red
            cell.lblExamStatus.textColor = UIColor.red
            
        }else{
            cell.lblTopicStatus.textColor = UIColor.blue
            cell.lblExamStatus.textColor = UIColor.blue
            
        }
        
        
        
        
        cell.lblExamStatus.text=arrayTopic[indexPath.row].examStatus
        cell.lblExamDetails.text=arrayTopic[indexPath.row].examName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
        
        self.tableRowPosition = indexPath.row
        let topicid = arrayTopic[indexPath.row].topicId
        
        if arrayTopic[indexPath.row].isBlock == true{
            
            let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
            let alertcontrol = UIAlertController(title: "alertInterestingVideos".localizableString(loc: language!), message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName) \("alertVideos".localizableString(loc: language!))", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OkKey".localizableString(loc: language!), style: .default, handler: nil)
            alertcontrol.addAction(alertaction)
            
            self.present(alertcontrol, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: false)

                
          
            
        }else{
            
            print(topicid)
            
            let userType = Int(UserDefaults.standard.string(forKey: "userType")!)
            if userType == 2{
                if self.isThirdOrGreater == true {
                    self.showUpgradePopup()
                    return
                }
            }
            
            
            if self.previousDayStatus == 2 {
                
                 let language = UserDefaults.standard.string(forKey: "currentlanguage")
                let alertView = UIAlertController(title: "alertCompletedAssessments".localizableString(loc: language!), message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName), \("assessmentCompletionKey".localizableString(loc: language!)) ", preferredStyle: .alert)
                
                
                let action = UIAlertAction(title: "alertNotNow".localizableString(loc: language!), style: .default, handler: { (alert) in
                    
                    //  if indexPath.row == 0{
                    
                    let cell = tableView.cellForRow(at: indexPath) as! ContentCell
                    cell.blockView.isHidden = true
                    self.arrayTopic[indexPath.row].isBlock = false
                    self.loadNotNowVideo()
                    
                    
                    //  }
                    
                    
                })
                alertView.addAction(action)
                
                let actionSure = UIAlertAction(title: "alertYes".localizableString(loc: language!), style: .default, handler: { (alert) in
                    // go to pending list view
                    
                    
                        currentCourseId = self.courseId
                        currentTopiceDate = self.selectedDate
                        
                        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "PendingAssessment") as? PendingAssessment {
                            vcNewSectionStarted.calenderId = self.arrayTopic[indexPath.row].calenderId
                            self.present(vcNewSectionStarted, animated: true, completion: nil)
                       
                    }
                    
                    
                })
                alertView.addAction(actionSure)
                self.present(alertView, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: false)

                
                
            }else
                
                if topicid == "0"{
                    
                    
                    if arrayTopic[indexPath.row].examStatus == "Completed"{
                        
                        
                        
                        
                        
                        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "WevViewVC") as? WevViewVC {
                            
                            currentCourseId = self.courseId
                            currentTopiceDate = self.selectedDate
                        
             vcNewSectionStarted.currentExamID=Int(arrayTopic[indexPath.row].examId)!
                            vcNewSectionStarted.fromType = "content"
                            vcNewSectionStarted.calenderId = arrayTopic[indexPath.row].calenderId
                            self.present(vcNewSectionStarted, animated: true, completion: nil)
                            
                        }
                        

                        
                        
                    }else{
                        
                        self.loadExam(calendarid: arrayTopic[indexPath.row].calenderId,examID: arrayTopic[indexPath.row].examId, examName: arrayTopic[indexPath.row].examName)
                        
                    }
                    
                    
                    
                }else{
                    
                    
                   
                    let language = UserDefaults.standard.string(forKey: "currentlanguage")
                    
                    if arrayTopic[indexPath.row].videoViewCount >=  arrayTopic[indexPath.row].videoViewLimit{
                        
                        let alertcontrol = UIAlertController(title: "LetsGetChocoedButtonKey".localizableString(loc: language!), message: " \("DearKey".localizableString(loc: language!)) \(USERDETAILS.firstName),\("IntrestingVideoKey".localizableString(loc: language!))", preferredStyle: .alert)
                        let alertaction = UIAlertAction(title: "okAlertKey".localizableString(loc: language!), style: .default, handler: nil)
                        alertcontrol.addAction(alertaction)
                        
                            self.present(alertcontrol, animated: true, completion: nil)
                            tableView.deselectRow(at: indexPath, animated: false)
 
 
                       
                        
                        
                    }else if arrayTopic[indexPath.row].videoViewCount > 0 {
                        
                        // for revise language
                        
                      
                        self.revwindVideo()
                        tableView.deselectRow(at: indexPath, animated: false)
                        
                        
                        
                    }else {
                        
                        currentTopiceDate = self.selectedDate
                        currentSelectedLang = UserDefaults.standard.string(forKey: "Language2")!


                        
                        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC {
                            vcNewSectionStarted.arrayTopic = self.arrayTopic
                            vcNewSectionStarted.currentPosition = 0
                            vcNewSectionStarted.courseId = self.courseId
                            vcNewSectionStarted.selectedTopicId = self.arrayTopic[indexPath.row].topicId
                            
                            self.present(vcNewSectionStarted, animated: true, completion: nil)
                        }
                        
                    }
                    
                    
            }
            
        }
        
        
    }
    
    
    func loadNotNowVideo(){
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        if arrayTopic[self.tableRowPosition].topicId == "0" {
            
            
            if arrayTopic[self.tableRowPosition].examStatus == "Completed"{
                
            let alert = GetAlertWithOKAction(message: " \("DearKey".localizableString(loc: language!)) \(USERDETAILS.firstName) \("AssesmentCompleteKey".localizableString(loc: language!))" )
                
                    self.present(alert, animated: true, completion: nil)
            }else{
                
                self.loadExam(calendarid: arrayTopic[self.tableRowPosition].calenderId,examID: arrayTopic[self.tableRowPosition].examId, examName: arrayTopic[self.tableRowPosition].examName)
            }
            
            
        }else{
            
            
            if arrayTopic[self.tableRowPosition].videoViewCount > 0 {
                
                // for replay language
                self.revwindVideo()
                
            }else {
                
                currentTopiceDate = self.selectedDate
                currentSelectedLang = UserDefaults.standard.string(forKey: "Language2")!

                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC {
                    vcNewSectionStarted.arrayTopic = self.arrayTopic
                    vcNewSectionStarted.currentPosition = 0
                    vcNewSectionStarted.courseId = self.courseId
                    vcNewSectionStarted.selectedTopicId = self.arrayTopic[self.tableRowPosition].topicId
                    
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    
    func revwindVideo() {
        
        let userAppLang1 = UserDefaults.standard.string(forKey: "Language2")!
        let userAppLang2 = UserDefaults.standard.string(forKey: "Language3")
        
        
        if userAppLang1 == userAppLang2 {
            
            // same language
            
            currentTopiceDate = self.selectedDate
            currentSelectedLang = UserDefaults.standard.string(forKey: "Language2")!
            
            
            
            if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC {
                vcNewSectionStarted.arrayTopic = self.arrayTopic
                vcNewSectionStarted.currentPosition = 0
                vcNewSectionStarted.courseId = self.courseId
                vcNewSectionStarted.selectedTopicId = self.arrayTopic[self.tableRowPosition].topicId
                
                self.present(vcNewSectionStarted, animated: true, completion: nil)
            }
            
        }else{
            
            let language = UserDefaults.standard.string(forKey: "currentlanguage")
            let alertView = UIAlertController(title: "AwesomeCommitmentKey".localizableString(loc: language! ), message: "watchAgainInLangKey".localizableString(loc: language!), preferredStyle: .alert)
            let action = UIAlertAction(title: "NotNowKey".localizableString(loc: language!), style: .default, handler: { (alert) in
                
            })
            alertView.addAction(action)
            
            let actionSure = UIAlertAction(title: userAppLang1, style: .default, handler: { (alert) in
                
                currentTopiceDate = self.selectedDate
                currentSelectedLang = userAppLang1
                
                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC {
                    vcNewSectionStarted.arrayTopic = self.arrayTopic
                    vcNewSectionStarted.currentPosition = 0
                    vcNewSectionStarted.courseId = self.courseId
                     vcNewSectionStarted.selectedTopicId = self.arrayTopic[self.tableRowPosition].topicId
                    
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                }
                
                
            })
            alertView.addAction(actionSure)
            
            let actionSure1 = UIAlertAction(title: userAppLang2, style: .default, handler: { (alert) in
                
                currentTopiceDate = self.selectedDate
                currentSelectedLang = userAppLang2!
                
                
                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC {
                    vcNewSectionStarted.arrayTopic = self.arrayTopic
                    vcNewSectionStarted.currentPosition = 0
                    vcNewSectionStarted.courseId = self.courseId
                     vcNewSectionStarted.selectedTopicId = self.arrayTopic[self.tableRowPosition].topicId
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                }
                
                
            })
            alertView.addAction(actionSure1)
            
            self.present(alertView, animated: true, completion: nil)
            
        }
    }
    
    
    
    /* <=============== API Calling ==================> */
    
    
    /* : Get Course List from API */
    
    func loadCourseData()
    {
        
        let clientid = UserDefaults.standard.string(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid!)"] as Dictionary<String, String>
        //  activityUIView.isHidden = false
        //  activityUIView.startAnimation()
        print(params)
        MakeHttpPostRequest(url: getCourseData, params: params, completion: {(success, response) -> Void in
            print(response)
            // let language = response.object(forKey: "appList") as? NSArray ?? []
            
            self.courseId = response.object(forKey: "courseId") as? String ?? ""
            self.courseName = response.object(forKey: "courseName") as? String ?? ""
            self.courseImage = response.object(forKey: "ciurseImageUrl") as? String ?? ""
            self.fromdate = response.object(forKey: "fromDate") as? String ?? ""
            self.toDate = response.object(forKey: "toDate") as? String ?? ""
            self.currentPositionDate = response.object(forKey: "currentPositionDate") as? String ?? ""

            
            
            DispatchQueue.main.async {
                
                self.lblCourseTitle.text = self.courseName
                
                let fileUrl = URL(string: self.courseImage)
                if fileUrl != nil {
                    if let data = try? Data(contentsOf: fileUrl!) {
                        if let image = UIImage(data: data) {
                            self.imgCourse.image = image
                        }
                    }
                   /* self.imgCourse.layer.borderWidth = 1.0
                    self.imgCourse.layer.masksToBounds = false
                    self.imgCourse.layer.borderColor = UIColor.darkGray.cgColor
                    self.imgCourse.layer.cornerRadius =  self.imgCourse.frame.width / 2
                    self.imgCourse.clipsToBounds = true
                    self.imgCourse.contentMode = .center */
                }
                
            }
            
            
            let finalToDate = self.getDateFromString(date: self.toDate)
            let finalFromDate = self.getDateFromString(date: self.fromdate)
            
            
            if(self.datesBetweenArray.count > 0)
            {
                self.datesBetweenArray.removeAll()
            }
            
            
            self.datesBetweenArray = self.generateDatesArrayBetweenTwoDates(startDate:finalFromDate , endDate: finalToDate)
            
            
            let userType = Int(UserDefaults.standard.string(forKey: "userType")!)
            if userType == 2{
                if self.datesBetweenArray.count >= 3 {
                    self.thirdDayDate = self.datesBetweenArray[2]
                }
                
            }

            
          
            
            
            
            for adate in self.datesBetweenArray{
             
                
                let predate = self.getStringFromDate(date:adate)
                
                
                
                if currentTopiceDate != "" {
                    
                    if currentTopiceDate == predate{
                        
                        print("Pre Selected Date")
                        self.isMatch = true
                        
                        self.currentPositon = self.datesBetweenArray.index(of: adate)!
                        self.loadSingleDayTopic()
                        
                        break
                        
                    }else{
                        
                        print("not match")
                        self.isMatch = false
                    }
                    
                    
                }else{
                    
                    if self.currentPositionDate == predate{
                        
                        print("Current Topic")
                        self.isMatch = true
                        
                        self.currentPositon = self.datesBetweenArray.index(of: adate)!
                        self.loadSingleDayTopic()
                        
                        break
                        
                    }else{
                        
                        print("not match")
                        self.isMatch = false
                    }
                }
                
            }
            
            
            if self.isMatch == false{
                DispatchQueue.main.async {
                    self.btnPrev.isHidden = true
                }
                self.currentPositon = 0;
                self.loadSingleDayTopic()
            }
            
            
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                // self.activityUIView.stopAnimation()
            }
        })
        
    }
    
    /* : Get Course Topic List from API */
    
    func loadSingleDayTopic()
    {
        
        if self.datesBetweenArray[self.currentPositon] >= self.thirdDayDate{
            self.isThirdOrGreater = true
        }else{
            self.isThirdOrGreater = false
        }
        
        let date = self.getStringFromDate(date: self.datesBetweenArray[self.currentPositon])
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM"
        let date1 = formatter.string(from:  self.datesBetweenArray[self.currentPositon])
        
        DispatchQueue.main.async {
            self.selectedDate = date
            self.lblActiveDate.text = date1
            self.activityUIView.isHidden = false
            self.activityUIView.startAnimation()
            
        }
        
        if(self.arrayTopic.count > 0)
        {
            self.arrayTopic.removeAll()
        }
        
        if(self.arrayPendingExamList.count > 0)
        {
            self.arrayPendingExamList.removeAll()
        }
        
        
        let clientid = UserDefaults.standard.string(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid!)","courseId":"\(self.courseId)","date":"\(date)"] as Dictionary<String, String>
        
        print(params)
        
        
        
        MakeHttpPostRequest(url: getTopicData, params: params, completion: {(success, response) -> Void in
            
            
            print(response)
            let topic = response.object(forKey: "list") as? NSArray ?? []
            
            self.previousDayStatus = response.object(forKey: "previousDayStatus") as? Int ?? -1
            
            for topics in topic {
                self.arrayTopic.append(TopicList( topics as! NSDictionary))
                
            }
            
            let exams = response.object(forKey: "pendingExamList") as? NSArray ?? []
            for exam in exams {
                self.arrayPendingExamList.append(ExamList( exam as! NSDictionary))
            }
            
            
            DispatchQueue.main.async {
                
                self.tblView.reloadData()
                  self.activityUIView.isHidden = true
                  self.activityUIView.stopAnimation()
                
                if self.arrayTopic.count > 0 {
                    self.lblEmpty.isHidden = true
                }else{
                    self.lblEmpty.isHidden = false
                }
                
              
              
            }
            
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
        })
        
        
    }
    
    /* : Load Exam Data API */
    
    
    func loadExam(calendarid : String, examID : String, examName : String){
        
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        var currentQuestionID: Int =  -1
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(examID)","calendarId":"\(calendarid)"] as Dictionary<String, String>
        
        print(params)
        
        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            
            
            let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
            self.arrayBehaviouralQuestion = [Question]()
            for (index, question) in questionsList.enumerated() {
                self.arrayBehaviouralQuestion.append(Question(question as! NSDictionary))
                if self.arrayBehaviouralQuestion[index].answerSubmitted == 0 && currentQuestionID == -1 {
                    currentQuestionID = index
                }
            }
            
            DispatchQueue.main.async {
                
                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "quizb") as? QuizBahaviouralViewController {
                    
                    currentCourseId = self.courseId
                    currentTopiceDate = self.selectedDate
                    
                    print(currentCourseId)
                    print(currentTopiceDate)

                    
                    vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
                    vcNewSectionStarted.currentExamID = Int(examID)!
                    vcNewSectionStarted.currentQuestion = currentQuestionID
                    vcNewSectionStarted.examName = examName
                    vcNewSectionStarted.fromType = "content"
                    vcNewSectionStarted.calenderId = calendarid
                    let aObjNavi = UINavigationController(rootViewController: vcNewSectionStarted)
                    aObjNavi.navigationBar.barTintColor = UIColor.blue
                    self.present(aObjNavi, animated: true, completion: nil)
                    
                }
                
            }
            
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    
    /* : Get Date from String */
    
    func getDateFromString(date : String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        return dateFormatter.date(from: date)!
    }
    
    /* : Get String from Date */
    
    func getStringFromDate(date : Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    
    /* : Get Dates between Two Dates */
    
    
    func generateDatesArrayBetweenTwoDates(startDate: Date , endDate:Date) ->[Date]
    {
        var datesArray: [Date] =  [Date]()
        var startDate = startDate
        let calendar = Calendar.current
        
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        while startDate <= endDate {
            datesArray.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
        
        return datesArray
    }

}
  
