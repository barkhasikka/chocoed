//
//  LeaderBoardViewController.swift
//  chocoed
//
//  Created by Tejal on 27/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var activityUIView: ActivityIndicatorUIView!
    var arrayProgress = [FriendProgress]()
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var courseCompletedLabel: UILabel!
    @IBOutlet weak var completedTestLabel: UILabel!
    @IBOutlet weak var addContactView: UIView!
    @IBOutlet weak var addContactLabel: UILabel!
    
    @IBOutlet weak var addConatctButton: UIButton!
    @IBOutlet weak var addContactImage: UIImageView!
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var imageViewLabelImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    
    
    @IBOutlet weak var viewFortableView: UIView!
    
    @IBOutlet weak var tabelViewReport: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        viewFortableView.layer.cornerRadius = 20
        viewFortableView.clipsToBounds = true
        tabelViewReport.layer.cornerRadius = 20
        tabelViewReport.clipsToBounds = true
        addContactView.layer.cornerRadius = 20
        addContactView.clipsToBounds = true
        
        addConatctButton.layer.cornerRadius = 25
        addConatctButton.clipsToBounds = true
        reportLabel.layer.cornerRadius = 10
        reportLabel.clipsToBounds = true
        
        loadGetMyProgress()
        
        
        imageViewLabelImage.layer.borderWidth = 3
        imageViewLabelImage.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageViewLabelImage.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProgress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leadercell", for: indexPath) as! LeaderBoardTableViewCell
        var url = arrayProgress[indexPath.row].friendImageUrl
        var fileUrl = URL(string: url)
        if let data = try? Data(contentsOf: fileUrl!) {
            if let image = UIImage(data: data) {
                cell.imageViewLeader.image = image
            }
        }
        cell.CoursesImage.image = UIImage(named: "Man3_3")
        cell.NameLeader.text = arrayProgress[indexPath.row].friendName
        cell.noofCOurses.text = "\(arrayProgress[indexPath.row].topicCount)"
        cell.noofTest.text = "\(arrayProgress[indexPath.row].testCount)"
        cell.noOfWeek.text = "\(arrayProgress[indexPath.row].weekNumber)"
        
        cell.weekImage.image = UIImage(named: "Man3_3")
        cell.testImage.image = UIImage(named: "Man3_3")
        
        return cell
    }

    func loadGetMyProgress(){
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        
        let params = ["access_token":"\(accessToken)","userId":"\(userID)","clientId":"\(clientID)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getProgress , params: params, completion: {(success, response) -> Void in
            print(response)
            let progressofFriend = getMyProgressStruct((response as? NSDictionary)!)
            for pg in progressofFriend.friendList {
                self.arrayProgress.append(FriendProgress( pg as! NSDictionary))
                print(self.arrayProgress.count,"Progress----->")
                
            }
            DispatchQueue.main.async {
                self.tabelViewReport.reloadData()
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

}
