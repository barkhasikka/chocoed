//
//  NotificationViewController.swift
//  chocoed
//
//  Created by Tejal on 17/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    
    
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet var badgesView: UIView!
    
    @IBOutlet var lblBadges: UILabel!
    @IBOutlet var lblCoins: UILabel!
    
    var badgesCount : String = "0"
    var coinsCount : String = "0"
    
    var pageNo = 1
    var shouldLoad = true
    
    @IBAction func closeBottiomView(_ sender: Any) {
        
        if self.arrayList.count > 0 {
            self.arrayList.removeAll()
        }
        
        self.shouldLoad = true
        self.pageNo = 1
        self.loadNotificationList()
        
        self.badgesView.isHidden = true

    }
    
    
    var arrayList = [getNotificationListStruct]()
    var activityUIView: ActivityIndicatorUIView!

    @IBOutlet weak var tableBiewNotification: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        self.notificationLabel.text = "NotificationKey".localizableString(loc: language!)
        
        pageNo = 1
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        loadNotificationList()
        
        
        self.tableBiewNotification.estimatedRowHeight = 80.0
        self.tableBiewNotification.rowHeight = UITableViewAutomaticDimension
        
        self.badgesView.isHidden = true
        
        self.lblCoins.text = self.coinsCount
        self.lblBadges.text = self.badgesCount
        
        let backgroundImage = UIImageView(frame: self.badgesView.bounds)
        backgroundImage.image = UIImage(named: "gradient_pattern_oval")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.badgesView.insertSubview(backgroundImage, at: 0)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        let startVC = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: startVC)
        aObjNavi.navigationBar.barTintColor = UIColor.blue
        self.present(aObjNavi, animated: true, completion: nil)
    }
    
    func loadNotificationList(){
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)","pageSize":"20","pageNo":"\(String(self.pageNo))"] as Dictionary<String, String>
       
        print(params)
        
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getNotificationList, params: params, completion: {(success, response) -> Void in
            DispatchQueue.main.async {
               print(response)
                let notify = response.object(forKey: "list") as? NSArray ?? []
                
                if notify.count == 0 {
                    self.shouldLoad = false
                }
                
                for notification in notify {
                    self.arrayList.append(getNotificationListStruct( notification as! NSDictionary))
                    print(self.arrayList)
                }
                DispatchQueue.main.async {
                    
                    
                    
                    self.tableBiewNotification.reloadData()
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                }
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
        return arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationcell", for: indexPath) as! NotificationTableViewCell
        cell.labelNotification.text = arrayList[indexPath.row].notificationTitle
        cell.labelTime.text = arrayList[indexPath.row].aboutNotification
        
        cell.labelTime.numberOfLines = 0
        
        let url = arrayList[indexPath.row].notificationImageUrl
        cell.imageViewIcon.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "skillCues_design"), options: .continueInBackground, progress: nil, completed: nil)
       // let fileUrl = URL(string: url)
        
        if  arrayList[indexPath.row].isRead == true {
            
            //read
            cell.labelNotification.textColor = UIColor.black
            cell.labelTime.textColor = UIColor.black

            cell.labelNotification.font = UIFont.boldSystemFont(ofSize: 25.0)
            cell.labelNotification.font = UIFont.boldSystemFont(ofSize: 17.0)
            
            cell.backgroundColor = UIColor.white
            
            
        }else{
            
            //unread
            
           // cell.labelNotification.textColor = UIColor.lightGray
           // cell.labelTime.textColor = UIColor.lightGray
            
            cell.labelNotification.textColor = UIColor.black
            cell.labelTime.textColor = UIColor.black
            
            cell.labelNotification.font = UIFont.boldSystemFont(ofSize: 25.0)
            cell.labelNotification.font = UIFont.boldSystemFont(ofSize: 17.0)
            
            cell.backgroundColor = UIColor.lightGray


        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        if indexPath.row == self.arrayList.count - 1 {
            
            if self.shouldLoad == true {
                self.pageNo = self.pageNo + 1
                loadNotificationList()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrayList[indexPath.row].isRead == false {
            self.readNotification(id: String(arrayList[indexPath.row].notificationId))
        }
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")

        
        
        let alertView = UIAlertController(title: arrayList[indexPath.row].notificationTitle, message: arrayList[indexPath.row].aboutNotification, preferredStyle: .alert)
        let action = UIAlertAction(title: "backAlertKey".localizableString(loc: language!), style: .default, handler: { (alert) in
            
            if self.arrayList.count > 0 {
                
                self.arrayList.removeAll()
            }
            
            self.shouldLoad = true
            self.pageNo = 1
            self.loadNotificationList()
            
        })
        alertView.addAction(action)
        let actionSure = UIAlertAction(title: "okAlertKey".localizableString(loc: language!), style: .default, handler: { (alert) in
        
            // CALENDER GET ASSIGNED - load my plan page -done  2
            // Todays topic - load my plan page --done 3
            //delayed or behind - load my progress -done 4
            // friend added - load my progress --done 5
            // badges and coin earned - show badges -done
            
            if self.arrayList[indexPath.row].notificationType == "4" || self.arrayList[indexPath.row].notificationType == "5"  {
                
                // open my progress
                
                let v1 = self.storyboard?.instantiateViewController(withIdentifier: "leader") as! LeaderBoardViewController
                self.present(v1, animated: true, completion: nil)
                
                
            }else if self.arrayList[indexPath.row].notificationType == "2" ||
                self.arrayList[indexPath.row].notificationType == "3" {
                
                // load my plan
                
                currentTopiceDate = ""
                currentCourseId = ""
                
                isLoadExamFromVideo = ""
                isLoadExamId = ""
                isLoadCalendarId = ""
                isLoadExamName = ""
                
                let v1 = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
                self.present(v1, animated: true, completion: nil)
                
            }else if self.arrayList[indexPath.row].notificationType == "999" {
                
                self.dismiss(animated: true, completion: nil)
                
            }else if self.arrayList[indexPath.row].notificationType == "8" {
            
                
                let v1 = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
                self.present(v1, animated: true, completion: nil)
            
            
            }else{
                
                if self.arrayList.count > 0 {
                    self.arrayList.removeAll()
                }
                
                self.shouldLoad = true
                self.pageNo = 1
                self.loadNotificationList()
            }
            
            
        })
        alertView.addAction(actionSure)
        self.present(alertView, animated: true, completion: nil)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func readNotification(id : String){
        
        let list = "[{\"notificationId\":\"\(id)\"}]"
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)","list":"\(list)",] as Dictionary<String, String>
        
        print(params)
        
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: updateNotificationRead, params: params, completion: {(success, response) -> Void in
            DispatchQueue.main.async {
                print(response)
              
                DispatchQueue.main.async {
                    self.tableBiewNotification.reloadData()
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                }
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
