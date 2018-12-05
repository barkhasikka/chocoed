//
//  SplitviewViewController.swift
//  chocoed
//
//  Created by Tejal on 05/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import Firebase
import XMPPFramework
import UserNotifications


class SplitviewViewController: UIViewController , UNUserNotificationCenterDelegate {

    @IBOutlet var badgeImage: UIImageView!
    
    @IBOutlet weak var textcoinsEarned: UILabel!
    @IBOutlet weak var textbadgesEarned: UILabel!
    @IBOutlet weak var choiceLabel2: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var thought: UILabel!
    @IBOutlet weak var talkLabel: UILabel!
    @IBOutlet weak var conversationLabel1: UILabel!
    @IBOutlet weak var contentLabel1: UILabel!
    @IBOutlet weak var choiceLabel1: UIImageView!
    @IBOutlet weak var badgesEarnedLabel: UILabel!
    @IBOutlet weak var compTestLabel: UILabel!
    @IBOutlet weak var completedTopicsLabel: UILabel!
    @IBOutlet weak var topArcVIew: NSLayoutConstraint!
    
   
    @IBOutlet weak var myProgressHandUIView: UIView!
    @IBOutlet weak var myThoughtsHandUIView: UIView!
    @IBOutlet weak var myChatHandUIView: UIView!
    @IBOutlet var lblTestCount: UILabel!
    
    @IBOutlet weak var myprogressConstraintOutlet: NSLayoutConstraint!
    @IBOutlet var lblBadgesCount: UILabel!
    @IBOutlet var lblTopicCount: UILabel!
    @IBOutlet var lblnotificationCount: UILabel!
    @IBOutlet var notificationimgae: UIImageView!
    @IBOutlet weak var viewChoice: UIView!
    @IBOutlet weak var viewvonversation: UIView!
    @IBOutlet weak var viewContent: UIView!
    var menuvc : ViewControllerMenubar!
    var toggle = true
    var buttonProgrss = false
    var buttonThought = false
    var buttonchat = false
    var drag = ""
    
    var coinsearned : Int  = 0
    var badesEarned : Int = 0
    
    var availableString = ""
    
    @IBOutlet weak var popUpViewforBadges: UIView!
    @IBOutlet weak var mainviewConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var arcView: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var userProgressView: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var buttonLotus: UIButton!
    @IBOutlet weak var buttonMiddleProfile: UIButton!
    @IBOutlet weak var buttonMsg: UIButton!
    @IBOutlet weak var viewButtonsCircle: UIView!
    
    @IBOutlet weak var mychatButton: UIButton!
    
    @IBOutlet weak var myThoughtsButton: UIButton!
    
    @IBOutlet weak var myProgressButton: UIButton!
    
    @IBOutlet weak var heightmychat: NSLayoutConstraint!
    
    @IBOutlet weak var widthMychat: NSLayoutConstraint!
    
    @IBOutlet weak var widthMyprogrss: NSLayoutConstraint!
    @IBOutlet weak var heightMyThought: NSLayoutConstraint!
    
    @IBOutlet weak var heightprogrss: NSLayoutConstraint!
    
    @IBOutlet weak var widthMyThought: NSLayoutConstraint!
    
    
    public func showNotification(friendname: String,msg:String){
        
        
        //creating the notification content
        let content = UNMutableNotificationContent()
        
        //adding title, subtitle, body and badge
        content.title = friendname
        content.body = msg
        content.badge = 1
        
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        
        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //displaying the ios local notification when app is in foreground
        completionHandler([.alert, .badge, .sound])
    }
    
   /* func oneStream(_ sender: XMPPStream, didReceiveMessage message: XMPPMessage, from user: XMPPUserCoreDataStorageObject) {
        print("<<<<<< AT DELEGATE didReceiveMessage")
        
        
    }
    
    func oneStream(_ sender: XMPPStream, userIsComposing user: XMPPUserCoreDataStorageObject) {
        
        print("<<<<<< AT DELEGATE userIsComposing")
        
    }
    
    func oneStream(_ sender: XMPPStream, didReceiptReceive message: XMPPMessage, from user: XMPPUserCoreDataStorageObject) {
        
        print("<<<<<< AT DELEGATE didReceiptReceive")
        
    }
   */
    
    
    
