//
//  AppDelegate.swift
//  chocoed
//
//  Created by barkha sikka on 17/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import CoreData

import UserNotifications
import Firebase
import FirebaseMessaging
import XMPPFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
  /*  func oneStream(_ sender: XMPPStream, didReceiveMessage message: XMPPMessage, from user: XMPPUserCoreDataStorageObject) {
        print("<<<<<< AT DELEGATE didReceiveMessage")
    }
    
    func oneStream(_ sender: XMPPStream, userIsComposing user: XMPPUserCoreDataStorageObject) {
        
        print("<<<<<< AT DELEGATE userIsComposing")

    }
    
    func oneStream(_ sender: XMPPStream, didReceiptReceive message: XMPPMessage, from user: XMPPUserCoreDataStorageObject) {
        
        print("<<<<<< AT DELEGATE didReceiptReceive")

    } */
    

    var window: UIWindow?
    var shouldRotate = false
    static var menu_bool = true
    
    //AAAAgSFpxh8:APA91bGGeQMgz_qm9bi61kY3iPQchcn3ooeTCwToMdK6cycrreGlzqJ9mkXRSR75EC2QhCvJ8SpGFT9yPH0o4iNtKGfK10p2uacPLjJppz71rvln42yNf5cUMI3o-ELWibBTpHUvMV9N

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let userInfo = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] {
             NSLog("[RemoteNotification] applicationState: \(applicationStateString) didFinishLaunchingWithOptions for iOS9: \(userInfo)")
        }
        FirebaseApp.configure()
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        CoreDataStack.sharedInstance.applicationDocumentsDirectory()
        OneChat.start(true, delegate: nil) { (stream, error) -> Void in
            if let _ = error {
                //handle start errors here
                print("errors from appdelegate")
            } else {
                print("Yayyyy")
    
            }
          }

        requestNotificationAuthorization(application: application)
        self.openVC()
        return true
    }

        func openVC(){
            
            let userID = UserDefaults.standard.integer(forKey: "userid")
            UserDefaults.standard.set("en", forKey: "currentlanguage")
            if userID != 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) { // change 2 to desired number of seconds
                    self.GetUserInfo()
                    
                }
        // Override point for customization after application launch.
        let userID = UserDefaults.standard.integer(forKey: "userid")
       // UserDefaults.standard.set("en", forKey: "currentlanguage")
        UserDefaults.standard.string(forKey: "currentlanguage")
        print(userID)
        if userID != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) { // change 2 to desired number of seconds
                self.GetUserInfo()
            }
        }else {
           /* let quiztakenid = UserDefaults.standard.string(forKey: "quiztakenID")
            print(quiztakenid)
            if quiztakenid == "1"{
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                let navigationController = UINavigationController(rootViewController: startVC)
                self.window!.rootViewController = navigationController
            }
            else{ */
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {

                self.window = UIWindow(frame: UIScreen.main.bounds)
                let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "firstview") as! ViewController
                self.window!.rootViewController = startVC
                self.window!.makeKeyAndVisible()
                    }
                }
            }else {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        
                       // self.window = UIWindow(frame: UIScreen.main.bounds)
                        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "firstview") as! ViewController
                        self.window!.rootViewController = startVC
                        self.window!.makeKeyAndVisible()
                        
                    }
                }
    }
    var applicationStateString: String {
        if UIApplication.shared.applicationState == .active {
            return "active"
        } else if UIApplication.shared.applicationState == .background {
            return "background"
        }else {
            return "inactive"
        }
    }
    func requestNotificationAuthorization(application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
    }

    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
          CoreDataStack.sharedInstance.saveContext()
    }
    
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func GetUserInfo() {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        MakeHttpPostRequest(url: getUserInfo, params: params, completion: {(success, response) in
            print(response)
            let jsonobject = response["info"] as? NSDictionary;
            let temp = ModelProfileClass()
            temp.firstName = jsonobject?.object(forKey: "firstName") as? String ?? ""
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
            
            USERDETAILS = UserDetails(email: temp.email, firstName: temp.firstName, lastname: temp.lastName, imageurl: url, mobile: temp.mobile)
            
            if quizTaken == 1 {
                print("1")
                DispatchQueue.main.async {
                  
                   // self.window = UIWindow(frame: UIScreen.main.bounds)
                let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
                    let aObjNavi = UINavigationController(rootViewController: startVC)
                    aObjNavi.navigationBar.barTintColor = UIColor.blue
                    self.window!.rootViewController = aObjNavi
                    self.window!.makeKeyAndVisible()
                 
 
                    
                   /* let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "FriendListVC") as! FriendListVC
                    self.window!.rootViewController = startVC
                    self.window!.makeKeyAndVisible()
                   */
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    
                   // self.window = UIWindow(frame: UIScreen.main.bounds)
                    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "profileSuccess") as! ProfileSucessViewController
                    self.window!.rootViewController = startVC
                    self.window!.makeKeyAndVisible()
                    
                    
                  /*   let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "FriendListVC") as! FriendListVC
                    self.window!.rootViewController = startVC
                    self.window!.makeKeyAndVisible()
                   */
                   
                    
                    
                    
                    
                }
                
            }
            //            DispatchQueue.main.async(execute: {
            //                self.textfieldFirstName.text = temp.firstName
            //                self.textfieldLastName.text = temp.lastName
            //                self.textfieldEmailId.text = temp.email
            //                self.textfieldMobileNo.text = temp.mobile
            //                if let data = try? Data(contentsOf: fileUrl!) {
            //                    if let image = UIImage(data: data) {
            //                        self.imageviewCircle.image = image
            //                    }
            //
            //                }
            //            })
        }, errorHandler: {(message) -> Void in
            print("message", message)
            
            DispatchQueue.main.async {

            self.window = UIWindow(frame: UIScreen.main.bounds)
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "firstview") as! ViewController
            self.window!.rootViewController = startVC
            self.window!.makeKeyAndVisible()

                
            }

        })
    }
    
    private func updateMsgAck(friendID : String){
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "to_id = %@ AND msg_ack != %@", friendID,"2")
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                for item in results {
                    
                    item.setValue("2", forKey: "msg_ack")
                    
                    do{
                        
                        try context.save()
                        
                        
                    }catch{
                        print("Error in update")
                    }
                    
                }
                
            }
            
        }catch{
            print("error executing request")
        }
        
    }
    
    
    public func updateMsg(msg_id : String , type : String , value : String){
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "msg_id = %@", msg_id)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
                
                
                if type == "streaming"{
                    updatObj.setValue(value, forKey: "is_streaming")
                }
                
                if type == "upload"{
                    updatObj.setValue(value, forKey: "is_download")
                    updatObj.setValue("0", forKey: "msg_ack")
                }
                
                if type == "download"{
                    updatObj.setValue(value, forKey: "is_download")
                }
                
                if type == "file"{
                    updatObj.setValue(value, forKey: "file_url")
                }
                if type == "delete_type"{
                    
                    updatObj.setValue(value, forKey: "msg")
                }
                
                if type == "msg_ack"{
                    
                    updatObj.setValue(value, forKey: "msg_ack")
                }
                
                do{
                    
                    try context.save()
                    
                    
                }catch{
                    print("Error in update")
                }
            }
            
        }catch{
            print("error executing request")
        }
        
    }
    
    private func getFriend(id : String) -> String {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", id)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                let f = results[0] as! Friends
                return f.name
            }
        }catch{
            print("error executing request")
        }
        
        return ""
    }
    
    
    private func getMsg(msgId : String) -> Msg {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "msg_id = %@", msgId)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                return results[0] as! Msg
                
            }
            
            
            
        }catch{
            print("error executing request")
        }
        
        return results[0] as! Msg
    }
    
    
    private func isMSgPrsent(item : Message) -> Bool {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "msg_id = %@", item.msgId)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            
            
        }catch{
            print("error executing request")
        }
        
        return results.count > 0
    }
    
    private func createMsgEntityFrom(item: Message) {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if isMSgPrsent(item: item) == false {
            
            let msgObject = NSEntityDescription.insertNewObject(forEntityName: "Msg", into: context) as? Msg //{
            
            print(item.msgId)
            
            msgObject?.msg = item.msg
            msgObject?.created = item.created
            msgObject?.file_url = item.fileUrl
            msgObject?.from_id = item.fromID
            msgObject?.is_download = item.isDownload
            msgObject?.is_mine = item.isMine
            msgObject?.is_streaming = item.isStreaming
            msgObject?.is_upload = item.isUpload
            msgObject?.modified = item.modified
            msgObject?.msg = item.msg
            msgObject?.msg_ack = item.msgACk
            msgObject?.msg_id = item.msgId
            msgObject?.msg_type = item.msgType
            msgObject?.status = item.status
            msgObject?.to_id = item.toID
            msgObject?.is_permission = item.is_permission
            msgObject?.replyTitle = item.replyTitle
            msgObject?.replyMsgType =  item.replyMsgType
            msgObject?.replyMsgId = item.replyMsgId
            msgObject?.replyMsgFile = item.replyMsgFile
            msgObject?.replyMsg =  item.replyMsg
            
            msgObject?.sent_time =  item.sentTime
            msgObject?.seen_time =  item.seenTime
            msgObject?.distructive_time = item.destructiveTime
            
            
            
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            //  }
        }else{
            print("present")
        }
        
        
    }
    private func getCurrentTime() -> String {
        
        let messageID = Int64(NSDate().timeIntervalSince1970 * 1000)
        return String(messageID)
        
    }
    
    
    private func updateFriendCell(last_msg_time : String , msg : String , msg_type :String , isMine : String, friendID : String){
        
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", friendID)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
                
                var count = Int(updatObj.value(forKey: "read_count") as? String ?? "0")
                count = count! + 1
                
                print(count!,"<<<< COUNT >>>>>>")
                
                updatObj.setValue(msg, forKey: "last_msg")
                updatObj.setValue(msg_type, forKey:"last_msg_type")
                updatObj.setValue("0", forKey: "last_msg_ack")
                updatObj.setValue(last_msg_time, forKey:"last_msg_time")
                updatObj.setValue(isMine, forKey:"is_mine")
                updatObj.setValue(String(count!), forKey: "read_count")
                
                
                do{
                    try context.save()
                    
                }catch{
                    print("Error in update")
                }
            }
            
        }catch{
            print("error executing request")
        }
        
    }
    
    
    
    
    private func saveMsg(friendID:String,msg:String,msgID:String){
        
    
        
        do{
            
            
            let data = msg.data(using: .utf8)
            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
            
            print(json)
            
            
            
            if json.value(forKey: "msgType") as! String == kXMPP.TYPE_DELETE {
                
                // update msg by msgID
                
                self.updateMsg(msg_id: json.value(forKey: "msgId") as! String, type: "delete_type", value: kXMPP.DELETE_TEXT_FRIEND)
                
                
            }else if json.value(forKey: "msgType") as! String == kXMPP.TYPE_SEEN {
                
                // update msg by msgID
                
                self.updateMsgAck(friendID: friendID)
                
            }else{
                
                var replyMsgType = ""
                var replyMsgFile = ""
                var replyMsg = ""
                var replyTitle = ""
                var replyMsgId = ""
                
                let msgType = json.value(forKey: "msgType") as! String
                
                if msgType == kXMPP.TYPE_REPLY {
                    
                    replyMsgId = json.value(forKey: "msgId") as! String
                    
                    
                    let msgItem = self.getMsg(msgId: replyMsgId)
                    
                    replyMsg = msgItem.msg
                    replyMsgFile = msgItem.file_url
                    
                    if msgItem.is_mine == "1" {
                        replyTitle = "You"
                    }else{
                        replyTitle = self.getFriend(id: friendID)
                    }
                    
                    replyMsgType = msgItem.msg_type
                    
                }
                
                
                
                self.createMsgEntityFrom(item: Message(
                    msg: json.value(forKey: "message") as! String,
                    msgId: msgID,
                    msgType: msgType,
                    msgACk: "0",
                    fromID: UserDefaults.standard.string(forKey: "mobileno")!,
                    toID: friendID,
                    fileUrl: json.value(forKey: "fileUrl") as! String,
                    isUpload: "0",
                    isDownload: "0",
                    isStreaming: "0",
                    isMine: "0",
                    created: self.getCurrentTime(),
                    status: "",
                    modified: self.getCurrentTime(),
                    is_permission: "0",replyTitle: replyTitle, replyMsgType: replyMsgType, replyMsgId: replyMsgId, replyMsgFile: replyMsgFile, replyMsg: replyMsg, sentTime: kXMPP.SEEN_MSG, seenTime: kXMPP.SEEN_MSG, destructiveTime: ""))
                
                
                self.updateFriendCell(last_msg_time: self.getCurrentTime(), msg: json.value(forKey: "message") as! String, msg_type: json.value(forKey: "msgType") as! String, isMine: "0" , friendID: friendID)
                
                
                
                
                let friendNo = UserDefaults.standard.string(forKey: "chatNo")
                if friendNo == nil || friendNo != friendID {
                    
                    let mainvc = SplitviewViewController()
                    mainvc.showNotification(friendname: self.getFriend(id: friendID) , msg: json.value(forKey: "message") as! String)
                }
                
                
                
               // self.sendSeenMsgAck(friendID: friendID)
                
                
                let dsmsg =  json.value(forKey: "destructiveTime") as! String
                
                if dsmsg.count > 0 {
                    
                    // var timeVal = Float(json.value(forKey: "destructiveTime") as! String)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 120.0, execute: {
                        
                        // updated msg by msg id
                        
                        self.updateMsg(msg_id: msgID, type:"delete_type", value: kXMPP.DELETE_TEXT_FRIEND)
                        
                    })
                    
                    
                }
                
            }
            
        }catch{
            
        }
        
    }
}
    

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // iOS10+, called when presenting notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) willPresentNotification: \(userInfo)")
        
       
        if let msg = userInfo["gcm.notification.type"] as? String {
        print(msg,"<<<<<< NOTIFICATION TYPE333 >>>>>>")
        if  msg == "chat" {
            print(msg,"<<<<<< Chat Msg>>>>>>")
            let friid = userInfo["gcm.notification.friend"] as! String
            let msg = userInfo["gcm.notification.message"] as! String
            let msgid = userInfo["gcm.notification.message_id"] as! String
           // self.saveMsg(friendID: friid, msg: msg, msgID: msgid)
         }
     }
        
        
        
        
        //TODO: Handle foreground notification
        completionHandler([.alert])
    }
    
    // iOS10+, called when received response (default open, dismiss or custom action) for a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) didReceiveResponse: \(userInfo)")
        
        if let msg = userInfo["gcm.notification.type"] as? String {
            print(msg,"<<<<<< NOTIFICATION TYPE333 >>>>>>")
            if  msg == "chat" {
                print(msg,"<<<<<< Chat Msg>>>>>>")
                let friid = userInfo["gcm.notification.friend"] as! String
                let msg = userInfo["gcm.notification.message"] as! String
                let msgid = userInfo["gcm.notification.message_id"] as! String
               // self.saveMsg(friendID: friid, msg: msg, msgID: msgid)
            }
        }
        
        /*let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "firstview") as! ViewController
        self.window!.rootViewController = startVC */
        
        
         //self.openVC()
        //TODO: Handle background notification
        completionHandler()
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        NSLog("[RemoteNotification] didRefreshRegistrationToken: \(fcmToken)")
    }
    
    // iOS9, called when presenting notification in foreground
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        NSLog("[RemoteNotification] applicationState: \(applicationStateString) didReceiveRemoteNotification for iOS9: \(userInfo)")
        
        if let msg = userInfo["gcm.notification.type"] as? String {
            print(msg,"<<<<<< NOTIFICATION TYPE333 >>>>>>")
            if  msg == "chat" {
                print(msg,"<<<<<< Chat Msg>>>>>>")
                let friid = userInfo["gcm.notification.friend"] as! String
                let msg = userInfo["gcm.notification.message"] as! String
                let msgid = userInfo["gcm.notification.message_id"] as! String
               // self.saveMsg(friendID: friid, msg: msg, msgID: msgid)
            }
        }
      
        
        if UIApplication.shared.applicationState == .active {
            //TODO: Handle foreground notification
        } else {
            //TODO: Handle background notification
        }
    }
}

