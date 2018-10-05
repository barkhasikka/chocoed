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
        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"-10"] as Dictionary<String, String>
        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            print(response)
            let currentTestID = response.object(forKey: "inProgressExamId") as? Int ?? 0
            print(currentTestID)
            DispatchQueue.main.async {
                switch currentTestID {
                case 1:
                    let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "behavioural") as! BehavioralViewController
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                    break
                case 2:
                    let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "psychometric") as! PsychometricTestViewController
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                    break
                case 3:
                    let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "personality") as! PersonalityTestViewController
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                    break
                default:
                    print("Blah Blha")
                }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
