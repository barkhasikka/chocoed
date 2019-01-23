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
    
    var isApp = false
    var isSec = false
    
//    @IBOutlet weak var tabelviewLanguage: UITableView!
//    @IBOutlet weak var languageview: UIView!
    var arraymenu = [String]()
  
    
        override func viewDidLoad() {
            super.viewDidLoad()
           
          self.loadGetLanguageList()
            
            let language = UserDefaults.standard.string(forKey: "currentlanguage")
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
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")

        
        if tableView == tabelViewMenu{
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell") as! MenuBarTableViewCell
        
       // let images = cousesImages[indexPath.row]
        
         cell.labelName.text = arraymenu[indexPath.row]
            
            
        if arraymenu[indexPath.row] == "MyDailyKey".localizableString(loc: language!) {
                
                cell.labelimages.image = UIImage(named:"completed_tests")
                
         }
            
         if arraymenu[indexPath.row] == "MytalksKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"chat")

         }
            
         if arraymenu[indexPath.row] == "MyVoiceKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"elections")
                
         }
            
         if arraymenu[indexPath.row] == "MyCoreEvaluationKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"CoreSkills")
                
            }
            
            
        if arraymenu[indexPath.row] == "tagUKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"lotus_icon")
                
        }
            
        if arraymenu[indexPath.row] == "MyprogressKeyMenu".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"myprocess_improvement")
                
         }
            
            if arraymenu[indexPath.row] == "NominateKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"menu_change_life")
                
            }
            
            if arraymenu[indexPath.row] == "EmpowerOthersKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"menu_empower")
                
            }
            
        if arraymenu[indexPath.row] == "MyProfileKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"icons_user")
                
        }
            
            
        if arraymenu[indexPath.row] == "ApplicationLanguageKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"icons_lang")
                
        }
            
        if arraymenu[indexPath.row] == "LearningLanguageKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"icons_lang")
                
        }
            
        if arraymenu[indexPath.row] == "UpgradeChocoedKey".localizableString(loc: language!){
                
                cell.labelimages.image = UIImage(named:"upgrade")
                
        }
            
        return cell
        }else if tableView == tableviewLanguage{
        let cell = tableView.dequeueReusableCell(withIdentifier: "langcell") as! LanguageView1TableViewCell
        
        cell.labelLanguageName.text = arrayLanguages[indexPath.row].langDispalyName
        
        return cell
        }

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
        
    
        let language = UserDefaults.standard.string(forKey: "currentlanguage")

        
        let menu = self.arraymenu[indexPath.row]
        print(menu)
        
        
        
        if arraymenu[indexPath.row] == "MyDailyKey".localizableString(loc: language!){
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
            self.present(v1, animated: true, completion: nil)
            
        }
        
        if arraymenu[indexPath.row] == "MytalksKey".localizableString(loc: language!){
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "FriendListVC") as! FriendListVC
            self.present(v1, animated: true, completion: nil)
            
        }
        
        if arraymenu[indexPath.row] == "MyVoiceKey".localizableString(loc: language!){
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "poll") as? PollViewController
            self.present(vc!, animated: true, completion: nil)
            
        }
        
        if arraymenu[indexPath.row] == "MyCoreEvaluationKey".localizableString(loc: language!){
            
            let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "WevViewVC") as! WevViewVC
            vcNewSectionStarted.currentExamID = -10
            vcNewSectionStarted.calenderId = "1"
            vcNewSectionStarted.fromType = "menu"
            self.present(vcNewSectionStarted, animated: true, completion: nil)
            
        }
        
        if arraymenu[indexPath.row] == "tagUKey".localizableString(loc: language!){
            
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "taguList") as? MyTagUlistViewController
            present(vc!, animated: true, completion: nil)
            
        }
        
        if arraymenu[indexPath.row] == "MyprogressKeyMenu".localizableString(loc: language!){
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "leader") as! LeaderBoardViewController
            self.present(v1, animated: true, completion: nil)
            
        }
        
        if arraymenu[indexPath.row] == "NominateKey".localizableString(loc: language!){
            
            
            
            let isnominated = UserDefaults.standard.bool(forKey: "isNominatedUser")
            
             if isnominated == false {
                
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "nominee") as? NominationViewController
             self.present(vc!, animated: true, completion: nil)
                
             }else{
                
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "nomineeView") as? NomineeDetailsViewController
             self.present(vc!, animated: true, completion: nil)
                
             }
            
            
        }
        
        if arraymenu[indexPath.row] == "EmpowerOthersKey".localizableString(loc: language!){
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "empower") as! EmpowerViewController
            self.present(v1, animated: true, completion: nil)
            
        }
        
        
        if arraymenu[indexPath.row] == "MyProfileKey".localizableString(loc: language!){
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
            self.present(v1, animated: true, completion: nil)
            
            
        }
        
        
        if arraymenu[indexPath.row] == "ApplicationLanguageKey".localizableString(loc: language!){
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
            v1.type = "app"
            v1.back = "main"
            self.present(v1, animated: true, completion: nil)
            
        }
        
        if arraymenu[indexPath.row] == "LearningLanguageKey".localizableString(loc: language!){
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
            v1.type = "secondary"
            v1.back = "main"
            self.present(v1, animated: true, completion: nil)
            
        }
        
        if arraymenu[indexPath.row] == "UpgradeChocoedKey".localizableString(loc: language!){
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
            self.present(v1, animated: true, completion: nil)
            
        }
        
       

        
    }
    
    func loadGetLanguageList1() {
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
    
    
    func loadGetLanguageList() {
        
        var clientid = UserDefaults.standard.string(forKey: "clientid")
        var userid = UserDefaults.standard.string(forKey: "userid")
        
        if clientid == nil {
            
            clientid = ""
        }
        
        if userid == nil {
            
            userid = ""
        }
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid!)"] as Dictionary<String, String>
        
        MakeHttpPostRequest(url: getLanguageListCall, params: params, completion: {(success, response) -> Void in
            print(response)
            
            let language = response.object(forKey: "appList") as? NSArray ?? []
            
            if language.count == 1 {
                self.isApp = false
            }else{
                self.isApp = true
            }
            
            
            let languagesec = response.object(forKey: "secondaryList") as? NSArray ?? []
            

            if languagesec.count == 1 {
                self.isSec = false
            }else{
                self.isSec = true
            }
            
            DispatchQueue.main.async {

                
                let language = UserDefaults.standard.string(forKey: "currentlanguage")
                let userType = Int(UserDefaults.standard.string(forKey: "userType")!);
                
                
                
               // if language == "hi"{
                
                self.arraymenu.append("MyDailyKey".localizableString(loc: language!))
                self.arraymenu.append("MyTalksKey".localizableString(loc: language!))
                self.arraymenu.append("MyVoiceKey".localizableString(loc: language!))
                self.arraymenu.append("MyCoreEvaluationKey".localizableString(loc: language!))
                self.arraymenu.append("tagUKey".localizableString(loc: language!))
                self.arraymenu.append("MyprogressKeyMenu".localizableString(loc: language!))
                
                let isnominatedallow = UserDefaults.standard.bool(forKey: "isNominationAllowed")
                
                if isnominatedallow == true{
                    
                  self.arraymenu.append("NominateKey".localizableString(loc: language!))
                }
                
               // self.arraymenu.append("EmpowerOthersKey".localizableString(loc: language!))

                
                
                self.arraymenu.append("MyProfileKey".localizableString(loc: language!))
                
                
                    if self.isApp == true && self.isSec == true {
                        
                        self.arraymenu.append("ApplicationLanguageKey".localizableString(loc: language!))
                        self.arraymenu.append("LearningLanguageKey".localizableString(loc: language!))
                        
                    }else if self.isApp == true && self.isSec == false{
                        
                       self.arraymenu.append("ApplicationLanguageKey".localizableString(loc: language!))
                        //self.arraymenu.append("माध्यमिक शिक्षा की")
                        
                    }else if self.isApp == false && self.isSec == true{
                        
                        //self.arraymenu.append("एप्लिकेशन भाषा")
                        self.arraymenu.append("LearningLanguageKey".localizableString(loc: language!))
                        
                    }

                    if userType == 2 {
                        self.arraymenu.append("UpgradeChocoedKey".localizableString(loc: language!))
                    }
                    
                
                
                self.tabelViewMenu.reloadData()
                
            }
            
            
        }, errorHandler: {(message) -> Void in
           
        })
        
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
