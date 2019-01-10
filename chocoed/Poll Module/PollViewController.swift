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
    var activityUIView: ActivityIndicatorUIView!
    @IBOutlet weak var pollTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPollData()
    }
    
    func loadPollData(){
        
        if self.arrayOfPoll.count > 0 {
            self.arrayOfPoll.removeAll()
        }

        let userID = UserDefaults.standard.integer(forKey: "userid")
        print(userID, "USER ID IS HERE")
        //let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        
        print(params)

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
                
                if poll.count == 0 {
                    let msg =  response.object(forKey: "statusMessage") as? NSString ?? ""
                    let alert = GetAlertWithOKAction(message: msg as String)
                    self.present(alert, animated: true, completion: nil)
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
    @IBAction func BackButton(_ sender: Any) {
       /* let optionVC = self.storyboard?.instantiateViewController(withIdentifier: "optionPoll") as? PollOptionsViewController
        optionVC?.optionData = arrayoptions
        optionVC?.QuestionData = arrayOfPoll
        self.present(optionVC!, animated: true, completion: nil)*/
        
        let vcbackDashboard = self.storyboard?.instantiateViewController(withIdentifier: "split") as? SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: vcbackDashboard!)
        aObjNavi.navigationBar.barTintColor = #colorLiteral(red: 0.08052674438, green: 0.186350315, blue: 0.8756543464, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.present(aObjNavi, animated: true, completion: nil)

        
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
        cell.pollDate.text = "\(Utils.getDateTimePoll(date:arrayOfPoll[indexPath.row].startTime)) to \(Utils.getDateTimePoll(date:arrayOfPoll[indexPath.row].endTime))"
        cell.ViewPoll.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
        print(arrayOfPoll[indexPath.row].status);
        
        
        
        
        if arrayOfPoll[indexPath.row].status == "0" {
            // lock
            cell.imageStatus.image = UIImage(named: "lock")
            
        }else if arrayOfPoll[indexPath.row].status == "3" {
            // lock
            cell.imageStatus.image = UIImage(named: "podium")
            
        }else  if arrayOfPoll[indexPath.row].Voted == 1 {
            
            cell.imageStatus.image = UIImage(named: "voted_green")

            // in progress
        }else if arrayOfPoll[indexPath.row].Voted == 0 {
            // result finish
            
            cell.imageStatus.image = UIImage(named: "votepending")

            
        }
        
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = arrayOfPoll[indexPath.row]
        
        print(item)
    
        if item.status == "0" {
            
    
            let language = UserDefaults.standard.string(forKey: "currentlanguage")
            let alertcontrol = UIAlertController(title:"Alert", message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName), This poll is not open yet for accepting votes. Please refer to start time of poll.", preferredStyle: .alert)
            
            
            let alertaction = UIAlertAction(title: "OkKey".localizableString(loc: language!), style: .default, handler: nil)
            alertcontrol.addAction(alertaction)
            
            self.present(alertcontrol, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: false)
            
            
            
        }else if item.status == "3" {
            
            let optionVC = self.storyboard?.instantiateViewController(withIdentifier: "PollResultVC") as? PollResultVC
            // optionVC?.optionData = arrayoptions
            optionVC?.QuestionData = arrayOfPoll
            optionVC?.currentQuestion = indexPath.row
            DispatchQueue.main.async {
                self.present(optionVC!, animated: true, completion: nil)
            }
            
            
        }else if item.status == "1" || item.status == "2" {
        
            if item.Voted == 1 {
            
            if item.ShowProgress == 1 {
                print("poll vc call")
                // show graph
                
                let optionVC = self.storyboard?.instantiateViewController(withIdentifier: "PollResultVC") as? PollResultVC
                // optionVC?.optionData = arrayoptions
                optionVC?.QuestionData = arrayOfPoll
                optionVC?.currentQuestion = indexPath.row
                DispatchQueue.main.async {
                self.present(optionVC!, animated: true, completion: nil)
                
                }
                
            }else{
                
                // popup msg
                
                let language = UserDefaults.standard.string(forKey: "currentlanguage")
                let alertcontrol = UIAlertController(title:"Alert", message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName)  , You already registered your choice for this poll. You will be notified once the poll results are declared", preferredStyle: .alert)
                let alertaction = UIAlertAction(title: "OkKey".localizableString(loc: language!), style: .default, handler: nil)
                alertcontrol.addAction(alertaction)
                
                self.present(alertcontrol, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: false)
                
                
            }
            
        }else{
                
                if item.status == "1" {
                    
                    let optionVC = self.storyboard?.instantiateViewController(withIdentifier: "optionPoll") as? PollOptionsViewController
                    optionVC?.QuestionData = arrayOfPoll
                    optionVC?.currentQuestion = indexPath.row
                    DispatchQueue.main.async {
                        self.present(optionVC!, animated: true, completion: nil)
                    }
                    
                }else if item.status == "2"{
                    
                      if item.ShowProgress == 1 {
                        
                        let optionVC = self.storyboard?.instantiateViewController(withIdentifier: "PollResultVC") as? PollResultVC
                        // optionVC?.optionData = arrayoptions
                        optionVC?.QuestionData = arrayOfPoll
                        optionVC?.currentQuestion = indexPath.row
                        DispatchQueue.main.async {
                            self.present(optionVC!, animated: true, completion: nil)
                            
                        }
                        
                      }else{
                        
                        let language = UserDefaults.standard.string(forKey: "currentlanguage")
                        let alertcontrol = UIAlertController(title:"Alert", message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName)  , You have missed end date for this poll. You will be notified once the poll results are available", preferredStyle: .alert)
                        let alertaction = UIAlertAction(title: "OkKey".localizableString(loc: language!), style: .default, handler: nil)
                        alertcontrol.addAction(alertaction)
                        
                        self.present(alertcontrol, animated: true, completion: nil)
                        tableView.deselectRow(at: indexPath, animated: false)
                        
                      }
                    
                    
                }
            
            
            
        }
        
      }
    }
    
}
