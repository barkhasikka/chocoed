//
//  AddContactViewController.swift
//  chocoed
//
//  Created by Tejal on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var activityUIView: ActivityIndicatorUIView!
    var arrayContactList = [FriendList]()
    var arrayUpdateFriendList = [FriendListUpdate]()
    @IBOutlet weak var tableViewCOntacts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            for (index, addcontacts) in list.enumerated() {
                self.arrayContactList.append(FriendList(addcontacts as! NSDictionary))
                
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
        var url = arrayContactList[indexPath.row].friendImageUrl
        var fileUrl = URL(string: url)
        if fileUrl != nil{
        if let data = try? Data(contentsOf: fileUrl!) {
            if let image = UIImage(data: data) {
                cell.imageOfContact.image = image
            }
            }
        }
        
        cell.labelId.text = "\(arrayContactList[indexPath.row].friendId)"
       // print(arrayContactList[indexPath.row].friendId)
        return cell

    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let addContactItem = ["friendId": "\(String(arrayContactList[indexPath.row].friendId))", "friendName": "\(String(arrayContactList[indexPath.row].friendName))"] as Dictionary<String, String>
        
        let params = ["access_token":"\(accessToken)","deviceType":"Android","userId":"\(userID)","clientId":"\(clientID)","list":[addContactItem]] as Dictionary<String, Any>
        print(params)
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: updateMyProgressFriend , params: params, completion: {(success, response) -> Void in
            print(response)
            
            let list = response.object(forKey: "list") as? NSArray ?? []
            for (index, contacts) in list.enumerated() {
                self.arrayUpdateFriendList.append(FriendListUpdate(contacts as! NSDictionary))
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
