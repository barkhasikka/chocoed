//
//  TopicsStatusViewController.swift
//  chocoed
//
//  Created by Tejal on 12/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class TopicsStatusViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableviewTopics: UITableView!
    var arrayCourseSubTopicList = [CourseSubTopicList]()
    var activityUIView: ActivityIndicatorUIView!
    var topicid = ""
    var courseid = ""
    var calanderid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        loadApiMyTopicStatusList()
        
        
        // Do any additional setup after loading the view.
    }
    override var shouldAutorotate: Bool{
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadApiMyTopicStatusList()
    {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientId = UserDefaults.standard.integer(forKey: "clientid")
        
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)", "clientId": "\(clientId)","courseId" : "\(courseid)","topicId" : "\(topicid)","calenderId": "\(calanderid)"] as Dictionary<String, String>
        print(params)
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        
        MakeHttpPostRequest(url: getMySubTopics, params: params, completion: {(success, response) in
            print(response)
            self.arrayCourseSubTopicList = [CourseSubTopicList]()
            let list = response.object(forKey: "list") as? NSArray ?? []
            for (index, courseSubTopics) in list.enumerated() {
                self.arrayCourseSubTopicList.append(CourseSubTopicList(courseSubTopics as! NSDictionary))


            }
            print(self.arrayCourseSubTopicList.count)
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                self.tableviewTopics.reloadData()
            }
            
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.stopAnimation()
                self.activityUIView.isHidden = true
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCourseSubTopicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topiccell") as! TopicStatusTableViewCell
        cell.labelName.text = arrayCourseSubTopicList[indexPath.row].subTopicName
        cell.labelStatus.text = arrayCourseSubTopicList[indexPath.row].topicStatus
            if cell.labelStatus.text == "Completed"{
                    cell.labelStatus.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }else if cell.labelStatus.text == "Inprogress" {
                    cell.labelStatus.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }else{
                    cell.labelStatus.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                }
        cell.imageview.image = UIImage(named: "computer")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcnextDetails = self.storyboard?.instantiateViewController(withIdentifier: "subview") as? SubViewPersonalityUpgradeViewController
        vcnextDetails?.arrayDuplicatevalues = self.arrayCourseSubTopicList[indexPath.row]
        self.navigationController?.pushViewController(vcnextDetails!, animated: true)
    }
    
    
    
}
