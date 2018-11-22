//
//  ViewControllerMenubar2DonarViewController.swift
//  chocoed
//
//  Created by Tejal on 05/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ViewControllerMenubar: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var profileGradiantView: UIView!
    @IBOutlet weak var buttonEmail: UIButton!
    @IBOutlet weak var tabGestureView: UIView!
    @IBOutlet weak var labelUserNAme: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    
    var userImageLoaded : UIImage? = nil
    var languageUIView: LanguageUIView!
    var count = 0
    var availableString = ""

    
//    @IBOutlet weak var tabelviewLanguage: UITableView!
//    @IBOutlet weak var languageview: UIView!
    var arraymenu = ["My Talks","My Thoughts","My Progress","My Profile",//"Select Preferred Language",
        "Log out"]
    let cousesImages = [UIImage(named:"chat"),UIImage(named: "discussion_room"), UIImage(named: "myprocess_improvement"), UIImage(named: "icons_user"), UIImage(named: "icon_logout")]
    
        override func viewDidLoad() {
            super.viewDidLoad()
        
            let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.profileGradiantView.bounds.width, height: self.profileGradiantView.bounds.height))
            backgroundImage.image = UIImage(named: "Profile_page Gradient")
            backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
            self.profileGradiantView.insertSubview(backgroundImage, at: 0 )

            
            
        
        labelUserNAme.text = USERDETAILS.firstName + " " + USERDETAILS.lastname
        buttonEmail.setTitle(USERDETAILS.email, for: .normal)
            
        self.availableString = "Dear \(USERDETAILS.firstName), this feature will be available to you soon. Please proceed with your learning journey."
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
    
            let fileUrl = URL(string: USERDETAILS.imageurl)
            self.imageProfile.sd_setImage(with: fileUrl)
            self.imageProfile.layer.borderWidth = 1.0
            self.imageProfile.layer.masksToBounds = false
            self.imageProfile.layer.borderColor = UIColor.darkGray.cgColor
            self.imageProfile.layer.cornerRadius = self.imageProfile.frame.width / 2
            self.imageProfile.clipsToBounds = true
            self.imageProfile.contentMode = .scaleAspectFit
            
      //  })
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tabGestureView.isUserInteractionEnabled = true
        tabGestureView.addGestureRecognizer(tap)
        languageUIView = LanguageUIView(frame: self.view.bounds)
            //CGRect(x: 20, y: 20 , width: self.view.bounds.width - 20, height: self.view.bounds.height - 20))
        languageUIView.tableViewLanguage.delegate = self
        self.view.addSubview(languageUIView)
        
        languageUIView.isHidden = true
