//
//  UsersOfNGOViewController.swift
//  chocoed
//
//  Created by Tejal on 03/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class UsersOfNGOViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arrayUsersList = [getNgoUserDetails]()
    var activityUIView: ActivityIndicatorUIView!

    @IBOutlet weak var tableViewNgoUser: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
//        self.view.addSubview(activityUIView)
//        activityUIView.isHidden = true
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
        
        cell.mobileLabel.text = arrayUsersList[indexPath.row].mobileNumber
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
        let params = ["userId": "\(userID)","clientId": "\(clientID)",  "access_token":"\(accessToken)","ngoId": "\(1)" ] as Dictionary<String, String>
        
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
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nomineeView") as? NomineeDetailsViewController
        self.present(vc!, animated: true, completion: nil)
        
        
    }
        
}
