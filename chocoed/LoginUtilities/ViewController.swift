//
//  ViewController.swift
//  chocoed
//
//  Created by barkha sikka on 17/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var viewTable: UIView!
    @IBOutlet weak var tableViewLanguage: UITableView!
    @IBOutlet weak var imageViewChocoed: UIImageView!
    @IBOutlet weak var labelChoice: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    var activityUIView: ActivityIndicatorUIView!
    var count = 0
    
    @IBOutlet weak var labelLangChange: UILabel!
    var arrayLanguages = [LanguageList]()
        //["English","Hindi हिंदी","Gujarati ગુજરાતી","Marathi मराठी ","Tamil  தமிழ்","Telugu తెలుగు","Kannada ಕನ್ನಡ","Konkani","Malayalam മലയാളം","Bengali বাঙালি","Oriya ଓଡ଼ିଆ"]
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintsOFUI()
        
        backgroundImageToView()
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        self.viewTable.isHidden = true
        count = 0
        self.tableViewLanguage.isHidden = true
        self.signUpButton.isHidden = true
        self.loadGetLanguageList()
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.LanguageChanged()
    }
    
    override var shouldAutorotate: Bool{
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonAction(_ sender: Any) {

        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        viewTable.isHidden = true
        
    }
    @IBAction func signUpButtonAction(_ sender: Any) {
       
        //self.count = 0
        //self.viewTable.isHidden = false
        //self.tableViewLanguage.isHidden = false
        // loadGetLanguageList()
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
        nextViewController.type = "app"
        nextViewController.back = "app"
        self.present(nextViewController, animated:true, completion:nil)

    }
    
    func constraintsOFUI()
    {
        imageViewChocoed?.translatesAutoresizingMaskIntoConstraints = false
        imageViewChocoed.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewChocoed.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageViewChocoed.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
      //  imageViewChocoed.bottomAnchor.constraint(equalTo: labelChoice.topAnchor, constant: 8).isActive = true
        imageViewChocoed.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        labelChoice.translatesAutoresizingMaskIntoConstraints = false
        labelChoice.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        labelChoice.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90).isActive =  true
//        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
//        loginButton.layer.cornerRadius = 20
//        loginButton.clipsToBounds = true
//        loginButton.layer.borderWidth = 1
//        loginButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
//        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        loginButton.topAnchor.constraint(equalTo: labelChoice.bottomAnchor, constant: 70).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        signUpButton.backgroundColor = .clear
        signUpButton.layer.cornerRadius = 20
        signUpButton.clipsToBounds = true
        
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    func backgroundImageToView(){
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return arrayLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LanguageTableViewCell
        
        cell.labelLanguage.text = "\(arrayLanguages[indexPath.row].dbname) \(arrayLanguages[indexPath.row].langDispalyName)"
        return cell
    }
    
    func LanguageChanged() {
        var language = UserDefaults.standard.string(forKey: "currentlanguage")
        if language == nil {
            language = "en"
        }
        self.labelLangChange.text = "LabelLanguageStringKey".localizableString(loc: language!)
        
        self.signUpButton.setTitle("\("SignUpKey".localizableString(loc: language!))", for:.normal )
        print(loginButton.titleLabel?.text ?? "")
        self.loginButton.setTitle("\("LoginButtonKey".localizableString(loc: language!))", for:.normal)
        self.labelChoice.text = "ChoicContectKey".localizableString(loc: language!)

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = arrayLanguages[indexPath.row].dbname
        let textL = arrayLanguages[indexPath.row].langDispalyName
        
        switch indexPath.row {
        case 2 :
            // print(LanguageChanged(StringLang: "en"))
            UserDefaults.standard.set("en", forKey: "currentlanguage")
            self.LanguageChanged()
            
            break
        case 4 :
            UserDefaults.standard.set("hi", forKey: "currentlanguage")
            self.LanguageChanged()
            break
        default:
            print("default value is selected")
            break
        }
        
        print(text)
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        if count == 0 {
            let alertcontrol = UIAlertController(title: "MyChoiceKey".localizableString(loc: language!), message: "\("PrefferedLanguageHalfKey".localizableString(loc: language!)) \(text) \("PrefferedLanguageNextHalfKey".localizableString(loc: language!))", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "No", style: .default) { (action) in
                self.count = 1
                
                UserDefaults.standard.set(text, forKey: "Language1")
                
                //UserDefaults.standard.set(textL, forKey: "first")

                
                self.viewTable.isHidden = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                  //  self.labelLangChange.text = "Please select your preferred language for learning with Chocoed"
//                    self.viewTable.isHidden = false
//                    }
                
                
            }
            let alertaction1 = UIAlertAction(title: "alertYes".localizableString(loc: language!), style: .default) { (action) in
                self.viewTable.isHidden = true
                self.count = 0
                //self.signUpButton.setTitle("\(text)", for: .normal)
                

                UserDefaults.standard.set(text, forKey: "Language1")
                //UserDefaults.standard.set(text, forKey: "Language2")
                
                UserDefaults.standard.set(textL, forKey: "first")
              //  UserDefaults.standard.set(textL, forKey: "second")

                
                let userAppLang = UserDefaults.standard.string(forKey: "first")
                //let userLearningLang = UserDefaults.standard.string(forKey: "second")
                
                  self.signUpButton.setTitle("\(userAppLang!)", for: .normal)
                // \(userLearningLang!)

                
                // self.labelLangChange.text = "Please select your preferred language for Chocoed app screens"
            }
            alertcontrol.addAction(alertaction)
            alertcontrol.addAction(alertaction1)
            self.present(alertcontrol, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: false)
        }
//        else {
//
//             UserDefaults.standard.set(text, forKey: "Language2")
//
//          //   UserDefaults.standard.set(textL, forKey: "second")
//
//
//            self.viewTable.isHidden = true
//
//            let userAppLang = UserDefaults.standard.string(forKey: "first")
//            let userLearningLang = UserDefaults.standard.string(forKey: "second")
//
//
//            self.signUpButton.setTitle("\(userAppLang!)  \(userLearningLang!)", for: .normal)
//
//            UserDefaults.standard.set(text, forKey: "Language2")
//
//
//            self.labelLangChange.text = "Please select your preferred language for Chocoed app screens"
//
//        }
        
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

            for languages in language {
                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
            }
            
            if self.arrayLanguages.count == 1 {
                DispatchQueue.main.async {
                self.signUpButton.isHidden = true
                }
                let text = self.arrayLanguages[0].dbname
                
                
                if text == "English"{
                    
                    UserDefaults.standard.set("en", forKey: "currentlanguage")
                    UserDefaults.standard.set(text, forKey: "Language1")
                    
                }else if text == "Hindi"{
                    UserDefaults.standard.set("hi", forKey: "currentlanguage")
                    UserDefaults.standard.set(text, forKey: "Language1")
                    
                }else{
                    
                    UserDefaults.standard.set("en", forKey: "currentlanguage")
                    UserDefaults.standard.set(text, forKey: "Language1")
                    
                }
                
                
                DispatchQueue.main.async {
                self.LanguageChanged()
                }
                
            }else{
                DispatchQueue.main.async {
                    self.signUpButton.isHidden = false
                }
            }
           
            
        }, errorHandler: {(message) -> Void in
            
        })
        
    }
    
    }

