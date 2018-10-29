//
//  WevViewVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 23/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class WevViewVC: UIViewController {
    
    
    @IBOutlet var webView: UIWebView!
    
    var activityUIView: ActivityIndicatorUIView!
    var currentExamID : Int = 0
    var fromType : String = ""
    var calenderId : String = ""



    
    @IBAction func proceed_btn_clicked(_ sender: UIButton) {
        
        
        if self.currentExamID > 3 {
           
        if self.fromType == "pending"{
            
            let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "PendingAssessment") as! PendingAssessment
            self.present(vcNewSectionStarted, animated: true, completion: nil)
            
        }else if self.fromType == "choice"{
            
            self.dismiss(animated: true, completion: nil)

            
        }else{
            
            let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
            self.present(vcNewSectionStarted, animated: true, completion: nil)
            
            }
            
        }else{
            
            let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "newscreen") as! ExamComplitionScreenViewController
            self.present(vcNewSectionStarted, animated: true, completion: nil)
                
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        self.loadExamDetails()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
 /* Load Exam */
    
    func loadExamDetails(){
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(self.currentExamID)","calendarId":"\(calenderId)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            print(response)
            
            
            let webdata = response.object(forKey: "result") as? NSString ?? ""
           
            
        
            DispatchQueue.main.async {
                
                self.webView.loadHTMLString(webdata as String, baseURL: nil)
                
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
