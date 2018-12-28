//
//  AddContactViewController.swift
//  chocoed
//
//  Created by Tejal on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var addFriend: UILabel!
    
    @IBOutlet weak var save: UIButton!
    
    var activityUIView: ActivityIndicatorUIView!
    var arrayContactList = [FriendList]()
   // var arrayUpdateFriendList = [FriendListUpdate]()
    @IBOutlet weak var tableViewCOntacts: UITableView!
    var contactArrayIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
         let language = UserDefaults.standard.string(forKey: "currentlanguage")
        self.addFriend.text = "AddFriendsKey".localizableString(loc: language!)
        self.save.setTitle("saveButtonKey".localizableString(loc: language!), for: .normal)
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        LoadContacts()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackButtonAction(_ sender: Any) {
        let backVcContactView = self.storyboard?.instantiateViewController(withIdentifier: "leader") as! LeaderBoardViewController
        
        self.present(backVcContactView, animated: true, completion: nil)
       
    }
    
    @IBAction func DoneAction(_ sender: Any) {
        uploadAddContactData()
    }
    func LoadContacts()
    {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let params = ["access_token":"\(accessToken)","deviceType":"Android","userId":"\(userID)","clientId":"\(clientID)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: friendList , params: params, completion: {(success, response) -> Void in
            print(response)
            let list = response.object(forKey: "list") as? NSArray ?? []
           /*  for (index, addcontacts) in list.enumerated() {
                let friendObject = FriendList(addcontacts as! NSDictionary)
               
                //if(friendObject.selected != 1) {
                    self.arrayContactList.append(FriendList(addcontacts as! NSDictionary))
               // }
            } */
            
            for pg in list {
                self.arrayContactList.append(FriendList( pg as! NSDictionary))
            }
            DispatchQueue.main.async {
                self.tableViewCOntacts.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayContactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addContactsCell", for: indexPath) as! LeaderBoardAddContactTableViewCell
        cell.labelName.text = arrayContactList[indexPath.row].friendName
        let url = arrayContactList[indexPath.row].friendImageUrl
        
        print(arrayContactList[indexPath.row].selected)
        
        if arrayContactList[indexPath.row].selected == true {
            cell.checkUncheckImageView.image = UIImage(named: "icons8-checked_filled-1")
        }
        else{
            cell.checkUncheckImageView.image = UIImage(named: "icons8-circle_filled_75")
        }
        
       
        let fileUrl = URL(string: url)
        if fileUrl != nil {
            if let data = try? Data(contentsOf: fileUrl!) {
                if let image = UIImage(data: data) {
                    cell.imageOfContact.image = image
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       // self.arrayUpdateFriendList.append(FriendListUpdate(id: arrayContactList[indexPath.row].friendId, name: arrayContactList[indexPath.row].friendName))
        
        
        if self.arrayContactList[indexPath.row].selected == true {
            
           self.arrayContactList[indexPath.row].selected = false
            
        }else {
            
            self.arrayContactList[indexPath.row].selected = true
        }
        tableView.reloadData()

    }
    
    func uploadAddContactData(){
                let userID = UserDefaults.standard.integer(forKey: "userid")
                let clientID = UserDefaults.standard.integer(forKey: "clientid")
                var someArray = [Any]()

                for item in arrayContactList{
                    
                    if item.selected == true {
                    
                        let addContactItem = ["friendId": Int(item.friendId)] as! Dictionary<String, Int>
                        someArray.append(addContactItem)
                        
                    }
                }
        
        
        
        if someArray.count > 4 {
            let language = UserDefaults.standard.string(forKey: "currentlanguage")
            let alert = GetAlertWithOKAction(message: "add4FriendsKey".localizableString(loc: language!))
            self.present(alert, animated: true, completion: nil)
        }
        
        var poststring = ""
        do{
            
            let postdat = try JSONSerialization.data(withJSONObject: someArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            poststring = String(data : postdat,encoding : .utf8)!

            
        }catch{
            
        }
        
        
        poststring = String(poststring.filter {!" \n\t\r".contains($0)})
        poststring = poststring.replacingOccurrences(of: "'\'", with: "")

       // poststring = poststring.replaceSubrange("\r", with: "")
        
        
        //print(poststring.replaceSubrange("\n", with: ""))
        
                let params = ["access_token":"\(accessToken)","userId":"\(userID)","clientId":"\(clientID)","list":poststring ] as Dictionary<String, Any>
                print(params)
                activityUIView.isHidden = false
                activityUIView.startAnimation()
                MakeHttpPostRequest(url: updateMyProgressFriend , params: params, completion: {(success, response) -> Void in
                    print(response)
                    
                    DispatchQueue.main.async {
                        //self.tableViewCOntacts.reloadData()
                        self.activityUIView.isHidden = true
                        self.activityUIView.stopAnimation()
                        self.dismiss(animated: true, completion: nil)
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
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