    @IBAction func conversation_btn_clicked(_ sender: Any) {
        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "FriendListVC") as! FriendListVC
        self.present(v1, animated: true, completion: nil)
        
      //  let alert = GetAlertWithOKAction(message: availableString)
      //  self.present(alert, animated: true, completion: nil)
    }
    
   
    @IBAction func arcThoughtd(_ sender: UIButton) {
        
        
       let alert = GetAlertWithOKAction(message: availableString)
       self.present(alert, animated: true, completion: nil)
       
        
    }
    
    @IBAction func srcChat_Clicked(_ sender: Any) {
        
        
      //  let alert = GetAlertWithOKAction(message: availableString)
      //  self.present(alert, animated: true, completion: nil)
        
        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "FriendListVC") as! FriendListVC
        self.present(v1, animated: true, completion: nil)
        
        
        
    }
    
//    @IBAction func notificationCheckClick(_ sender: UIBarButtonItem) {
//       
//        
//    }
    @IBAction func arcTagu_clicked(_ sender: Any) {
        
        let alert = GetAlertWithOKAction(message: availableString)
        self.present(alert, animated: true, completion: nil)
        
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if imageViewLogo != nil {
        self.imageViewLogo.image = nil
        }
    }
    
    
    @IBAction func colsebuttonInPopUp(_ sender: Any) {
        self.popUpViewforBadges.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       self.lblnotificationCount.layer.cornerRadius = 10
       self.lblnotificationCount.clipsToBounds =  true
        NotificationImageTapped()
        let language = UserDefaults.standard.string(forKey: "currentlanguage")

        let backgroundImage = UIImageView(frame: self.popUpViewforBadges.bounds)
        backgroundImage.image = UIImage(named: "gradient_pattern_oval")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.popUpViewforBadges.insertSubview(backgroundImage, at: 0)
        
        self.popUpViewforBadges.isHidden = true
        
        self.availableString = "DearKey".localizableString(loc: language!) + " \(USERDETAILS.firstName) "  + "availableStringKey".localizableString(loc: language!)
        
        
        

        self.compTestLabel.text = "TestCompletedKey".localizableString(loc: language!)
        self.completedTopicsLabel.text = "TopicCompletedKey".localizableString(loc: language!)
        self.badgesEarnedLabel.text = "BadgesEarnedKey".localizableString(loc: language!)
        self.talkLabel.text = "TalkKey".localizableString(loc: language!)
        self.thought.text = "ThoughtKey".localizableString(loc: language!)
        self.progressLabel.text = "ProgressKey".localizableString(loc: language!)
        self.choiceLabel2.text = "ChoiceKey".localizableString(loc: language!)
        self.conversationLabel1.text = "ConversationKey".localizableString(loc: language!)
        self.contentLabel1.text = "ContentKey".localizableString(loc: language!)

      
        self.myThoughtsHandUIView.isHidden = true
        self.myProgressHandUIView.isHidden = true
        
        self.myChatHandUIView.applyBackground()
        self.arcView.isHidden = true
        let fileUrl = URL(string: USERDETAILS.imageurl)
        self.imageProfile.sd_setImage(with: fileUrl)

       /* if fileUrl != nil {
            if let data = try? Data(contentsOf: fileUrl!) {
                if let image = UIImage(data: data) {
                    self.imageProfile.image = image
                }
            }
        */
            
            
            imageProfile.layer.borderWidth = 1.0
            imageProfile.layer.masksToBounds = false
            imageProfile.layer.borderColor = UIColor.darkGray.cgColor
            imageProfile.layer.cornerRadius = imageProfile.frame.width / 2
            imageProfile.clipsToBounds = true
            imageProfile.contentMode = .scaleAspectFit
       // }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageViewLogo.isUserInteractionEnabled = true
        imageViewLogo.addGestureRecognizer(tapGestureRecognizer)
        // let backgroundImage = UIImageView(frame: frame)
        //  backgroundImage.image = UIImage(named: "dashboard_header")
        //  backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        //  self.viewButtonsCircle.insertSubview(backgroundImage, at: 0 )
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        navigationController?.navigationBar.topItem?.title = "MyRadarKey".localizableString(loc: language!)
//        let frame1 = CGRect(x: 0, y: 620, width: UIScreen.main.bounds.width, height: 120)
//        let backgroundImage1 = UIImageView(frame: frame1)
//        backgroundImage1.image = UIImage(named: "ic_choice_conversion_content_connect")
//        backgroundImage1.contentMode = UIViewContentMode.scaleAspectFill
//        self.arcView.insertSubview(backgroundImage, at: 0 )
        
        menuvc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! ViewControllerMenubar
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(responsetoright))
        swiperight.direction = UISwipeGestureRecognizerDirection.right
       
        self.view.addGestureRecognizer(swiperight)
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(responsetoright))
        swipeleft.direction = UISwipeGestureRecognizerDirection.right
        
        
        self.view.addGestureRecognizer(swipeleft)
        if self.imageProfile.image != nil {
            menuvc.userImageLoaded = self.imageProfile.image!
        }
        
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(badgeImageAction(tapGestureRecognizer:)))
        self.badgeImage.isUserInteractionEnabled = true
        self.badgeImage.addGestureRecognizer(tapGestureRecognizer1)
    }
    
    @objc func badgeImageAction(tapGestureRecognizer: UITapGestureRecognizer){
        
        self.popUpViewforBadges.isHidden = false
    }
    
    func NotificationImageTapped(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(notificatonImageAction(tapGestureRecognizer:)))
        notificationimgae.isUserInteractionEnabled = true
        notificationimgae.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func notificatonImageAction(tapGestureRecognizer: UITapGestureRecognizer){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "notification") as? NotificationViewController
        vc?.badgesCount = String(self.badesEarned)
        vc?.coinsCount = String(self.coinsearned)
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    @IBAction func MyProgressActionButton(_ sender: Any) {
        buttonProgrss = !buttonProgrss
        if buttonProgrss == true{
            self.view.layoutIfNeeded()
            self.myProgressHandUIView.removeBackground()
            self.myProgressHandUIView.applyBackground()

            self.buttonThought = false
            self.buttonchat = false
            self.myThoughtsButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
            self.myProgressButton.isHidden = true
            self.myProgressHandUIView.isHidden = false
            
        } else {
            self.myProgressButton.isHidden = false
            self.myProgressHandUIView.isHidden = true
        }
        self.myThoughtsHandUIView.isHidden = true
        self.myChatHandUIView.isHidden = true
        self.myThoughtsButton.isHidden = false
        self.mychatButton.isHidden = false
        
        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "leader") as! LeaderBoardViewController
        self.present(v1, animated: true, completion: nil)
    }
    
    @IBAction func MyChatActionButton(_ sender: Any) {
        buttonchat = !buttonchat
        
        if buttonchat == true{

            self.view.layoutIfNeeded()
            self.myChatHandUIView.removeBackground()
            self.myChatHandUIView.applyBackground()
            self.mychatButton.isHidden = true
            self.myChatHandUIView.isHidden = false
            self.buttonThought = false
            self.buttonProgrss = false
        }else{
            self.view.layoutIfNeeded()
            self.mychatButton.isHidden = false
            self.myChatHandUIView.isHidden = true
       }
        self.myThoughtsHandUIView.isHidden = true
        self.myThoughtsButton.isHidden = false
        self.myProgressHandUIView.isHidden = true
        self.myProgressButton.isHidden = false
        
        let alert = GetAlertWithOKAction(message: availableString)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func MyThoughtsActionButton(_ sender: Any) {
        buttonThought = !buttonThought
        
        if buttonThought == true{

            self.view.layoutIfNeeded()
            self.myThoughtsHandUIView.removeBackground()
            self.myThoughtsHandUIView.applyBackground()
            self.buttonchat = false
            self.buttonProgrss = false
            
            self.myThoughtsButton.isHidden = true
            self.myThoughtsHandUIView.isHidden = false
        }else{
            self.view.layoutIfNeeded()
            self.myThoughtsButton.isHidden = false
            self.myThoughtsHandUIView.isHidden = true
        }
        self.myProgressHandUIView.isHidden = true
        self.myProgressButton.isHidden = false
        self.myChatHandUIView.isHidden = true
        self.mychatButton.isHidden = false
        
        let alert = GetAlertWithOKAction(message: availableString)
        self.present(alert, animated: true, completion: nil)
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
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        print("Please select image")
        toggle = !toggle
        print(toggle)
        if toggle == true{
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, animations: {
            self.arcView.isHidden = true
            self.topArcVIew.constant = 25
            self.mainviewConstraintOutlet.constant = 700
            self.view.layoutIfNeeded()
            })
        }else{
          
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 1, animations: {
                self.topArcVIew.constant = 175
                self.mainviewConstraintOutlet.constant =  820
                self.view.layoutIfNeeded()
                self.arcView.isHidden = false

        })
        }
    }
    @IBAction func menuButton(_ sender: UIBarButtonItem) {
        if AppDelegate.menu_bool {
            showmethod()
        }
        else
        {
            closemethod()
        }
    }
    func constraintsToButton(){
        buttonMsg.translatesAutoresizingMaskIntoConstraints = false
        self.buttonMsg.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250).isActive = true
        self.buttonMsg.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonMsg.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonMsg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    
        buttonLotus.translatesAutoresizingMaskIntoConstraints =  false
        self.buttonLotus.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250).isActive =  true
        self.buttonLotus.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonLotus.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonLotus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        buttonMiddleProfile.translatesAutoresizingMaskIntoConstraints = false
        self.buttonMiddleProfile.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive =  true
        self.buttonMiddleProfile.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonMiddleProfile.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonMiddleProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    @objc func responsetoright(gesture : UISwipeGestureRecognizer) {
        switch gesture.direction
        {
        case UISwipeGestureRecognizerDirection.right:
            print("left swipe")
            showmethod()
        case UISwipeGestureRecognizerDirection.left:
            print("left swipe")
            close_swipe()
        default : break
            
        }
    }

    func showmethod() {
        
        UIView.animate(withDuration: 0.1) { ()->Void in
            self.menuvc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.addChildViewController(self.menuvc)
            self.view.addSubview(self.menuvc.view)
            self.menuvc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            AppDelegate.menu_bool = false
        }
        
    }
    func closemethod()
    {
        UIView.animate(withDuration: 0.1, animations: { ()->Void in
            self.menuvc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.menuvc.view.removeFromSuperview()
            
        }
        AppDelegate.menu_bool = true
        
    }

    @IBAction func MychoiceAction(_ sender: Any) {
        
       let v1 = self.storyboard?.instantiateViewController(withIdentifier: "mychoice") as! MyChoiceSkillsViewController
        self.present(v1, animated: true, completion: nil)
 
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close_swipe()
    {
        if AppDelegate.menu_bool {
            showmethod()
        }
        else
        {
            closemethod()
        }
    }
    
    @IBAction func content_clicked(_ sender: Any) {
        
        currentTopiceDate = ""
        currentCourseId = ""
        
        isLoadExamFromVideo = ""
        isLoadExamId = ""
        isLoadCalendarId = ""
        isLoadExamName = ""
        
        
        
        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
        self.present(v1, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      //  OneMessage.sharedInstance.delegate = self

        
        let Gif = UIImage.gifImageWithName("chocoed_wave")
        self.imageViewLogo.image = Gif
        
        self.sendLanguagesSelected()
        
        
        
    }
    
    
    func GetUserInfo() {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) in
            print(response)
            let jsonobject = response["info"] as? NSDictionary;
            let temp = ModelProfileClass()
            temp.firstName = jsonobject?.object(forKey: "firstName") as? String ?? ""
            temp.lastName = jsonobject?.object(forKey: "lastName") as? String ?? ""
            temp.email = jsonobject?.object(forKey: "email") as? String ?? ""
            temp.mobile = jsonobject?.object(forKey: "mobile") as? String ?? ""
            let clientId = jsonobject?.object(forKey: "clientId") as? String ?? ""
            let url = jsonobject?.object(forKey: "profileImageUrl") as? String ?? ""
            let quizTaken =  jsonobject?.object(forKey:"quizTestGiven") as? Int ?? -1
            UserDefaults.standard.set(quizTaken, forKey: "quiztakenID")
            //let quizID = UserDefaults.standard.string(forKey: "quiztakenID")
            // print(quizID)
            // let fileUrl = URL(string: url)
            
            UserDefaults.standard.set(temp.mobile, forKey: "mobileno")
            
            let notificationCount = jsonobject?.object(forKey: "notificationCount") as? Int ?? 0

            
            
            
            let applang = jsonobject?.object(forKey: "appLanguage") as? String ?? ""
            let learningLang = jsonobject?.object(forKey: "learningLanguage") as? String ?? ""
            let clientLanguage = jsonobject?.object(forKey: "clientLanguage") as? String ?? ""

            
            UserDefaults.standard.set(applang, forKey: "Language1")  //app
            UserDefaults.standard.set(clientLanguage, forKey: "Language2") //pri
            UserDefaults.standard.set(learningLang, forKey: "Language3") //sec

            
            self.sendFcm()
            
            
            UserDefaults.standard.set(Int(clientId), forKey: "clientid")
            
            USERDETAILS = UserDetails(email: temp.email, firstName: temp.firstName, lastname: temp.lastName, imageurl: url, mobile: temp.mobile)
            
            self.coinsearned = jsonobject?.object(forKey: "coinsEarned") as? Int ?? 0
            self.badesEarned =  jsonobject?.object(forKey:"badesEarned") as? Int ?? 0
            let completedTestCout =  jsonobject?.object(forKey:"completedTestCout") as? Int ?? 0
            let completedTopicCout =  jsonobject?.object(forKey:"completedTopicCout") as? Int ?? 0

            
            DispatchQueue.main.async {
                self.lblBadgesCount.text = String(self.badesEarned)
                self.lblTestCount.text = String(completedTestCout)
                self.lblTopicCount.text = String(completedTopicCout)
                self.textcoinsEarned.text = String(self.coinsearned)
                self.textbadgesEarned.text = String(self.badesEarned)
                
                if notificationCount != 0 {
                    self.lblnotificationCount.isHidden = false
                    self.lblnotificationCount.text = String(notificationCount)
                }else{
                    self.lblnotificationCount.isHidden = true
                }
                
                
            }

            
            
            
        }, errorHandler: {(message) -> Void in
            print("message", message)
        })
    }
    
    
    private func getUnreadChatCount(){
        
        var count = 0
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "read_count != %@", "0")
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                for item in results{
                let updatObj = item as! Friends
                let c = Int(updatObj.value(forKey: "read_count") as? String ?? "0")!
                count = count + c
                }
                print(count,"<<<< UNREAD MSG COUNT>>>>")
            }
        }catch{
            print("error executing request")
        }
        
    }
    
    func sendLanguagesSelected() {
        
        
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        let language1 = UserDefaults.standard.string(forKey: "Language1") // app
        let language2 = UserDefaults.standard.string(forKey: "Language2") // pri
        let language3 = UserDefaults.standard.string(forKey: "Language3") // sec

        
        var params =  Dictionary<String, String>()
        if language1 != nil && language2 != nil && language2 != nil
        {
            
            params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientID)","appLanguage":"\(language1!)","clientLanguage":"\(language2!)","learningLanguage":"\(language3!)"] as Dictionary<String, String>
            print(params)
            

            MakeHttpPostRequest(url: saveLanguageSelected, params: params, completion: {(success, response) -> Void in
                print(response)
                
                
                DispatchQueue.main.async {

                self.GetUserInfo()
                    
                }

                
            }, errorHandler: {(message) -> Void in
                
                DispatchQueue.main.async {
                self.GetUserInfo()
                }

            })
            
        }else{
            
            self.GetUserInfo()

        }
        
    }
    
    func sendFcm() {
       
       // self.checkChatConnection()
        self.getUnreadChatCount()
        
        var params =  Dictionary<String, String>()
      
        let userID = UserDefaults.standard.integer(forKey: "userid")
        var fcm = UserDefaults.standard.string(forKey: "fcm")

        if fcm == nil {
            
            fcm = ""
        }

        params = ["access_token":"\(accessToken)","deviceId":"","deviceType":"iPhone","deviceInfo":"","deviceToken":"\(fcm!)","userId":"\(userID)"] as Dictionary<String, String>
        print(params)
        
        MakeHttpPostRequest(url: saveDeviceToken, params: params, completion: {(success, response) -> Void in
            print(response)
            
            
        }, errorHandler: {(message) -> Void in
            
        })
        
    }
    
    func checkChatConnection(){
        
        if OneChat.sharedInstance.isConnected() {
        } else {
            
            print(USERDETAILS)
            
            OneChat.sharedInstance.connect(username: "\(USERDETAILS.mobile)@13.232.161.176", password: USERDETAILS.mobile) { (stream, error) -> Void in
                if let error = error {
                    
                    print("not connected to chat",error)
                   
                } else {
                    
                    print("You are online")
                }
            }
        }
  }
    
}
