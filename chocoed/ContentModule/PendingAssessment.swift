//
//  PendingAssessment.swift
//  chocoed
//
//  Created by Mahesh Bhople on 14/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class PendingAssessment:UIViewController ,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var pendingAssesmentlabel: UILabel!
    @IBAction func back_btn_clicked(_ sender: Any) {
        
        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
        self.present(v1, animated: true, completion: nil)
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    var arrayPendingExamList = [ExamList]()
    
    
    var calenderId = ""
    
    
    
    
    var arrayBehaviouralQuestion = [Question]()
    @IBOutlet var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        pendingAssesmentlabel.text = "PendingAssessmentKey".localizableString(loc: language!)
        
        self.loadSingleDayTopic()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPendingExamList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExamCell", for: indexPath) as! ExamCell
        cell.lblExam.text=arrayPendingExamList[indexPath.row].examName
        cell.mainView.layer.cornerRadius = 6
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.loadExam(calID :arrayPendingExamList[indexPath.row].calenderId, examID: arrayPendingExamList[indexPath.row].examId, examName: arrayPendingExamList[indexPath.row].examName)
    }
    
    func loadExam(calID : String,examID : String, examName : String){
        
        
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        var currentQuestionID: Int =  -1
        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(examID)","calendarId":"\(calID)"] as Dictionary<String, String>
        
        print(params)
        
        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            let currentTestID = response.object(forKey: "inProgressExamId") as? Int ?? 1
            print(currentTestID, "<<<=== current test id")
            print(response)
            let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
            self.arrayBehaviouralQuestion = [Question]()
            for (index, question) in questionsList.enumerated() {
                
                self.arrayBehaviouralQuestion.append(Question(question as! NSDictionary))
                if self.arrayBehaviouralQuestion[index].answerSubmitted == 0 && currentQuestionID == -1 {
                    currentQuestionID = index
                }
            }
            
            DispatchQueue.main.async {
                
                
                print(self.calenderId,"<<<< Calender ID >>>>>")
            
                
                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "quizb") as? QuizBahaviouralViewController {
                   
                    vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
                    vcNewSectionStarted.currentExamID = Int(examID)!
                    vcNewSectionStarted.currentQuestion = currentQuestionID
                    vcNewSectionStarted.examName = examName
                    vcNewSectionStarted.fromType = "pending"
                    vcNewSectionStarted.calenderId = calID
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
    
    /*********** TOPIC API **************/
    
    func loadSingleDayTopic()
    {
        
        let clientid = UserDefaults.standard.string(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        
        if(self.arrayPendingExamList.count > 0)
        {
            self.arrayPendingExamList.removeAll()
        }
        
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid!)","courseId":"\(currentCourseId)","date":"\(currentTopiceDate)"] as Dictionary<String, String>
        
        print(params)
        
        //activityUIView.isHidden = false
        //activityUIView.startAnimation()
        MakeHttpPostRequest(url: getTopicData, params: params, completion: {(success, response) -> Void in
            print(response)
            
            let exams = response.object(forKey: "pendingExamList") as? NSArray ?? []
            for exam in exams {
                self.arrayPendingExamList.append(ExamList( exam as! NSDictionary))
            }
            
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
               
                if(self.arrayPendingExamList.count == 0){
                    
                    let v1 = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
                    self.present(v1, animated: true, completion: nil)
                }
                
            }
            
           
            
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                // self.activityUIView.stopAnimation()
                
            }
        })
        
        
    }
    
    
    
}
