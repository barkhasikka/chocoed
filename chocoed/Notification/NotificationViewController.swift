//
//  NotificationViewController.swift
//  chocoed
//
//  Created by Tejal on 17/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    var arrayList = [getNotificationListStruct]()
    var activityUIView: ActivityIndicatorUIView!

    @IBOutlet weak var tableBiewNotification: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        loadNotificationList()
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
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getNotificationList, params: params, completion: {(success, response) -> Void in
            DispatchQueue.main.async {
               print(response)
                let notify = response.object(forKey: "list") as? NSArray ?? []
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
        cell.labelTime.text = "\(arrayList[indexPath.row].notificationDate)"
        cell.imageViewIcon.image = UIImage(named: "questionImage")
        let url = arrayList[indexPath.row].notificationImageUrl
        let fileUrl = URL(string: url)
        if fileUrl != nil{
            if let data = try? Data(contentsOf: fileUrl!) {
                if let image = UIImage(data: data) {
                    cell.imageViewIcon.image = image
                }
            }
        }

        return cell
    }
}
