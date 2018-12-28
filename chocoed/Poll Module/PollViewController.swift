//
//  PollViewController.swift
//  chocoed
//
//  Created by Tejal on 25/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class PollViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arrayOfPoll = [getPollDataList]()
    var arrayoptions = [getOptions]()
    var activityUIView: ActivityIndicatorUIView!
    @IBOutlet weak var pollTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        loadPollData()
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
    }
    func loadPollData(){

        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        //let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        let params = ["userId": "17",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        

        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: pollApi, params: params, completion: {(success, response) -> Void in
            print(response)
//            let jsonobject = response["info"] as? NSDictionary;
//            self.workExperiences = jsonobject?["userEducationList"] as? NSArray ?? []
//
//            for experience in self.workExperiences {
//                self.tableViewData.append(ExistingEducationList(experience as! NSDictionary))
//            }
            
            let poll = response.object(forKey: "list") as? NSArray ?? []
            for polls in poll {
                self.arrayOfPoll.append(getPollDataList( polls as! NSDictionary))
                
            }
//            let option = response.object(forKey: "optionList") as? NSArray ?? []
//            for options in option {
//                self.arrayoptions.append(getOptions( options as! NSDictionary))
//            }

            
            DispatchQueue.main.async {
                self.pollTableView.reloadData()
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
    @IBAction func BackButton(_ sender: Any) {
        let optionVC = self.storyboard?.instantiateViewController(withIdentifier: "optionPoll") as? PollOptionsViewController
        optionVC?.optionData = arrayoptions
        optionVC?.QuestionData = arrayOfPoll
        self.present(optionVC!, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPoll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "pollcell") as! PollTableViewCell
        
        cell.pollName.text = arrayOfPoll[indexPath.row].namePoll
        cell.pollDate.text = "\(arrayOfPoll[indexPath.row].startTime) to \(arrayOfPoll[indexPath.row].endTime)"
        cell.ViewPoll.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
        
//        if cell.pollDate.text == "Pending"{
//            cell.imageStatus.image = UIImage(named: "icons8-circle_filled_75")
//        }else{
//            cell.imageStatus.image = UIImage(named: "icons8-checked_filled-1")
//
//        }
        
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
