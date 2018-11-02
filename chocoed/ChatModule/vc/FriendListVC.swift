//
//  FriendListVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class FriendListVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var arrayFriends = [FriendListChat]()

    @IBOutlet var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let params = ["name":"Mahesh Nikam","last_msg_time":"Yesterday","last_msg":"Hello How are you","friendImage":"","lastMsgTypeImage":"","count":"","userId":"7774960386"] as Dictionary<String, String>
        
        self.arrayFriends.append(FriendListChat(params as NSDictionary))
        
        self.checkChatConnection()
        
    }
    
    func checkChatConnection(){
    
    if OneChat.sharedInstance.isConnected() {
    
    
    } else {
    
    OneChat.sharedInstance.connect(username: kXMPP.myJID, password: kXMPP.myPassword) { (stream, error) -> Void in
            if let error = error {
    
                    let alertController = UIAlertController(title: "Sorry", message: "An error occured: \(error)", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
                    //do something
                    self.checkChatConnection()
                    
                        }))
                self.present(alertController, animated: true, completion: nil)
    
    } else {
    
                    print("You are online")
            }
        }
    }
 }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back_btn_clicked(_ sender: UIButton) {

        dismiss(animated: false, completion: nil)
    }
    
    
    // Mark: UITableView Delegates
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        cell.name.text=arrayFriends[indexPath.row].name
       // cell.last_msg.text=arrayFriends[indexPath.row].last_msg
        cell.last_msg_time.text=arrayFriends[indexPath.row].last_msg_time
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC {
            vcNewSectionStarted.friendModel = self.arrayFriends[indexPath.row]
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
        
    }
  
}
