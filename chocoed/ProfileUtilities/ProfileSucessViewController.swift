//
//  ProfileSucessViewController.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ProfileSucessViewController: UIViewController {

    @IBOutlet weak var letBeginButton: UIButton!
    var arrayBehaviouralQuestion = [Question]()
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.view.backgroundColor = UIColor(patternImage: UIImage(named: "perfect")!)

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Group 4")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        ButtonBorder()
        // Do any additional setup after loading the view.
    }

    @IBAction func letsBeginAction(_ sender: Any) {
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"1"] as Dictionary<String, String>
        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            let currentTestID = response.object(forKey: "inProgressExamId") as? Int ?? 1
            print(currentTestID, "<<<=== current test id")
            print(response)
            let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
            
            for question in questionsList {
                self.arrayBehaviouralQuestion.append(Question(question as! NSDictionary))
            }
            DispatchQueue.main.async {
                switch currentTestID {
                case 1:
                    DispatchQueue.main.async {
                        let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "behavioural") as! BehavioralViewController
                        vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
                        
//                        let aObjNavi = UINavigationController(rootViewController: vcNewSectionStarted)
//                        aObjNavi.navigationBar.barTintColor = UIColor.blue
                        self.present(vcNewSectionStarted, animated: true, completion: nil)
                    }
                    
                    break
                case 2:
                    let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "psychometric") as! PsychometricTestViewController
                    vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
//                    let aObjNavi = UINavigationController(rootViewController: vcNewSectionStarted)
//                    aObjNavi.navigationBar.barTintColor = UIColor.blue
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
//                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                    break
                case 3:
                    let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "personality") as! PersonalityTestViewController
                    vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
//                    let aObjNavi = UINavigationController(rootViewController: vcNewSectionStarted)
//                    aObjNavi.navigationBar.barTintColor = UIColor.blue
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                    break
                default:
                    print("Blah Blha")
                }
            }
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    func ButtonBorder() {
        letBeginButton.layer.cornerRadius = 20
        letBeginButton.clipsToBounds = true
        letBeginButton.layer.borderWidth = 1
        letBeginButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
