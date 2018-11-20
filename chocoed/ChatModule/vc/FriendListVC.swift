//
//  FriendListVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import SDWebImage
import XMPPFramework



class FriendListVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate , OneMessageDelegate {
    
    
    
    @IBOutlet var btnDestructive: UIButton!
    
    @IBOutlet var lblNoFriendFound: UILabel!
    
    func oneStream(_ sender: XMPPStream, didReceiveMessage message: XMPPMessage, from user: XMPPUserCoreDataStorageObject) {
        
        //self.tblView.reloadData()
        
        
    }
    
    func oneStream(_ sender: XMPPStream, didReceiptReceive message: XMPPMessage, from user: XMPPUserCoreDataStorageObject) {
        
       // self.tblView.reloadData()

        
    }
    
    func oneStream(_ sender: XMPPStream, userIsComposing user: XMPPUserCoreDataStorageObject) {
        
        let userData = (user.jidStr)!.components(separatedBy: "@")
        let friendID = userData[0]
        print(friendID)
        
        self.updateFriendTyping(friendID: friendID,typing : "yes")

        
    }
    
    func updateFriendTyping(friendID : String, typing: String){
        
        // update friend profile
        
        print(friendID)
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", friendID)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
             
                updatObj.setValue(typing, forKey: "is_typing")
               
                do{
                    try context.save()
                    
                    self.tblView.reloadData()
                    
                }catch{
                    print("Error in update")
                }
            }
            
        }catch{
            print("error executing request")
        }
        
        
    }
    
    

    private let cellID = "FriendCell"
    
    
    
    @IBOutlet var lblTitle: UILabel!
    
    
    var selectedArray = [Msg]()
  
    var type = ""
    
    
    @IBOutlet var tblView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Friends.self))
        
     
    
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "last_msg_time", ascending: false)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.type == "" {
            
            self.lblTitle.text = "Chat"
        }
        
        self.tblView.reloadData()
    }
    
    
    
    
    @IBAction func add_friend(_ sender: Any) {
        
        
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "AddFriendVC") as? AddFriendVC{
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func notification_clicked(_ sender: Any) {
        
        
    }
    
    
    @IBAction func destructive_mg_clicked(_ sender: Any) {
       self.lblTitle.text = "Send To..."
       self.type = "destructive"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.type == "forward"{
            
            self.lblTitle.text = "Forward to..."
            
        }else if self.type == "destructive"{
            
            self.lblTitle.text = "Send to..."
            
        }else{
            
            self.lblTitle.text = "Chat"

        }
        
        OneMessage.sharedInstance.delegate = self

       // let params = ["name":"Mahesh Nikam","last_msg_time":"Yesterday","last_msg":"Hello How are you","friendImage":"","lastMsgTypeImage":"","count":"","userId":"7774960386"] as Dictionary<String, String>
       // self.arrayFriends.append(FriendListChat(params as NSDictionary))
        
        self.checkChatConnection()
        self.searchBar.delegate = self
        self.lblNoFriendFound.isHidden = true

    
      //  self.tblView.register(FriendCell.self, forCellReuseIdentifier: cellID)
        do {
            try self.fetchedhResultController.performFetch()
            self.tblView.reloadData()
        } catch let error  {
            print("ERROR: \(error)")
        }
        
        self.registerToChat()
        
        let longPressRec = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressRec.minimumPressDuration = 1.0
        self.tblView.addGestureRecognizer(longPressRec)
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error{
                print("<<<<< Error in FCM >>>>>>",error)
            }else if let result = result {
                UserDefaults.standard.set(result.token, forKey: "fcm")
                print(result.token , "<<<<< FCM >>>>>>")
            }
        }
     
    }
    
    
    @objc func longPress(longPressGesture : UILongPressGestureRecognizer) {
        
        if longPressGesture.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressGesture.location(in : self.tblView)
            
            if let indexPath = self.tblView.indexPathForRow(at: touchPoint){
                
                print(indexPath.row)
                
                self.openOptionForCell(row : indexPath)
            }
        }
    }
    
    func openOptionForCell(row : IndexPath){
        
        let alert:UIAlertController=UIAlertController(title: "Choose Option", message: nil, preferredStyle:.actionSheet)
      
        let copyAction = UIAlertAction(title: "Profile", style: .default) {
            UIAlertAction in
          
            if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
                
                let item = self.fetchedhResultController.object(at: row) as? Friends
                vcNewSectionStarted.name = (item?.name)!
                vcNewSectionStarted.profileiMage = (item?.profile_image)!
                vcNewSectionStarted.contactMobileNumber = (item?.contact_number)!
                self.present(vcNewSectionStarted, animated: true, completion: nil)
            }
            
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete Chat", style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            
            let item = self.fetchedhResultController.object(at: row) as? Friends
            self.clearData(number: (item?.contact_number)!)
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
        }
        
   
        alert.addAction(copyAction)
        alert.addAction(deleteAction)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func checkChatConnection(){
    
    if OneChat.sharedInstance.isConnected() {
    
    
    } else {
    
        OneChat.sharedInstance.connect(username: "\(USERDETAILS.mobile)@13.232.161.176", password: USERDETAILS.mobile) { (stream, error) -> Void in
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
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            if count == 0{
                self.lblNoFriendFound.isHidden = false
                self.tblView.isHidden = true
                self.searchBar.isHidden = true
                self.btnDestructive.isHidden = true
            }else{
                self.lblNoFriendFound.isHidden = true
                self.tblView.isHidden = false
                self.searchBar.isHidden = false
                self.btnDestructive.isHidden = false

            }
            return count
        }
        
        self.lblNoFriendFound.isHidden = false
        self.tblView.isHidden = true
        self.searchBar.isHidden = true
        self.btnDestructive.isHidden = true

        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FriendCell
       
        if let item = fetchedhResultController.object(at: indexPath) as? Friends {
        
            print(item.last_msg_time)
            cell.lblFriendName?.text = item.name
            
            
            
            
           /* let imgAttachement = NSTextAttachment()
            imgAttachement.image = UIImage(named: "ic_arrow_left")
            let imageOffset : CGFloat = -5.0
            imgAttachement.bounds = CGRect(x: 0, y: imageOffset, width: (imgAttachement.image?.size.width)!, height: (imgAttachement.image?.size.height)!)
            let attachementString = NSAttributedString(attachment: imgAttachement)
            let  completetext = NSMutableAttributedString(attributedString: attachementString)
            
            let textaftericon = NSMutableAttributedString(string: item.last_msg)
            
            completetext.append(textaftericon)
            
            //cell.last_msg?.textAlignment = .r
            cell.last_msg?.attributedText = completetext */
            
            if item.last_msg_time != ""{
                
                cell.last_msg_time?.text = Utils.getDateFromString(date : item.last_msg_time)
           
            }else{
                 cell.last_msg_time?.text = ""
            }
            
            
            cell.read_count?.text = item.read_count
            cell.read_count?.layer.cornerRadius = 6


            if item.read_count == "" || item.read_count == "0" {
                cell.read_count?.isHidden = true
            }else{
                cell.read_count?.isHidden = false
            }
            
            if item.is_typing == "" || item.is_typing == "no" {
                
                cell.last_msg?.text = item.last_msg
                cell.last_msg?.textColor = UIColor.darkGray


            }else{
                
                cell.last_msg?.text = "Typing..."
                cell.last_msg?.textColor = UIColor.blue
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    
                    self.updateFriendTyping(friendID: item.contact_number,typing : "no")
                    
                })

            }
            
        
            if item.is_mine == "1"{
                
                cell.lastMsgImage.isHidden = false
                
                
                if item.last_msg_ack == kXMPP.msgSend{
                    
                    cell.lastMsgImage.image = UIImage(named: "send_gray_icon")
                    
                }else  if item.last_msg_ack == kXMPP.msgSent{
                    
                    cell.lastMsgImage.image = UIImage(named: "receive_gray_icon")
                    
                    
                }else  if item.last_msg_ack == kXMPP.msgSeen{
                    
                    cell.lastMsgImage.image = UIImage(named: "read_blue_icon")
                    
                }else{
                    
                    cell.lastMsgImage.isHidden = true

                }
                

            }else{
                
                cell.lastMsgImage.isHidden = true
            }
            
            


            cell.friendImage?.sd_setImage(with : URL(string: item.profile_image))
            cell.friendImage?.layer.cornerRadius = (cell.friendImage?.frame.width)! / 2
            cell.friendImage?.clipsToBounds = true
            cell.friendImage?.contentMode = .scaleToFill
        
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC {
            let item = fetchedhResultController.object(at: indexPath) as? Friends
            vcNewSectionStarted.friendModel = item
            vcNewSectionStarted.type = self.type
            vcNewSectionStarted.selectedArr = self.selectedArray
            
            self.type = ""
            if self.selectedArray.count > 0 {
                self.selectedArray.removeAll()
            }
            
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
        
    }
    
    
    /*** API CALLS ***/
    /* 1. Register User */
    
    private func registerToChat(){
        
        
        
        var fcm = UserDefaults.standard.string(forKey: "fcm")
        
        if fcm == nil {
            
            fcm = "1234"
        }

        
      
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        let params = ["user_name": "\(USERDETAILS.firstName) \(USERDETAILS.lastname)",  "user_contact_no":"\(USERDETAILS.mobile)",  "fcm_id":"\(fcm!)","user_photo":"\(USERDETAILS.imageurl)","user_email":"\(USERDETAILS.email)","password":"\(USERDETAILS.mobile)","device":"Ios"] as Dictionary<String, String>
        print(params)
        MakeHttpPostRequestChat(url: kXMPP.registerUSER, params: params, completion: {(success, response) in
            
            print(response)
            
            let jsonobject = response["data"] as? NSDictionary;
            let chatUserID = jsonobject?.object(forKey: "user_id") as? String ?? ""
            print(chatUserID,"<<<<< CHAT USER ID>>>>")
            
            UserDefaults.standard.set(chatUserID, forKey: "chat_user_id")

            
            
            let list = response.object(forKey: "friend_list") as? NSArray ?? []
            
            for (index, friend) in list.enumerated() {
                let item = FriendListChat(friend as! NSDictionary)
                
                self.createFriendEntityFrom(item: Friend(
                    created: "",
                    contact_number: item.user_contact_no,
                    fcm_id: "",
                    is_mine: "0",
                    is_typing: "0",
                    last_msg: "",
                    last_msg_type: "",
                    last_msg_time: "",
                    modified: "",
                    name: item.user_name,
                    profile_image: item.user_photo,
                    read_count: "0",
                    status: "",
                    user_id: item.user_id,
                    last_msg_ack : ""
                    ))
                
            }
            
           
            
        }, errorHandler: {(message) -> Void in
            print("message", message)
            
            DispatchQueue.main.async {
            }
            
        })
                
        
    }
    
    
    /**** CORE DATA ****/
    
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
                    try context.save()
                    
                }catch{
                    print("Error in update")
                }
            }
           
 
            
        }catch{
            print("error executing request")
        }
        
        return results.count > 0
    }
    
   
    private func createFriendEntityFrom(item: Friend) {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if isFriendPrsent(item: item) == false {
        
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
        }
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
        
        
        }
        
    }
    
    private func clearData(number : String) {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Msg.self))
            fetchRequest.predicate = NSPredicate(format: "to_id == %@",number)
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                
                for item in objects!{
                    context.delete(item)
                }
                
                self.updateFriendCell(friendID: number)
          
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    func updateFriendCell(friendID : String){
        
        // update friend profile
        
        print(friendID)
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", friendID)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
                
                var count = updatObj.value(forKey: "read_count") as? Int ?? 0
                count = count + 1
                
                updatObj.setValue("", forKey: "last_msg")
                updatObj.setValue("", forKey:"last_msg_type")
                updatObj.setValue("", forKey:"last_msg_time")
                updatObj.setValue("", forKey:"last_msg_ack")
                updatObj.setValue("1", forKey:"is_mine")
                updatObj.setValue("0", forKey: "read_count")
                
                do{
                    try context.save()
                    
                    self.tblView.reloadData()
                    
                }catch{
                    print("Error in update")
                }
            }
            
        }catch{
            print("error executing request")
        }
        
        
    }
    

    
    public static func getCurrentTime() -> String {
        let messageID = Int64(NSDate().timeIntervalSince1970 * 1000)
        return String(messageID)
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        
        
        do {
            
           self.fetchedhResultController.fetchRequest.predicate =  nil
            
           // self.fetchedhResultController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "last_msg_time", ascending: true)]
        
            try self.fetchedhResultController.performFetch()
            self.tblView.reloadData()
        } catch let error  {
            print("ERROR: \(error)")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
         do {
            
            self.fetchedhResultController.fetchRequest.predicate =  NSPredicate(format: "name CONTAINS %@", searchText)
            
             try self.fetchedhResultController.performFetch()
            self.tblView.reloadData()
        } catch let error  {
            print("ERROR: \(error)")
        }
    }
    
    /**** API Call *****/
    
  
}


extension FriendListVC: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            self.tblView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            self.tblView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tblView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tblView.beginUpdates()
    }
}

