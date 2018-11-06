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


class FriendListVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate {

  
    @IBOutlet var tblView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Friends.self))
    
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "last_msg_time", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // let params = ["name":"Mahesh Nikam","last_msg_time":"Yesterday","last_msg":"Hello How are you","friendImage":"","lastMsgTypeImage":"","count":"","userId":"7774960386"] as Dictionary<String, String>
       // self.arrayFriends.append(FriendListChat(params as NSDictionary))
        
        self.checkChatConnection()
        self.searchBar.delegate = self
    
        self.tblView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        do {
            try self.fetchedhResultController.performFetch()
            self.tblView.reloadData()
        } catch let error  {
            print("ERROR: \(error)")
        }
        
        self.registerToChat()
        
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
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        if let item = fetchedhResultController.object(at: indexPath) as? Friends {
        
            cell.name.text=item.name
            cell.last_msg.text=item.last_msg
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC {
            let item = fetchedhResultController.object(at: indexPath) as? Friends
            vcNewSectionStarted.friendModel = item
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
        
    }
    
    /*** API CALLS ***/
    /* 1. Register User */
    
    private func registerToChat(){
        
        var token = ""
        
        InstanceID.instanceID().instanceID { (result, error) in
            token = (result?.token)!
        }
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        let params = ["user_name": "\(USERDETAILS.firstName) \(USERDETAILS.lastname)",  "user_contact_no":"\(USERDETAILS.mobile)",  "fcm_id":"\(token)","user_photo":"\(USERDETAILS.imageurl)","user_email":"\(USERDETAILS.email)","password":"\(USERDETAILS.mobile)"] as Dictionary<String, String>
        print(params)
        MakeHttpPostRequestChat(url: kXMPP.registerUSER, params: params, completion: {(success, response) in
            
            print(response)
            /* let jsonobject = response["info"] as? NSDictionary;
             let temp = ModelProfileClass()
             temp.firstName = jsonobj ect?.object(forKey: "firstName") as? String ?? ""
             temp.lastName = jsonobject?.object(forKey: "lastName") as? String ?? ""
             temp.email = jsonobject?.object(forKey: "email") as? String ?? ""
             temp.mobile = jsonobject?.object(forKey: "mobile") as? String ?? ""
             let clientId = jsonobject?.object(forKey: "clientId") as? String ?? ""
             let url = jsonobject?.object(forKey: "profileImageUrl") as? String ?? ""
             let quizTaken =  jsonobject?.object(forKey:"quizTestGiven") as? Int ?? -1
             UserDefaults.standard.set(quizTaken, forKey: "quiztakenID")
             let quizID = UserDefaults.standard.string(forKey: "quiztakenID")
             // print(quizID)
             // let fileUrl = URL(string: url)
             UserDefaults.standard.set(Int(clientId), forKey: "clientid")
             */
            
            
        }, errorHandler: {(message) -> Void in
            print("message", message)
            
            DispatchQueue.main.async {
            }
            
        })
                
             /*   self.createFriendEntityFrom(item: Friend(
                    created: "",
                    contact_number: "",
                    fcm_id: "",
                    is_mine: "0",
                    is_typing: "0",
                    last_msg: "Hello",
                    last_msg_type: "text",
                    last_msg_time: "10:13 PM",
                    modified: "",
                    name: "",
                    profile_image: "",
                    read_count: "0",
                    status: "",
                    user_id: ""))
             */
                
       
    }
    
    
    /**** CORE DATA ****/
    
    private func isFriendPrsent(item : Friend) -> Bool {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", item.contact_number)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count == 1 {
                
                let updatObj = results[0]
                updatObj.setValue("name", forKey: item.name)
                updatObj.setValue("profile_image", forKey: item.profile_image)
              
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
    
    private func clearData() {
        do {
            
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Msg.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    
    
    
    public static func getCurrentTime() -> String {
        
        let messageID = Int64(NSDate().timeIntervalSince1970 * 1000)
        return String(messageID)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
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

