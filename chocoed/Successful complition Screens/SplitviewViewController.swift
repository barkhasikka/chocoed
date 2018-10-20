//
//  SplitviewViewController.swift
//  chocoed
//
//  Created by Tejal on 05/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class SplitviewViewController: UIViewController {
    
    @IBOutlet weak var myProgressHandUIView: UIView!
    @IBOutlet weak var myThoughtsHandUIView: UIView!
    @IBOutlet weak var myChatHandUIView: UIView!
    @IBOutlet var lblTestCount: UILabel!
    
    @IBOutlet weak var myprogressConstraintOutlet: NSLayoutConstraint!
    @IBOutlet var lblBadgesCount: UILabel!
    @IBOutlet var lblTopicCount: UILabel!
    
    @IBOutlet weak var viewChoice: UIView!
    @IBOutlet weak var viewvonversation: UIView!
    @IBOutlet weak var viewContent: UIView!
    var menuvc : ViewControllerMenubar!
    var toggle = true
    var buttonProgrss = false
    var buttonThought = false
    var buttonchat = false
    var drag = ""
    @IBOutlet weak var mainviewConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var arcView: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var userProgressView: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var constraintOutlet: NSLayoutConstraint!
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myThoughtsHandUIView.isHidden = true
        self.myProgressHandUIView.isHidden = true
        self.heightmychat.constant = 100
        self.myChatHandUIView.applyBackground()
        self.arcView.isHidden = true
        let fileUrl = URL(string: USERDETAILS.imageurl)
        if fileUrl != nil {
            if let data = try? Data(contentsOf: fileUrl!) {
                if let image = UIImage(data: data) {
                    self.imageProfile.image = image
                }
            }
            imageProfile.layer.borderWidth = 1.0
            imageProfile.layer.masksToBounds = false
            imageProfile.layer.borderColor = UIColor.darkGray.cgColor
            imageProfile.layer.cornerRadius = imageProfile.frame.width / 2
            imageProfile.clipsToBounds = true
            imageProfile.contentMode = .center
        }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageViewLogo.isUserInteractionEnabled = true
        imageViewLogo.addGestureRecognizer(tapGestureRecognizer)
        // let backgroundImage = UIImageView(frame: frame)
        //  backgroundImage.image = UIImage(named: "dashboard_header")
        //  backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        //  self.viewButtonsCircle.insertSubview(backgroundImage, at: 0 )
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
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
    }
    
    @IBAction func MyProgressActionButton(_ sender: Any) {
        buttonProgrss = !buttonProgrss
        
        if buttonProgrss == true{
            self.view.layoutIfNeeded()
//            UIView.animate(withDuration: 1, animations: {
            self.heightprogrss.constant = 100
            self.widthMyprogrss.constant = 100
            self.myProgressHandUIView.applyBackground()
            self.heightmychat.constant = 80
            self.widthMychat.constant = 80
            
            self.heightMyThought.constant = 80
            self.widthMyThought.constant = 80
            
//            self.view.layoutIfNeeded()
//            self.myProgressButton.setImage(UIImage(named: "my" ), for: UIControlState.normal)
//            self.myProgressButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
            
            self.buttonThought = false
            self.buttonchat = false
          
//            self.mychatButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)

            
//            self.myThoughtsButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
            self.myProgressButton.isHidden = true
            self.myProgressHandUIView.isHidden = false
            
//            self.myProgressButton.centerVerticallyHere()
            
            
//            self.myProgressButton.centerVerticallyWithoutLabel()
            
//            })
        } else {
//            self.view.layoutIfNeeded()
//            UIView.animate(withDuration: 1, animations: {
            self.heightprogrss.constant = 80
            self.widthMyprogrss.constant = 80
//            self.view.layoutIfNeeded()
            self.myProgressButton.isHidden = false
            self.myProgressHandUIView.isHidden = true
//            self.myProgressButton.setImage(UIImage(named: "Icon-App-40x40" ), for: UIControlState.normal)
//            self.myProgressButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
//           self.myProgressButton.setTitle("", for: .normal)
//            })
        }
        self.mychatButton.setTitle("", for: .normal)
          self.mychatButton.setImage(UIImage(named: "Icon-App-40x40-2" ), for: UIControlState.normal)
        self.myThoughtsButton.setImage(UIImage(named: "Mythoughts" ), for: UIControlState.normal)
        self.myThoughtsButton.setTitle("", for: .normal)
        self.myThoughtsHandUIView.isHidden = true
        self.myChatHandUIView.isHidden = true
        self.myThoughtsButton.isHidden = false
        self.mychatButton.isHidden = false
//        self.myThoughtsButton.centerVerticallyHere()
//        self.mychatButton.centerVerticallyHere()
    }
    
    @IBAction func MyChatActionButton(_ sender: Any) {
        buttonchat = !buttonchat
        
        if buttonchat == true{
            self.view.layoutIfNeeded()
//            UIView.animate(withDuration: 1, animations: {
            self.heightmychat.constant = 100
            self.widthMychat.constant = 100
            
            self.myChatHandUIView.applyBackground()
            
            self.heightMyThought.constant = 80
            self.widthMyThought.constant = 80
            
            self.heightprogrss.constant = 80
            self.widthMyprogrss.constant = 80
            
            self.mychatButton.isHidden = true
            self.myChatHandUIView.isHidden = false
            
//            self.view.layoutIfNeeded()
//            self.mychatButton.setImage(UIImage(named: "my" ), for: UIControlState.normal)
//            self.mychatButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
            self.buttonThought = false
            self.buttonProgrss = false
          
//            self.myThoughtsButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
            
            
//            self.mychatButton.setTitle("Chat", for: .normal)
//            self.mychatButton.centerVerticallyHere()
//            self.mychatButton.centerVerticallyHere()
//            })
        }else{
            self.view.layoutIfNeeded()
//            UIView.animate(withDuration: 1, animations: {
            self.heightmychat.constant = 80
            self.widthMychat.constant = 80
            self.mychatButton.isHidden = false
            self.myChatHandUIView.isHidden = true
//            self.view.layoutIfNeeded()
//            self.mychatButton.setImage(UIImage(named: "Icon-App-40x40-2" ), for: UIControlState.normal)
////            self.mychatButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
//
//            self.mychatButton.setTitle("", for: .normal)
//            })
        }
        self.myProgressButton.setTitle("", for: .normal)
        self.myThoughtsButton.setTitle("", for: .normal)
        self.myProgressButton.setImage(UIImage(named: "Icon-App-40x40" ), for: UIControlState.normal)
        self.myThoughtsButton.setImage(UIImage(named: "Mythoughts" ), for: UIControlState.normal)
        self.myThoughtsHandUIView.isHidden = true
        self.myThoughtsButton.isHidden = false
        self.myProgressHandUIView.isHidden = true
        self.myProgressButton.isHidden = false
//        self.myProgressButton.centerVerticallyHere()
//        self.myThoughtsButton.centerVerticallyHere()
    }
    
    @IBAction func MyThoughtsActionButton(_ sender: Any) {
        buttonThought = !buttonThought
        
        if buttonThought == true{
            self.view.layoutIfNeeded()
//            UIView.animate(withDuration: 1, animations: {
            self.heightMyThought.constant = 100
            self.widthMyThought.constant = 100
            self.myThoughtsHandUIView.applyBackground()
            self.heightmychat.constant = 80
            self.widthMychat.constant = 80
            
            self.heightprogrss.constant = 80
            self.widthMyprogrss.constant = 80
            
//            self.view.layoutIfNeeded()
//            self.myThoughtsButton.setImage(UIImage(named: "my" ), for: UIControlState.normal)
//            self.myThoughtsButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
            self.buttonchat = false
            self.buttonProgrss = false
            
            self.myThoughtsButton.isHidden = true
            self.myThoughtsHandUIView.isHidden = false
           
//            self.myProgressButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
            
//            self.myThoughtsButton.setTitle("Thoughts", for: .normal)
//
//            self.myThoughtsButton.centerVerticallyHere()
//            self.myThoughtsButton.centerVerticallyHere()
//            })
        }else{
            self.view.layoutIfNeeded()
//            UIView.animate(withDuration: 1, animations: {
            self.heightMyThought.constant = 80
            self.widthMyThought.constant = 80
            
            self.myThoughtsButton.isHidden = false
            self.myThoughtsHandUIView.isHidden = true
//            self.view.layoutIfNeeded()
//            self.myThoughtsButton.setImage(UIImage(named: "Mythoughts"), for: UIControlState.normal)
////            self.myThoughtsButton.setBackgroundImage(UIImage(named: "card_bg"), for: .normal)
//            self.myThoughtsButton.setTitle("", for: .normal)
//
//            })
        }
        self.myProgressButton.setTitle("", for: .normal)
        self.mychatButton.setTitle("", for: .normal)
        self.mychatButton.setImage(UIImage(named: "Icon-App-40x40-2" ), for: UIControlState.normal)
        self.myProgressButton.setImage(UIImage(named: "Icon-App-40x40" ), for: UIControlState.normal)
        self.myProgressHandUIView.isHidden = true
        self.myProgressButton.isHidden = false
        self.myChatHandUIView.isHidden = true
        self.mychatButton.isHidden = false
//        self.myProgressButton.centerVerticallyHere()
//        self.mychatButton.centerVerticallyHere()

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
        self.arcView.isHidden = true
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, animations: {
            self.constraintOutlet.constant = 20
            self.mainviewConstraintOutlet.constant = 700
            self.view.layoutIfNeeded()
            })
        }else{
          
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 1, animations: {
                self.constraintOutlet.constant = 150
                self.mainviewConstraintOutlet.constant = 820
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
        
        
        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
        self.present(v1, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.GetUserInfo()
        
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
            UserDefaults.standard.set(Int(clientId), forKey: "clientid")
            USERDETAILS = UserDetails(email: temp.email, firstName: temp.firstName, lastname: temp.lastName, imageurl: url)
            
            let badesEarned =  jsonobject?.object(forKey:"badesEarned") as? Int ?? 0
            let completedTestCout =  jsonobject?.object(forKey:"completedTestCout") as? Int ?? 0
            let completedTopicCout =  jsonobject?.object(forKey:"completedTopicCout") as? Int ?? 0

            
            DispatchQueue.main.async {
                self.lblBadgesCount.text = String(badesEarned)
                self.lblTestCount.text = String(completedTestCout)
                self.lblTopicCount.text = String(completedTopicCout)
            }

            
            
            
        }, errorHandler: {(message) -> Void in
            print("message", message)
        })
    }
    
}
