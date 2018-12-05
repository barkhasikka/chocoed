//
//  ViewControllerMenubar2DonarViewController.swift
//  chocoed
//
//  Created by Tejal on 05/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ViewControllerMenubar: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var slidingMenuView: UIView!
    @IBOutlet weak var tabelviewSeclearning: UITableView!
    @IBOutlet weak var labelAlertChoice: UILabel!
    @IBOutlet weak var labelchoice: UILabel!
    @IBOutlet weak var alertviewSecLanguage: UIView!
    @IBOutlet weak var viewAlertchoice: UIView!
    @IBOutlet weak var tabelViewMenu: UITableView!
    @IBOutlet weak var tableviewLanguage: UITableView!
    @IBOutlet weak var viewLanguage: UIView!
    @IBOutlet weak var profileGradiantView: UIView!
    @IBOutlet weak var buttonEmail: UIButton!
    @IBOutlet weak var tabGestureView: UIView!
    @IBOutlet weak var labelUserNAme: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    let lang = ViewController()
    var userImageLoaded : UIImage? = nil
    var languageUIView: LanguageUIView!
    var count = 0
    var availableString = ""
    var arrayLanguages = [LanguageList]()
    var arraysecLang = [LanguageList]()
    var activityUIView: ActivityIndicatorUIView!
    
    @IBOutlet weak var buttonCloseView: UIButton!
    @IBOutlet weak var labelSelectPrefLang: UILabel!
    
