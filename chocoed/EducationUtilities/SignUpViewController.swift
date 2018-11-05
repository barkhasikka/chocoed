//
//  SignUpViewController.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableViewData =  [ExistingEducationList]()

    
    @IBOutlet weak var firstStepLabel: UILabel!
    
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var nextButtonLabel: UIButton!
    @IBOutlet weak var educationDetailsTableView: UITableView!
    @IBOutlet weak var viewEdu: UIView!
    @IBOutlet weak var addeducationButton: UIButton!
    var workExperiences: NSArray = []
    var activityUIView: ActivityIndicatorUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        self.educationLabel.text = "शिक्षा".localizableString(loc: language!)
        //self.signUpButton.titleLabel?.text = "SignUpKey".localizableString(loc: StringLang)
        // self.loginButton.titleLabel?.text = "LoginButtonKey".localizableString(loc: StringLang)
        
        // self.signUpButton.setTitle("\("SignUpKey".localizableString(loc: StringLang))", for:.normal )
        self.workLabel.text = "कार्य".localizableString(loc: language!)
        self.firstStepLabel.text = "आप पहले पायदान पर हो".localizableString(loc: language!)
        self.nextButtonLabel.setTitle("आगे".localizableString(loc: language!), for: .normal)
        self.addeducationButton.setTitle("नई शिक्षा दर्ज करें".localizableString(loc: language!), for: .normal)

       // viewEdu.isHidden = false
        addeducationButton.setTitle("नई शिक्षा दर्ज करें", for: .normal)
        addeducationButton.backgroundColor = .clear
        addeducationButton.layer.cornerRadius = 10
        addeducationButton.layer.borderWidth = 1
        addeducationButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) -> Void in
            print(response)
            let jsonobject = response["info"] as? NSDictionary;
            self.workExperiences = jsonobject?["userEducationList"] as? NSArray ?? []
            
            for experience in self.workExperiences {
                self.tableViewData.append(ExistingEducationList(experience as! NSDictionary))
            }

            DispatchQueue.main.async {
                self.educationDetailsTableView.reloadData()
                
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
        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool{
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewEducationAction(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "neweducation") as! NewEducationExperienceVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        
        
        let vcnext = storyboard?.instantiateViewController(withIdentifier: "work") as! WorkExpClickedViewController
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(vcnext, animated: false, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "existingeducationcell") as! ExistingEducationTableViewCell
        print(tableViewData)
        cell.labelQualification.text = tableViewData[indexPath.row].name
        cell.labelInstitute.text = tableViewData[indexPath.row].field
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.workExperiences[indexPath.row])
        let data = EducationFields(self.workExperiences[indexPath.row] as! NSDictionary)
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "neweducation") as! NewEducationExperienceVC
        nextViewController.selectedEducation = data
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    

}
