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
    
    let arrayLanguages = ["English","Hindi हिंदी","Gujarati ગુજરાતી","Marathi मराठी ","Tamil  தமிழ்","Telugu తెలుగు","Kannada ಕನ್ನಡ","Konkani","Malayalam മലയാളം","Bengali বাঙালি","Oriya ଓଡ଼ିଆ"]
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintsOFUI()
        self.viewTable.isHidden = true
        
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
        self.viewTable.isHidden = false
        self.tableViewLanguage.isHidden = false
        
//        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
//        self.present(nextViewController, animated:true, completion:nil)
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
        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        loginButton.topAnchor.constraint(equalTo: labelChoice.bottomAnchor, constant: 70).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        signUpButton.backgroundColor = .clear
        signUpButton.layer.cornerRadius = 20
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
        
        cell.labelLanguage.text = arrayLanguages[indexPath.row]
        return cell
    }
}

