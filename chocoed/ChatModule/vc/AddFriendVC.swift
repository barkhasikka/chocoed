//
//  AddFriendVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 11/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

class AddFriendVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var tblView: UITableView!
    
    var activityUIView: ActivityIndicatorUIView!
    var arrayContactList = [FriendList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        LoadContacts()
    }
    
    func LoadContacts()
    {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let params = ["access_token":"\(accessToken)","userId":"\(userID)","clientId":"1"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: empList , params: params, completion: {(success, response) -> Void in
            print(response)
            let list = response.object(forKey: "list") as? NSArray ?? []
           
            for pg in list {
                self.arrayContactList.append(FriendList( pg as! NSDictionary))
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayContactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddFriendCell", for: indexPath) as! AddFriendCell
        cell.lblName.text = arrayContactList[indexPath.row].friendName
        let url = arrayContactList[indexPath.row].friendImageUrl
        
        cell.profileImage?.sd_setImage(with : URL(string: url))
        cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
        cell.profileImage?.clipsToBounds = true
        cell.profileImage?.contentMode = .scaleToFill

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = arrayContactList[indexPath.row]
        if item.mobile != "" {
            
            print(item)

            
            self.createFriendEntityFrom(item: Friend(
                created: self.getCurrentTime(),
                contact_number: item.mobile,
                fcm_id: "",
                is_mine: "0",
                is_typing: "0",
                last_msg: "",
                last_msg_type: "",
                last_msg_time: "",
                modified: "",
                name: item.friendName,
                profile_image: item.friendImageUrl,
                read_count: "0",
                status: "",
                user_id: item.friendId,
                last_msg_ack : ""))
            
        }else{
            
            let alert = GetAlertWithOKAction(message: "Invalid Mobile Number")
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
     
        
        
    }
    
    private func getCurrentTime() -> String {
        
        let messageID = Int64(NSDate().timeIntervalSince1970 * 1000)
        return String(messageID)
        
    }
    
    
       private func createFriendEntityFrom(item: Friend) {
        
       let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if isFriendPrsent(item: item) == false {
            
            
            // call api
            
          let userID =  UserDefaults.standard.string(forKey: "chat_user_id")

            let params = ["user_id": "\(userID!)",  "friend_contact_no":"\(item.contact_number)",  "img_link":"\(item.profile_image)","friend_name":"\(item.name)"] as Dictionary<String, String>
            print(params)
            MakeHttpPostRequestChat(url: kXMPP.addFriend, params: params, completion: {(success, response) in
                
                print(response)
                
              //  let jsonobject = response["responce"] as? Int ?? 0;

              //  if jsonobject == 1 {
                
                if let msgObject = NSEntityDescription.insertNewObject(forEntityName: "Friends", into: context) as? Friends {
                    
                    msgObject.contact_number = item.contact_number
                    msgObject.created = item.created
                    msgObject.fcm_id = item.fcm_id
                    msgObject.is_mine = item.is_mine
                    msgObject.is_typing = item.is_typing
                    msgObject.last_msg = item.last_msg
                    msgObject.last_msg_type = item.last_msg_type
                    msgObject.last_msg_time = item.last_msg_time
                    msgObject.modified = item.modified
                    msgObject.name = item.name
                    msgObject.profile_image = item.profile_image
                    msgObject.read_count = item.read_count
                    msgObject.status = item.status
                    msgObject.user_id = item.user_id
                    msgObject.last_msg_ack = item.last_msg_ack
                    
                }
                do {
                    try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
                    
                    self.dismiss(animated: true, completion: nil)

                    
                } catch let error {
                    print(error)
                }
                    
               /* }else{
                    
                    let alert = GetAlertWithOKAction(message: "Failed to add Friend")
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
              */
                
                
                
            }, errorHandler: {(message) -> Void in
                print("message", message)
              
                
            })
            
        }else{
            
            dismiss(animated: true, completion: nil)

        }
 
    }
    
    
    
    private func isFriendPrsent(item : Friend) -> Bool {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", item.contact_number)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
                updatObj.setValue(item.name, forKey: "name")
                updatObj.setValue(item.profile_image, forKey:"profile_image")
                
                do{
                  //  try context.save()
                }catch{
                    print("Error in update")
                }
            }
        }catch{
            print("error executing request")
        }
        
        return results.count > 0
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back_btn_clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
