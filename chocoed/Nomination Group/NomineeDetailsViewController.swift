//
//  NomineeDetailsViewController.swift
//  chocoed
//
//  Created by Tejal on 07/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class NomineeDetailsViewController: UIViewController {

    
    @IBOutlet var lblMsg: UILabel!
    
    
    @IBOutlet weak var nomineeLearningLang: UILabel!
    @IBOutlet weak var nomineeOccupation: UILabel!
    @IBOutlet weak var nomineeGovtid: UILabel!
    @IBOutlet weak var nomineeAge: UILabel!
    @IBOutlet weak var nomineeMobile: UILabel!
    @IBOutlet weak var nomineeName: UILabel!
    @IBOutlet weak var TopicsCompletedNo: UILabel!
    @IBOutlet weak var completedTestNo: UILabel!
    @IBOutlet weak var imgeProfile: UIImageView!
    
    var tempDataNgoUser : getNgoUserDetails?
    override func viewDidLoad() {
        super.viewDidLoad()

        

        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
      
        
        
        LoadNomineeDetails()

        
        
    }

    @IBAction func backButtonAction(_ sender: Any) {
        
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: startVC)
        aObjNavi.navigationBar.barTintColor = UIColor.blue
        self.present(aObjNavi, animated: true, completion: nil)
        
    }
    
    func LoadNomineeDetails(){
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)"] as Dictionary<String, String>
        
        print(params)
        
        MakeHttpPostRequest(url: getNomineeDetails , params: params, completion: {(success, response) -> Void in
            print(response)
            
           DispatchQueue.main.async {
            
            let firstname = response.object(forKey: "firstName") as? String ?? ""
            let lastname = response.object(forKey: "lastName") as? String ?? ""

            let test = response.object(forKey: "testCompletedCount") as? Int ?? 0
            let topic = response.object(forKey: "topicCompletedCount") as? Int ?? 0
            
            let mobile = response.object(forKey: "mobileNumber") as? String ?? ""
            let age = response.object(forKey: "birthDate") as? String ?? ""
            let govID = response.object(forKey: "govId") as? String ?? ""
            let occupation = response.object(forKey: "occupation") as? String ?? ""
            let lang = response.object(forKey: "learningLanguage") as? String ?? ""
            
            let isUserVerified = response.object(forKey: "isUserVerified") as? Bool ?? false
            let profileImageUrl = response.object(forKey: "profileImageUrl") as? String ?? ""
            let isUserLogged = response.object(forKey: "isLoggedIn") as? Bool ?? false
            
        
            self.completedTestNo.text = String(test)
            self.TopicsCompletedNo.text = String(topic)
            self.nomineeName.text = firstname + " " + lastname
            self.nomineeMobile.text = mobile
            self.nomineeAge.text = age
            self.nomineeGovtid.text = govID
            self.nomineeOccupation.text = occupation
            self.nomineeLearningLang.text = lang
            
            let fileUrl = URL(string: profileImageUrl)
            self.imgeProfile.sd_setImage(with: fileUrl, completed: nil)
            self.imgeProfile.layer.cornerRadius = 42
            self.imgeProfile.layer.borderWidth = 2
            self.imgeProfile.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.imgeProfile.clipsToBounds = true
            
            if isUserVerified == true {
                
                if isUserLogged == false {
                    
                    
                    let language = UserDefaults.standard.string(forKey: "currentlanguage")
                    
                    self.lblMsg.text = "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName), \("userLoggedFirst".localizableString(loc: language!)) \(self.nomineeName.text!) \("userLoggedSecond".localizableString(loc: language!))"
                    
                    let alertView = UIAlertController(title: "AlertKey".localizableString(loc: language!), message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName), \("userLoggedFirst".localizableString(loc: language!)) \(self.nomineeName.text!) \("userLoggedSecond".localizableString(loc: language!))", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                    })
                    alertView.addAction(action)
                    self.present(alertView, animated: true, completion: nil)
                    
                    
                    
                }else{
                    
                    
                }
                
                
            }else{
                
                let language = UserDefaults.standard.string(forKey: "currentlanguage")
                self.lblMsg.text = "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName), \("nomiationApprovedMsgkey".localizableString(loc: language!))"
                
                let alertView = UIAlertController(title: "AlertKey".localizableString(loc: language!), message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName), \("nomiationApprovedMsgkey".localizableString(loc: language!))", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                alertView.addAction(action)
                self.present(alertView, animated: true, completion: nil)
                
            }
            
            
             
            }

            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
//                self.activityUIView.isHidden = true
//                self.activityUIView.stopAnimation()
            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