//        languageview.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    

    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        closemethod()
     }

    @IBAction func emailDropDown(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraymenu.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell") as! MenuBarTableViewCell
        
        let images = cousesImages[indexPath .row]
        
        cell.labelName.text = arraymenu[indexPath.row]
        
        cell.labelimages.image = images
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == languageUIView.tableViewLanguage {
            let text = languageUIView.arrayLanguages[indexPath.row].dbname
            print(text)
            if count == 0 {
                let alertcontrol = UIAlertController(title: "My Choice!", message: "Would you like \(text) as preferred language for learning with Chocoed ?", preferredStyle: .alert)
                let alertaction = UIAlertAction(title: "No", style: .default) { (action) in
                    self.count = 1
                    UserDefaults.standard.set(text, forKey: "Language1")
                    self.languageUIView.isHidden = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                        self.languageUIView.label.text = "Please select your preferred language for learning with Chocoed"
                        self.languageUIView.isHidden = false
                    }
                    
                }
                let alertaction1 = UIAlertAction(title: "Yes", style: .default) { (action) in
                    self.languageUIView.isHidden = true
                    self.count = 0
                    UserDefaults.standard.set(text, forKey: "Language1")
                    UserDefaults.standard.set(text, forKey: "Language2")
                    
                    self.languageUIView.label.text = "Please select your preferred language for Chocoed app screens"
                    
                    self.sendLanguagesSelected()

                }
                alertcontrol.addAction(alertaction)
                alertcontrol.addAction(alertaction1)
                self.present(alertcontrol, animated: true, completion: nil)
                languageUIView.tableViewLanguage.deselectRow(at: indexPath, animated: false)
            } else {
                self.languageUIView.isHidden = true
                //let userLearningLang = UserDefaults.standard.string(forKey: "Language2")
                //let userAppLang = UserDefaults.standard.string(forKey: "Language1")
                
                UserDefaults.standard.set(text, forKey: "Language2")
                self.languageUIView.label.text = "Please select your preferred language for Chocoed app screens"
                languageUIView.tableViewLanguage.deselectRow(at: indexPath, animated: false)
                self.sendLanguagesSelected()

            }
            
            
        }else {
            
            
            switch(indexPath.row) {
                
            case 0:
                
                /*let v1 = self.storyboard?.instantiateViewController(withIdentifier: "mychoice") as! MyChoiceSkillsViewController
                self.present(v1, animated: true, completion: nil)
                */
                
                
                let alert = GetAlertWithOKAction(message: availableString)
                self.present(alert, animated: true, completion: nil)
                
                
                break;
                
            case 1:
                
              /*  currentTopiceDate = ""
                currentCourseId = ""
                
                isLoadExamFromVideo = ""
                isLoadExamId = ""
                isLoadCalendarId = ""
                isLoadExamName = ""
                
                let v1 = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
                self.present(v1, animated: true, completion: nil)
 
                 */
                
                
                let alert = GetAlertWithOKAction(message: availableString)
                self.present(alert, animated: true, completion: nil)
                
                
                
                
                break;
                
                
    
            case 2:
                let v1 = self.storyboard?.instantiateViewController(withIdentifier: "leader") as! LeaderBoardViewController
                self.present(v1, animated: true, completion: nil)
                
                break;

           
                
            case 3:
                
                let v1 = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
                self.present(v1, animated: true, completion: nil)
                
                break;
                
            case 4:
                textfieldMbNumber = UserDefaults.standard.string(forKey: "mobileno")!
                let alertcontrol = UIAlertController(title: "Alert", message: "Are you sure you want to logout?",preferredStyle: .alert)
                let alertaction = UIAlertAction(title: "No", style: .default) { (action) in
                    print("No I don't want to logout")
                }
                let alertaction1 = UIAlertAction(title: "Yes", style: .default) { (action) in
                    
                    textfieldMbNumber = UserDefaults.standard.string(forKey: "mobileno")!
                    
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                    let v2 = self.storyboard?.instantiateViewController(withIdentifier: "firstview") as! ViewController
                    self.present(v2, animated: true, completion: nil)
                    print(textfieldMbNumber)
                }
                
                alertcontrol.addAction(alertaction)
                alertcontrol.addAction(alertaction1)
                self.present(alertcontrol, animated: true, completion: nil)
                break;
             
                
            case 5 :
                
                let alert = GetAlertWithOKAction(message: "If you need help - just drop us an email at contact@skillcues.com")
                self.present(alert, animated: true, completion: nil)
                
                break
                
           /* case 4:
//            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//            blurEffectView.frame = view.bounds
//            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.addSubview(blurEffectView)
            self.languageUIView.isHidden = false
            self.count = 0

            break;
              */
        
                
            default:
                

                break
                
            }
        }
        
        
    }

    func closemethod()
    {
        UIView.animate(withDuration: 0.1, animations: { ()->Void in
            self.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.view.removeFromSuperview()
            
        }
        AppDelegate.menu_bool = true
        
    }
    
    func sendLanguagesSelected() {
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        let language1 = UserDefaults.standard.string(forKey: "Language1")
        let language2 = UserDefaults.standard.string(forKey: "Language2")
        var params =  Dictionary<String, String>()
        if language1 != nil && language2 != nil
        {
            
            params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientID)","appLanguage":"\(language1!)","learningLanguage":"\(language2!)"] as Dictionary<String, String>
            print(params)
          
            MakeHttpPostRequest(url: saveLanguageSelected, params: params, completion: {(success, response) -> Void in
                print(response)
            }, errorHandler: {(message) -> Void in
                let alert = GetAlertWithOKAction(message: message)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
        }
        
    }

}
