//
//  LanguageVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 04/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class LanguageVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    
    @IBOutlet var tblView: UITableView!
    
    @IBAction func btnClosed(_ sender: Any) {
        
        if type == "app"{
            
            dismiss(animated: true, completion: nil)
            
        }else if type == "secondary" {
            dismiss(animated: true, completion: nil)

        }
        
    }
    
    @IBOutlet var lblTitle: UILabel!

    @IBOutlet var lblDescr: UILabel!
    
    var type = ""
    var back = ""
    var quizTaken = 0


    var activityUIView: ActivityIndicatorUIView!
    var arrayLanguages = [LanguageList]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var language = UserDefaults.standard.string(forKey: "currentlanguage")
        if language == nil {
            language = "en"
        }
        
        if type == "app"{
            self.lblTitle.text = ""
          
            self.lblDescr.text = "appLangKey".localizableString(loc: language!)
            
        }else if type == "secondary" {
            
            self.lblTitle.text = "ChoiceKey".localizableString(loc: language!)

           let userType =  UserDefaults.standard.integer(forKey: "userType")
            
            if userType == 1 {
                
                self.lblDescr.text = "secondLangKeyFirst".localizableString(loc: language!) + UserDefaults.standard.string(forKey: "Language2")! +  "secondLangKeySecond".localizableString(loc: language!)

            }else{
                
                self.lblDescr.text = "secondayLangDemoKey".localizableString(loc: language!)

            }

            
        }else if type == "firsttime"{
            self.lblTitle.text = ""
            self.lblDescr.text = "primaryLangKey".localizableString(loc: language!)
        }
    
        loadGetLanguageList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        
        cell.lblTitle.text = "\(arrayLanguages[indexPath.row].dbname) \(arrayLanguages[indexPath.row].langDispalyName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = arrayLanguages[indexPath.row].dbname
        let textL = arrayLanguages[indexPath.row].langDispalyName
        
        print(text)
        print(textL)
        
         if type == "app"{
        
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

       
            if back == "app" {
                
                dismiss(animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: false)

            }else if back == "main"{
                
                let startVC = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                let aObjNavi = UINavigationController(rootViewController: startVC)
                aObjNavi.navigationBar.barTintColor = UIColor.blue
                self.present(aObjNavi, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: false)

            }
        
            
         }else if type == "firsttime"{
            
            UserDefaults.standard.set(text, forKey: "Language2")
            self.type = "secondary"
            var language = UserDefaults.standard.string(forKey: "currentlanguage")
            if language == nil {
                language = "en"
            }
            self.lblTitle.text = "ChoiceKey".localizableString(loc: language!)
            self.lblDescr.text = "secondayLangDemoKey".localizableString(loc: language!)
            self.loadGetLanguageList()

            
         }else if type == "secondary"{
            
            UserDefaults.standard.set(text, forKey: "Language3")
            
            if back == "profile"{
                
                let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
                DispatchQueue.main.async {
                    self.present(startVC, animated: true, completion: nil)
                }
                tableView.deselectRow(at: indexPath, animated: false)

                
            }else if back == "getstarted"{
                
                
                let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "getstarted") as! GettingStartedViewController
                DispatchQueue.main.async {
                    self.present(startVC, animated: true, completion: nil)
                }
                tableView.deselectRow(at: indexPath, animated: false)

               
            }else if back == "main"{
                
                let startVC = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                let aObjNavi = UINavigationController(rootViewController: startVC)
                aObjNavi.navigationBar.barTintColor = UIColor.blue
                self.present(aObjNavi, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: false)

                
            }else if back == "quiz"{
                
                
                if self.quizTaken == 1 {
                    print("1")
                    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                    let aObjNavi = UINavigationController(rootViewController: startVC)
                    aObjNavi.navigationBar.barTintColor = UIColor.blue
                    DispatchQueue.main.async {
                        self.present(aObjNavi, animated: true, completion: nil)
                        
                    }
                    tableView.deselectRow(at: indexPath, animated: false)

                    
                } else {
                    
                    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
                    DispatchQueue.main.async {
                        self.present(startVC, animated: true, completion: nil)
                    }
                    tableView.deselectRow(at: indexPath, animated: false)

                    
                    
                }
                
            } else{
                
                dismiss(animated: true, completion: nil)
            }
            
            
        }
        
    }
    
    func loadGetLanguageList() {
        
        if self.arrayLanguages.count > 0 {
            self.arrayLanguages.removeAll()
        }
        
        var clientid = UserDefaults.standard.string(forKey: "clientid")
        var userid = UserDefaults.standard.string(forKey: "userid")
        
        if clientid == nil {
            
            clientid = ""
        }
        
        if userid == nil {
            
            userid = ""
        }
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid!)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getLanguageListCall, params: params, completion: {(success, response) -> Void in
            print(response)
            
            if self.type == "app" {
                
                let language = response.object(forKey: "appList") as? NSArray ?? []
                for languages in language {
                    self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
                    
                }
                
            }
            
            if self.type == "firsttime" {
                
                let language = response.object(forKey: "appList") as? NSArray ?? []
                for languages in language {
                    self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
                    
                }
                
            }
            
            if self.type == "secondary" {
                
                let language = response.object(forKey: "secondaryList") as? NSArray ?? []
                for languages in language {
                    self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
                    
                }
                
            }
            
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                
            }
        })
        
    }
}
