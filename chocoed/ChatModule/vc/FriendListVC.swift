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



class FriendListVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate  {
    
    
    @IBOutlet var lblNotificationCount: UILabel!
    
    
    @IBOutlet var btnDestructive: UIButton!
    @IBOutlet var lblNoFriendFound: UILabel!
    private let cellID = "FriendCell"
    @IBOutlet var lblTitle: UILabel!

    var selectedArray = [Msg]()
    var type = ""
    
    var isSearching = false

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
            self.lblTitle.text = "My Talks"
        }
        
        self.registerToChat()
        

    }
    
  
    
    @IBAction func add_friend(_ sender: Any) {
        
    
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "AddFriendVC") as? AddFriendVC{
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
        
        
    }
    
    
    @IBAction func notification_clicked(_ sender: Any) {
    
        
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "PhotoNotificationVC") as? PhotoNotificationVC{
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func destructive_mg_clicked(_ sender: Any) {
       /* self.lblTitle.text = "Send To..."
        self.type = "destructive"
        self.searchBar.isHidden = true
        self.btnDestructive.isHidden = true
         */
        
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "AddFriendVC") as? AddFriendVC{
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        lblTitle.text = "ChatKey".localizableString(loc: language!)
        lblNoFriendFound.text = "NoFriendFoundKey".localizableString(loc: language!)
        
        
        UserDefaults.standard.set("", forKey: "chatNo")
        self.lblNotificationCount.isHidden = true
        self.lblNotificationCount.layer.cornerRadius = 10
        self.lblNotificationCount.clipsToBounds =  true

        
        
        UIApplication.shared.cancelAllLocalNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        if self.type == "forward"{
            
            self.lblTitle.text = "Forward to..."
            
        }else if self.type == "destructive"{
            
            self.lblTitle.text = "Send to..."
        }else{
            self.lblTitle.text = "My Talks"
        }
        
        self.checkChatConnection()
        self.searchBar.delegate = self
        self.lblNoFriendFound.isHidden = true

    
        do {
            try self.fetchedhResultController.performFetch()
        } catch let error  {
            print("ERROR: \(error)")
        }
        
       
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
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
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
        
        if self.type != "" {
            
            
                self.type = ""
                self.lblTitle.text = "My Talks"
                self.searchBar.isHidden = false
                self.btnDestructive.isHidden = false
           
        }else{
            
            let startVC = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
            let aObjNavi = UINavigationController(rootViewController: startVC)
            aObjNavi.navigationBar.barTintColor = UIColor.blue
            self.present(aObjNavi, animated: true, completion: nil)
            
        }
    }
    
    
    // Mark: UITableView Delegates
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            if count == 0{
                
                if self.isSearching == false {
                
                self.lblNoFriendFound.isHidden = false
                self.tblView.isHidden = true
                self.searchBar.isHidden = true
                self.btnDestructive.isHidden = true
                    
                }
                
            }else{
                self.lblNoFriendFound.isHidden = true
                self.tblView.isHidden = false
                self.searchBar.isHidden = false
                self.btnDestructive.isHidden = false

            }
            return count
        }
        
        if self.isSearching == false {

        
        self.lblNoFriendFound.isHidden = false
        self.tblView.isHidden = true
        self.searchBar.isHidden = true
        self.btnDestructive.isHidden = true
        
        }

        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FriendCell
       
        if let item1 = fetchedhResultController.object(at: indexPath) as? Friends {
        
            cell.lblFriendName?.text = item1.name
            
            cell.read_count?.text = item1.read_count
            cell.read_count?.layer.cornerRadius = 10
            cell.read_count?.clipsToBounds =  true
            
            cell.friendImage?.sd_setImage(with : URL(string: item1.profile_image))
            cell.friendImage?.layer.cornerRadius = (cell.friendImage?.frame.width)! / 2
            cell.friendImage?.clipsToBounds = true
            cell.friendImage?.contentMode = .scaleToFill
            
            
            
            if item1.read_count == "" || item1.read_count == "0" {
                cell.read_count?.isHidden = true
            }else{
                cell.read_count?.isHidden = false
            }
            
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
            fetchRequest.predicate = NSPredicate(format: "to_id = %@", item1.contact_number)
            var results : [NSManagedObject] = []
            
            do{
                results = try context.fetch(fetchRequest)
                
                if results.count != 0 {
                    
                    let item = results[results.count - 1] as! Msg
                    
                    if item.created != ""{
                        cell.last_msg_time?.text = Utils.getDateFromString(date : item.created!)
                    }else{
                        cell.last_msg_time?.text = ""
                    }
                    
                    if item1.is_typing == "" || item1.is_typing == "no" {
                        
                        
                        if item.msg_type == kXMPP.TYPE_TEXT ||  item.msg_type == kXMPP.TYPE_REPLY {
                            
                            cell.last_msg?.text = item.msg
                            
                        }else if item.msg_type == kXMPP.TYPE_IMAGE {
                            
                            cell.last_msg?.text = "Image"
                            
                        }else if item.msg_type == kXMPP.TYPE_PDF {
                            
                            cell.last_msg?.text = "Pdf"
                            
                        }
                        
                        
                        cell.last_msg?.textColor = UIColor.darkGray
                        
                        
                    }else{
                        
                        cell.last_msg?.text = "Typing..."
                        cell.last_msg?.textColor = UIColor.blue
                        
                    }
                    
                    
                  
                    
                    
                    if item.is_mine == "1"{
                        
                        cell.lastMsgImage.isHidden = false
                        
                        
                        if item.msg_ack == kXMPP.msgSend{
                            
                            cell.lastMsgImage.image = UIImage(named: "send_gray_icon")
                            
                        }else  if item.msg_ack == kXMPP.msgSent{
                            
                            cell.lastMsgImage.image = UIImage(named: "receive_gray_icon")
                            
                            
                        }else  if item.msg_ack == kXMPP.msgSeen{
                            
                            cell.lastMsgImage.image = UIImage(named: "read_blue_icon")
                            
                        }else{
                            
                            cell.lastMsgImage.isHidden = true
                            
                        }
                        
                        if item.msg == kXMPP.DELETE_TEXT_MY ||
                            item.msg == kXMPP.DELETE_TEXT_FRIEND {
                            
                            cell.lastMsgImage?.isHidden = true
                            
                        }else{
                            
                            cell.lastMsgImage?.isHidden = false
                            
                        }
                        
                        
                        
                        
                        
                    }else{
                        
                        
                       // cell.last_msg?.text = ""
                       // cell.last_msg_time?.text = ""
                       // cell.lastMsgImage.isHidden = true
                    }
                    
                }
                
            }catch{
                print("error executing request")
            }
            
            
            
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
        let params = ["user_name": "\(USERDETAILS.firstName) \(USERDETAILS.lastname)",  "user_contact_no":"\(USERDETAILS.mobile)",  "fcm_id":"\(fcm!)","user_photo":"\(USERDETAILS.imageurl)","user_email":"\(USERDETAILS.email)","password":"\(USERDETAILS.mobile)","device":"iPhone"] as Dictionary<String, String>
        print(params)
        MakeHttpPostRequestChat(url: kXMPP.registerUSER, params: params, completion: {(success, response) in
            
            print(response)
            
            //self.getNotificationCount()
            
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
                    is_typing: "",
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
            
            
            let friends = self.getFriends()
            
            for f in friends {
                
                let fri = f as! Friends
                
                var isPresent =  false
                
                for (index, friend) in list.enumerated() {
                    let item = FriendListChat(friend as! NSDictionary)
                    if fri.contact_number == item.user_contact_no{
                        isPresent = true
                        break
                    }
                }
                
                if isPresent == false {
                    
                    // friend delte
                    self.clearFriend(friendId: fri.contact_number)
                }
            }
            
            
            
           
            
        }, errorHandler: {(message) -> Void in
            print("message", message)
            
           
            
        })
                
        
    }
    
    
    /**** CORE DATA ****/
    
    
    private func clearFriend(friendId:String) {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest    <NSFetchRequestResult>(entityName: String(describing: Friends.self))
            fetchRequest.predicate = NSPredicate(format: "contact_number == %@",friendId)
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                
                for item in objects!{
                    context.delete(item)
                }
                DispatchQueue.main.async {
                self.tblView.reloadData()
                }
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    
    private func getFriends() -> [NSManagedObject] {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
       // fetchRequest.predicate = NSPredicate(format: "contact_number = %@", item.contact_number)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
        }catch{
            print("error executing request")
        }
        
        return results
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
                
                self.tblView.reloadData()
          
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    func updateFriendCell(friendID : String){
        
        // update friend profile
        
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
                    
                   // self.tblView.reloadData()
                    
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
        
        self.isSearching = false
        
        
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
            
            self.isSearching = true
            
            if searchText.count != 0 {
                
                self.fetchedhResultController.fetchRequest.predicate =  NSPredicate(format: "name CONTAINS %@", searchText)
                
                try self.fetchedhResultController.performFetch()
                self.tblView.reloadData()
                
            }else{
                
                self.fetchedhResultController.fetchRequest.predicate =  nil
                try self.fetchedhResultController.performFetch()
                self.tblView.reloadData()
            }

         
        } catch let error  {
            print("ERROR: \(error)")
        }
    }
    
    
    func getNotificationCount(){
        
        
        
        let params = ["contact_no": "\(USERDETAILS.mobile)"]
        print(params)
        MakeHttpPostRequestChat(url: kXMPP.notificationCount, params: params, completion: {(success, response) in
            print(response)
            
            let res = response.object(forKey: "responce") as? Int ?? 0
            
            if res == 1 {
                
                let jsonobject = response["notification_count"] as? NSDictionary;
                let count = jsonobject?.object(forKey: "notification_count") as? String ?? ""
                
                DispatchQueue.main.async {
                    
                    
                    if count == "0"{
                        
                        self.lblNotificationCount.isHidden = true
                    }else{
                        self.lblNotificationCount.isHidden = false
                        self.lblNotificationCount.text = count
                    }
                }
                
              
                
            }else{
                
                
            }

            
          
           
        }, errorHandler: {(message) -> Void in
            print("message", message)
        })
        
    }

  
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
        self.tblView.reloadData()
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tblView.beginUpdates()
    }
}

