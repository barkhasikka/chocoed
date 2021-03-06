//
//  ExamComplitionScreenViewController.swift
//  chocoed
//
//  Created by Tejal on 05/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ExamComplitionScreenViewController: UIViewController {

    @IBOutlet weak var awesomeMessageLabel: UILabel!
    @IBOutlet weak var beginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        self.awesomeMessageLabel.text = "AwesomeToKnowMsgKey".localizableString(loc: language!)
        
        self.beginButton.setTitle("LetsGetChocoedButtonKey".localizableString(loc: language!), for: .normal)
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Group 4")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        ButtonBorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ButtonBorder() {
        beginButton.layer.cornerRadius = 15
        beginButton.clipsToBounds = true
        beginButton.layer.borderWidth = 1
        beginButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    override var shouldAutorotate: Bool{
        return false
    }

    @IBAction func letsBeginAction(_ sender: Any) {
        
        self.examComplete()
        
        let startVC = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: startVC)
        aObjNavi.navigationBar.barTintColor = UIColor.blue
        self.present(aObjNavi, animated: true, completion: nil)
        
        
        
    }
    
    
    func examComplete(){
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)"] as Dictionary<String, String>
        
        print(params)
        
        MakeHttpPostRequest(url: sendWelcomeNotification, params: params, completion: {(success, response) -> Void in
            DispatchQueue.main.async {
                print(response)
            }
            
        }, errorHandler: {(message) -> Void in
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
