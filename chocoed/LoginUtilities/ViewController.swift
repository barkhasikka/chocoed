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
    var count = 0
    
    var arrayLanguages = [LanguageList]()
        //["English","Hindi हिंदी","Gujarati ગુજરાતી","Marathi मराठी ","Tamil  தமிழ்","Telugu తెలుగు","Kannada ಕನ್ನಡ","Konkani","Malayalam മലയാളം","Bengali বাঙালি","Oriya ଓଡ଼ିଆ"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        constraintsOFUI()
        self.viewTable.isHidden = true
        count = 0
        self.tableViewLanguage.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
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
        self.count = 0
        self.viewTable.isHidden = false
        self.tableViewLanguage.isHidden = false
        loadGetLanguageList()

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return arrayLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LanguageTableViewCell
        
        cell.labelLanguage.text = "\(arrayLanguages[indexPath.row].dbname) \(arrayLanguages[indexPath.row].langDispalyName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = arrayLanguages[indexPath.row].dbname
        print(text)
        if count == 0 {
            let alertcontrol = UIAlertController(title: "Alert", message: "Would you like to use \(text) for learning language?", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "No", style: .default) { (action) in
                self.count = 1
                UserDefaults.standard.set(text, forKey: "Language1")

            }
            let alertaction1 = UIAlertAction(title: "Yes", style: .default) { (action) in
                self.viewTable.isHidden = true
                self.count = 0
                self.signUpButton.setTitle("\(text)", for: .normal)
                
                UserDefaults.standard.set(text, forKey: "Language1")
                
                UserDefaults.standard.set(text, forKey: "Language2")
            }
            alertcontrol.addAction(alertaction)
            alertcontrol.addAction(alertaction1)
            self.present(alertcontrol, animated: true, completion: nil)
        } else {
            self.viewTable.isHidden = true
            let userAppLang = UserDefaults.standard.string(forKey: "Language1")
            print(userAppLang)
            self.signUpButton.setTitle("\(userAppLang!)", for: .normal)
            UserDefaults.standard.set(text, forKey: "Language2")
        }
        
    }
    
    func loadGetLanguageList()
    {
        let clientid = UserDefaults.standard.string(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid)","clientId":"\(clientid)"] as Dictionary<String, String>
        MakeHttpPostRequest(url: getLanguageListCall, params: params, completion: {(success, response) -> Void in
            print(response)
            let language = response.object(forKey: "appList") as? NSArray ?? []

            for languages in language {
                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
               
            }
            DispatchQueue.main.async {
                self.tableViewLanguage.reloadData()
            }
                print(self.arrayLanguages)
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        })
        
    }
    
    }

