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
import Highcharts



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
    

    

    var openningNotification = false
    
    var notificationID = ""
    
    //AAAAgSFpxh8:APA91bGGeQMgz_qm9bi61kY3iPQchcn3ooeTCwToMdK6cycrreGlzqJ9mkXRSR75EC2QhCvJ8SpGFT9yPH0o4iNtKGfK10p2uacPLjJppz71rvln42yNf5cUMI3o-ELWibBTpHUvMV9N

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let userInfo = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] {
           
            print("[RemoteNotification] applicationState: \(applicationStateString) didFinishLaunchingWithOptions for iOS9: \(userInfo)")
            
            
            
        }
        HIChartView.preload()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkIFScreenIsCapture), name: NSNotification.Name.UIScreenCapturedDidChange, object: nil)
        
        
        if  UIScreen.main.isCaptured == true {
            print("<<<Recording TRUE>>>>>")
            kXMPP.IS_RECORDING = true
        }

        requestNotificationAuthorization(application: application)
        self.openVC()
        return true
    }
    
    @objc func checkIFScreenIsCapture(notification:Notification){
        guard let screen = notification.object as? UIScreen else { return }
        if screen.isCaptured == true {
            print("<<<Recording TRUE>>>>>")
            kXMPP.IS_RECORDING = true
        }else{
            print("<<<Recording FALSE>>>>>")
            kXMPP.IS_RECORDING = false
        }
    }
    
    

    func openVC(){
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        UserDefaults.standard.string(forKey: "currentlanguage")
        print(userID)
        if userID != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) { // change 2 to desired number of seconds
                self.GetUserInfo()

            }
        }else {
          
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                
              
                self.window = UIWindow(frame: UIScreen.main.bounds)
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
            temp.isnominee = jsonobject?.object(forKey: "isNominatedUser") as? Bool ?? false
//            UserDefaults.standard.set(isnominated, forKey: "isnominated")
            UserDefaults.standard.set(temp.isnominee, forKey: "isnominated")
            
            let clientId = jsonobject?.object(forKey: "clientId") as? String ?? ""
            let url = jsonobject?.object(forKey: "profileImageUrl") as? String ?? ""
            let quizTaken =  jsonobject?.object(forKey:"quizTestGiven") as? Int ?? -1
            
            print(quizTaken,"-------->")
            UserDefaults.standard.set(quizTaken, forKey: "quiztakenID")
            let quizID = UserDefaults.standard.string(forKey: "quiztakenID")
           // print(quizID)
           // let fileUrl = URL(string: url)
            UserDefaults.standard.set(Int(clientId), forKey: "clientid")
            UserDefaults.standard.set(temp.mobile, forKey: "mobileno")

            
            USERDETAILS = UserDetails(email: temp.email, firstName: temp.firstName, lastname: temp.lastName, imageurl: url, mobile: temp.mobile)
//                                      isNominee: temp.isnominee )
            print(quizTaken,"-------->")
            
            
              if self.openningNotification == true {
            
            DispatchQueue.main.async {
                
                if self.notificationID == "8"{
                    
                    self.openningNotification = false
                    
                    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
                    self.window!.rootViewController = startVC
                    self.window!.makeKeyAndVisible()
                    
                }else{
                    
                    
                    self.openningNotification = false
                    
                    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "poll") as! PollViewController
                    self.window!.rootViewController = startVC
                    self.window!.makeKeyAndVisible()
                    
                    
                }
                
                
            }
            
              } else
            
            
            
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
    
}
    

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // iOS10+, called when presenting notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) willPresentNotification: \(userInfo)")
        
       
        //if let msg = userInfo["gcm.notification.type"] as? String {
        print("<<<<<< NOTIFICATION TYPE kkkkk>>>>>>")
        
     
        //TODO: Handle foreground notification
        completionHandler([.alert])
    }
    
    // iOS10+, called when received response (default open, dismiss or custom action) for a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) didReceiveResponse: \(userInfo)")
        
            print("<<<<<< NOTIFICATION TYPE333 mmm>>>>>>")
       
        
        
        /*let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "firstview") as! ViewController
        self.window!.rootViewController = startVC */
        
       // if UIApplication.shared.applicationState == .active {
            //TODO: Handle foreground notification
       // } else {
            //TODO: Handle background notification
            
            if let type = userInfo["gcm.notification.notificationType"] as? String {
                
                
                if type == "8" {
                    self.openningNotification = true
                    self.notificationID = type
                }else if type == "9"{
                    self.openningNotification = true
                    self.notificationID = type
                }else {
                    
                    completionHandler()

                }
                
            }else{
                
                completionHandler()

             }
            
           
      //  }
        
         //self.openVC()
        //TODO: Handle background notification
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        NSLog("[RemoteNotification] didRefreshRegistrationToken: \(fcmToken)")
    }
    
    // iOS9, called when presenting notification in foreground
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        NSLog("[RemoteNotification] applicationState: \(applicationStateString) didReceiveRemoteNotification for iOS9: \(userInfo)")
        
            print("<<<<<< NOTIFICATION TYPE333 >>>>>>")
          
       
        
        if UIApplication.shared.applicationState == .active {
            //TODO: Handle foreground notification
        } else {
            //TODO: Handle background notification
        }
    }
}

