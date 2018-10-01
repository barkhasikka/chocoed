//
//  QuizBahaviouralViewController.swift
//  chocoed
//
//  Created by Tejal on 01/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class QuizBahaviouralViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuizExamDetails()
        loadSaveExamQuestionAnswer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadQuizExamDetails(){
    let clientID = UserDefaults.standard.integer(forKey: "clientid")
    let userid = UserDefaults.standard.string(forKey: "userid")
    
    let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"-10"] as Dictionary<String, String>

    print(params)
    MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
    print(response)
    ////            let language = response.object(forKey: "appList") as? NSArray ?? []
    ////
    ////            for languages in language {
    ////                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
    //            }
    
    })
}
    func loadSaveExamQuestionAnswer(){
    let clientID = UserDefaults.standard.integer(forKey: "clientid")
    let userid = UserDefaults.standard.string(forKey: "userid")
    
        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Android","userId":"\(userid!)","clienId":"\(clientID)","examId":"0","questionId":"0","selectedAns":"","selectedAnsId":"","startTime":"","endTime":""] as Dictionary<String, String>
    print(params)
    MakeHttpPostRequest(url: saveUserExamQuestionAnswer , params: params, completion: {(success, response) -> Void in
        print(response)
        ////            let language = response.object(forKey: "appList") as? NSArray ?? []
        ////
        ////            for languages in language {
        ////                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
        //            }
        
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