//    @IBOutlet weak var tabelviewLanguage: UITableView!
//    @IBOutlet weak var languageview: UIView!
    var arraymenu = ["My Talks","My Thoughts","My Progress","My Profile","Application Language","Learning Language","Log out"]
    let cousesImages = [UIImage(named:"chat"),UIImage(named: "discussion_room"), UIImage(named: "myprocess_improvement"), UIImage(named: "icons_user"),UIImage(named: "discussion_room"), UIImage(named: "myprocess_improvement"), UIImage(named: "icon_logout")]
    
        override func viewDidLoad() {
            super.viewDidLoad()
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
           print(language)
            if language == "hi"{
                arraymenu = ["मेरा वार्तालाप","मेरे विचार","मेरा विकास","मेरी प्रोफाइल","एप्लिकेशन भाषा","माध्यमिक शिक्षा की","लोग आउट"]
            }else if language == "en"{
                arraymenu = ["My Talks","My Thoughts","My Progress","My Profile","Application Language","Learning Language","Log out"]
            }
            self.labelSelectPrefLang.text = "LabelLanguageStringAppKey".localizableString(loc: language!)
            
            
     //let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 315, height: 166))
            viewLanguage.isHidden = true
            viewAlertchoice.isHidden = true
            activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
            self.view.addSubview(activityUIView)
            activityUIView.isHidden = true

        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.profileGradiantView.bounds.width, height: self.profileGradiantView.bounds.height))

            backgroundImage.image = UIImage(named: "Profile_page Gradient")
            backgroundImage.contentMode = UIViewContentMode.scaleToFill
            self.profileGradiantView.insertSubview(backgroundImage, at: 0 )

            
            
        
        labelUserNAme.text = USERDETAILS.firstName + " " + USERDETAILS.lastname
        buttonEmail.setTitle(USERDETAILS.email, for: .normal)
            
       // self.availableString = "Dear \(USERDETAILS.firstName), this feature will be available to you soon. Please proceed with your learning journey."
            
            self.availableString = "DearKey".localizableString(loc: language!) + " \(USERDETAILS.firstName) "  + "availableStringKey".localizableString(loc: language!)
        
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
    
    
    @IBAction func buttonCloseLangView(_ sender: Any) {
        viewLanguage.isHidden =  true
        tabelViewMenu.isHidden = false
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
        var count1 = Int()
        if tableView == tabelViewMenu {
        count1 = arraymenu.count
        }else if tableView == tableviewLanguage{
            count1 = arrayLanguages.count
        }else if tableView == tabelviewSeclearning{
            count1 = arrayLanguages.count
        }
        return count1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tabelViewMenu{
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell") as! MenuBarTableViewCell
        
        let images = cousesImages[indexPath.row]
        
        cell.labelName.text = arraymenu[indexPath.row]
        
        cell.labelimages.image = images
        
        return cell
        }else if tableView == tableviewLanguage{
        let cell = tableView.dequeueReusableCell(withIdentifier: "langcell") as! LanguageView1TableViewCell
        
        cell.labelLanguageName.text = arrayLanguages[indexPath.row].langDispalyName
        
        return cell
        }
//        else if tableView == tabelviewSeclearning{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "secCell") as! SecondaryLangTableViewCell
//
//            cell.dbNameLabel.text = arraysecLang[indexPath.row].dbname
//            cell.labelSecLanguage.text = arraysecLang[indexPath.row].langDispalyName
//             return cell
//        }
        return UITableViewCell()
    }
    
    func presentMainDashboard(){
         let language = UserDefaults.standard.string(forKey: "currentlanguage")
        let alertcontrol = UIAlertController(title: "alertKey".localizableString(loc: language!), message: "ApplicationLangAlert".localizableString(loc: language!), preferredStyle: .alert)
        let alertaction1 = UIAlertAction(title: "alertYes".localizableString(loc: language!), style: .default) { (action) in
            let startVC = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
            let aObjNavi = UINavigationController(rootViewController: startVC)
            aObjNavi.navigationBar.barTintColor = UIColor.blue
            self.present(aObjNavi, animated: true, completion: nil)

        }
        let alertAction2 = UIAlertAction(title: "alertNo".localizableString(loc: language!), style: .cancel, handler: nil)
        
        alertcontrol.addAction(alertaction1)
        alertcontrol.addAction(alertAction2)
        self.present(alertcontrol, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableviewLanguage {
//            let text = languageUIView.arrayLanguages[indexPath.row].dbname
//            print(text)
//            if count == 0 {
//                let alertcontrol = UIAlertController(title: "My Choice!", message: "Would you like \(text) as preferred language for learning with Chocoed ?", preferredStyle: .alert)
//                let alertaction = UIAlertAction(title: "No", style: .default) { (action) in
//                    self.count = 1
//                    UserDefaults.standard.set(text, forKey: "Language1")
//                    self.languageUIView.isHidden = true
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
//                        self.languageUIView.label.text = "Please select your preferred language for learning with Chocoed"
//                        self.languageUIView.isHidden = false
//                    }
//
//                }
//                let alertaction1 = UIAlertAction(title: "Yes", style: .default) { (action) in
//                    self.languageUIView.isHidden = true
//                    self.count = 0
//                    UserDefaults.standard.set(text, forKey: "Language1")
//                    UserDefaults.standard.set(text, forKey: "Language2")
//
//                    self.languageUIView.label.text = "Please select your preferred language for Chocoed app screens"
//
//                    self.sendLanguagesSelected()
//
//                }
//                alertcontrol.addAction(alertaction)
//                alertcontrol.addAction(alertaction1)
//                self.present(alertcontrol, animated: true, completion: nil)
//                languageUIView.tableViewLanguage.deselectRow(at: indexPath, animated: false)
            
                switch indexPath.row {
                case 2 :
                    UserDefaults.standard.set("en", forKey: "currentlanguage")
                    presentMainDashboard()
                    break
                case 4 :
                    UserDefaults.standard.set("hi", forKey: "currentlanguage")
                    presentMainDashboard()
                    break
                default:
                    print("default value is selected")
                    break
                }
            
                print("tabelViewMenu is selected")
                viewLanguage.isHidden = true
                tabelViewMenu.isHidden = false
            
            
        }
//            else {
//                self.languageUIView.isHidden = true
//                //let userLearningLang = UserDefaults.standard.string(forKey: "Language2")
//                //let userAppLang = UserDefaults.standard.string(forKey: "Language1")
//
//                UserDefaults.standard.set(text, forKey: "Language2")
//                self.languageUIView.label.text = "Please select your preferred language for Chocoed app screens"
//                languageUIView.tableViewLanguage.deselectRow(at: indexPath, animated: false)
//                self.sendLanguagesSelected()
//
//            }
            
            else if tableView == tabelViewMenu {
            
            switch(indexPath.row) {
                
            case 0:
                
                /*let v1 = self.storyboard?.instantiateViewController(withIdentifier: "mychoice") as! MyChoiceSkillsViewController
                self.present(v1, animated: true, completion: nil)
                */
                
                
               // let alert = GetAlertWithOKAction(message: availableString)
               // self.present(alert, animated: true, completion: nil)
                
                let v1 = self.storyboard?.instantiateViewController(withIdentifier: "FriendListVC") as! FriendListVC
                self.present(v1, animated: true, completion: nil)
                
                
                
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
                
            case 6:
                 let language = UserDefaults.standard.string(forKey: "currentlanguage")
                textfieldMbNumber = UserDefaults.standard.string(forKey: "mobileno")!
                let alertcontrol = UIAlertController(title: "alertKey".localizableString(loc: language!), message: "logoutAlert".localizableString(loc: language!),preferredStyle: .alert)
                let alertaction = UIAlertAction(title: "alertNo".localizableString(loc: language!), style: .default) { (action) in
                    print("noLogoutAlert".localizableString(loc: language!))
                }
                let alertaction1 = UIAlertAction(title: "alertYes".localizableString(loc: language!), style: .default) { (action) in
                    
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
             
                
            case 4 :
               
               /* arrayLanguages.removeAll()
                viewLanguage.isHidden = false
                loadGetLanguageList()
                tabelViewMenu.isHidden = true
               */
                
                let v1 = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                v1.type = "app"
                v1.back = "main"
                self.present(v1, animated: true, completion: nil)
                
                
                break
                
            case 5 :
                
               /* self.alertviewSecLanguage.layer.cornerRadius = 5
                self.alertviewSecLanguage.clipsToBounds = true
                self.viewAlertchoice.isHidden = false
                arraysecLang.removeAll()
                loadGetLanguageList()
                self.slidingMenuView.isHidden = true */
                
                let v1 = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                v1.type = "secondary"
                v1.back = "main"
                self.present(v1, animated: true, completion: nil)
                
                
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
        }else if tableView == tabelviewSeclearning{
            viewAlertchoice.isHidden = true
            slidingMenuView.isHidden = false
            
        }
    }
    
    func loadGetLanguageList() {
        let clientid = UserDefaults.standard.string(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getLanguageListCall, params: params, completion: {(success, response) -> Void in
            print(response)
            let language = response.object(forKey: "appList") as? NSArray ?? []
            
            for languages in language {
                self.arrayLanguages.append(LanguageList( languages as? NSDictionary))
                
            }
          //  let languagelearn = response.object(forKey: "secondaryList") as? NSArray ?? []
            
          //  for learninglanguage in languagelearn{
          //      self.arraysecLang.append(LanguageList( learninglanguage as? NSDictionary))
          //  }
            print(self.arraysecLang.count)
            DispatchQueue.main.async {
                self.tableviewLanguage.reloadData()
                self.tabelviewSeclearning.reloadData()
                
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
            print(self.arrayLanguages)
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                
            }
        })
        
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
