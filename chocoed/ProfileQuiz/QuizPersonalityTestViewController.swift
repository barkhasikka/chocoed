//
//  QuizPersonalityTestViewController.swift
//  chocoed
//
//  Created by Tejal on 03/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class QuizPersonalityTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuizExamDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadQuizExamDetails(){
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"3"] as Dictionary<String, String>
        
        
        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            print(response)
            let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
            let optionsList = response.object(forKey: "optionList") as? NSArray ?? []
            
            for question in questionsList {
                //                self.arrayBehaviouralQuestion.append(BehaviouralQuestion(question as! NSDictionary))
                //                DispatchQueue.main.async {
                //                    self.quetionLabel.text = self.arrayBehaviouralQuestion[self.currentQuestion].questionName
                //                }
            }
            
            //            for options in optionsList {
            //                self.arrayoption.append(BehaviouralOption(options as! NSDictionary))
            //            }
            //
            //            print("\(self.arrayBehaviouralQuestion)")
            //
            
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
