//
//  UsersOfNGOViewController.swift
//  chocoed
//
//  Created by Tejal on 03/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class UsersOfNGOViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ngoId : String = ""

    
    var arrayUsersList = [getNgoUserDetails]()
    var activityUIView: ActivityIndicatorUIView!

    @IBOutlet weak var tableViewNgoUser: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        loadNgoUserList()
        // Do any additional setup after loading the view.
    }

    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ngoNominee") as? NominationOfNGOViewController
        self.present(vc!, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUsersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userngocell") as! UserNGOTableViewCell
        
        cell.mobileLabel.text = arrayUsersList[indexPath.row].occupation
        cell.nameLabel.text = "\(arrayUsersList[indexPath.row].firstName) \(arrayUsersList[indexPath.row].lastName)"
        let fileUrl = URL(string: arrayUsersList[indexPath.row].profileImageUrl)
        if arrayUsersList[indexPath.row].profileImageUrl != "" {
            if let data = try? Data(contentsOf: fileUrl!) {
                if let image = UIImage(data: data) {
                    cell.imageName.contentMode = .scaleAspectFit
                    cell.imageName.image = image
                }
            }
        }
        return cell

    }
    
    func loadNgoUserList(){
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        print(userID, "USER ID IS HERE")
        //let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        let params = ["userId": "\(userID)","clientId": "\(clientID)",  "access_token":"\(accessToken)","ngoId": "\(self.ngoId)" ] as Dictionary<String, String>
        
        print(params)
        
        
        MakeHttpPostRequest(url: getNGOUserList, params: params, completion: {(success, response) -> Void in
            print(response)
            
            let list = response.object(forKey: "list") as? NSArray ?? []
            
            for NgoUser in list {
                self.arrayUsersList.append(getNgoUserDetails( NgoUser as! NSDictionary))
            }
            DispatchQueue.main.async {
                self.tableViewNgoUser.reloadData()
//                self.activityUIView.isHidden = true
//                self.activityUIView.stopAnimation()
            }
            
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
//                self.activityUIView.isHidden = true
//                self.activityUIView.stopAnimation()
                
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       /* let vc = storyboard?.instantiateViewController(withIdentifier: "nomineeView") as? NomineeDetailsViewController
        self.present(vc!, animated: true, completion: nil)
      */
        
        self.NominateUser(item: self.arrayUsersList[indexPath.row])
        
    }
    
    
    private func showALert(){
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        let alertcontrol = UIAlertController(title: "AlertKey".localizableString(loc: language!), message: "alertFieldsFilled".localizableString(loc: language!), preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "OkKey".localizableString(loc: language!), style: .default) { (action) in
        }
        alertcontrol.addAction(alertaction)
        self.present(alertcontrol, animated: true, completion: nil)
    }
    
    func NominateUser(item : getNgoUserDetails ){
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let firstname = item.firstName
        let lastName = item.lastName
        let age = item.age
        let mobileno = item.mobileNumber
        let govtId = item.govtId
        
      /*  if firstname.count == 0
        {
            self.showALert()
        }
        
        if lastName.count == 0
        {
            self.showALert()
        }
        
        if age.count == 0
        {
            self.showALert()
        }
        
        if mobileno.count == 0
        {
            self.showALert()
        }
        
        if govtId.count == 0
        {
            self.showALert()
        }
        
        if item.occupation.count == 0{
            
            self.showALert()
            
        }
        
        if item.learningLanguage.count == 0{
            
            self.showALert()
            
        } */
        
        
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)", "firstName": "\(firstname)", "lastName": "\(lastName)", "age": "\(age)", "govId" : "\(govtId)", "occupation": "\(item.occupation)", "learningLanguage" : "\(item.learningLanguage)", "mobileNumber" : "\(mobileno)", "ngoId": item.ngoId,"nominationUserId":item.userID] as Dictionary<String, String>
        
        print(params)
        
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: nominateUser, params: params, completion: {(success, response) -> Void in
            print(response)
            DispatchQueue.main.async {
                
                
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                
                let language = UserDefaults.standard.string(forKey: "currentlanguage")
                let alertView = UIAlertController(title: "AlertKey".localizableString(loc: language!), message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName), \("nominatethankKey".localizableString(loc: language!))", preferredStyle: .alert)
                
                
                let action = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                    
                    let dashboardvc = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                    DispatchQueue.main.async {
                        let aObjNavi = UINavigationController(rootViewController: dashboardvc)
                        aObjNavi.navigationBar.barTintColor = UIColor.blue
                        self.present(aObjNavi, animated: true, completion: nil)
                    }
                    
                   })
                
                
                alertView.addAction(action)
                self.present(alertView, animated: true, completion: nil)
                
                
                
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
