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
    
    @IBOutlet weak var completedTestsLabel: UILabel!
    
   
    @IBOutlet weak var labelRank: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var courseCompletedLabel: UILabel!
    @IBOutlet weak var completedTestLabel: UILabel!
    @IBOutlet weak var addContactView: UIView!
    @IBOutlet weak var addContactLabel: UILabel!
    
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var coursestoDisplaylable: UILabel!
    @IBOutlet weak var addConatctButton: UIButton!
    @IBOutlet weak var addContactImage: UIImageView!
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var imageViewLabelImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    
    
    @IBOutlet weak var viewFortableView: UIView!
    
    @IBOutlet weak var tabelViewReport: UITableView!
    var userImageLoaded : UIImage? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        let backgroundImage = UIImageView(frame: backgroundView.bounds)
        backgroundImage.image = UIImage(named: "gradient_pattern_oval")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

        let backgroundImage1 = UIImageView(frame: view.bounds)
        backgroundImage1.image = UIImage(named: "background")
        backgroundImage1.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage1, at: 0)
 
        
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
        
        labelRank.layer.cornerRadius = 10
        labelRank.clipsToBounds = true
        loadGetMyProgress()
        
        
        
        let fileUrl = URL(string: "\(USERDETAILS.imageurl)")
        if fileUrl != nil {
            if let data = try? Data(contentsOf: fileUrl!) {
                if let image = UIImage(data: data) {
                    self.imageViewLabelImage.image = image
                }
            }
        }
        NameLabel.text = USERDETAILS.firstName + " " + USERDETAILS.lastname
        imageViewLabelImage.layer.borderWidth = 3
        imageViewLabelImage.layer.cornerRadius = 35
        imageViewLabelImage.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageViewLabelImage.clipsToBounds = true
        
        addContactView.isHidden = true
        
        if arrayProgress.count > 0 {
            addContactView.isHidden = true
            viewFortableView.isHidden = false
        }else{
            addContactView.isHidden = false
            viewFortableView.isHidden = true
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.emptyAction))
            self.addContactView.addGestureRecognizer(gesture)
            
        }
        // Do any additional setup after loading the view.
        
        
    }
    
    @objc func emptyAction(sender : UITapGestureRecognizer){
        
        let dashboardvc = self.storyboard?.instantiateViewController(withIdentifier: "addcontact") as! AddContactViewController
        self.present(dashboardvc, animated: true, completion: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arrayProgress.count)
        return arrayProgress.count
    }
    
    @IBAction func BackButton(_ sender: Any) {
        
        let dashboardvc = self.storyboard?.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
        DispatchQueue.main.async {
            let aObjNavi = UINavigationController(rootViewController: dashboardvc)
            aObjNavi.navigationBar.barTintColor = UIColor.blue
            self.present(aObjNavi, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leadercell", for: indexPath) as! LeaderBoardTableViewCell
        
        var url = arrayProgress[indexPath.row].friendImageUrl
        var fileUrl = URL(string: url)
        if fileUrl != nil{
            if let data = try? Data(contentsOf: fileUrl!) {
                if let image = UIImage(data: data) {
                    cell.imageViewLeader.image = image
                }
            }
        }
        
        cell.CoursesImage.image = UIImage(named: "computerImage")
        cell.NameLeader.text = arrayProgress[indexPath.row].friendName
        cell.noofCOurses.text = "\(arrayProgress[indexPath.row].topicCount)"
        cell.noofTest.text = "\(arrayProgress[indexPath.row].testCount)"
        cell.noOfWeek.text = "\(arrayProgress[indexPath.row].weekNumber) Wk"
        
        cell.weekImage.image = UIImage(named: "fileImage")
        cell.testImage.image = UIImage(named: "questionImage")
        cell.rank.text = "\(arrayProgress[indexPath.row].rankNumber)"
        
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
            self.arrayProgress.removeAll()
            let progressofFriend = getMyProgressStruct((response as? NSDictionary)!)
            for pg in progressofFriend.friendList {
                self.arrayProgress.append(FriendProgress( pg as! NSDictionary))
                
                
                print(self.arrayProgress.count,"Progress----->")
                
              //  let uniqueArray = arrayProgress.removeDuplicate()
                
            }
            
           
            
            DispatchQueue.main.async {
                self.labelRank.text = "\(progressofFriend.myRankNumber)"
                self.courseCompletedLabel.text = "\(progressofFriend.myCoursesCount)"
                self.completedTestLabel.text = "\(progressofFriend.myTestCount)"
                self.reportLabel.text = "\(progressofFriend.schduleMsg)"
                
                if self.arrayProgress.count > 0 {
                    
                }else{
                    
                    //self.addContactView.i
                }
                
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
    
    override func viewWillAppear(_ animated: Bool) {
        loadGetMyProgress()
    }

}
