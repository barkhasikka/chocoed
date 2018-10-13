//
//  MyChoiceSkillsViewController.swift
//  chocoed
//
//  Created by Tejal on 10/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class MyChoiceSkillsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionViewSkills: UICollectionView!
    let arrayTitle = ["Soft Skills","Sales Skills","Customer Skills","Life Skills","Retail Skills"]
    let images = [UIImage(named: "soft_skills"),UIImage(named: "sales_skills"),UIImage(named: "customer_skills"), UIImage(named: "life_skills"),UIImage(named: "conversation_big")]
    var activityUIView: ActivityIndicatorUIView!
    
    var arrayCourseList = [CourseList]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true

        loadApiMyChioceList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadApiMyChioceList()
    {
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientId = UserDefaults.standard.integer(forKey: "clientid")
        
        print(userID, "USER ID IS HERE")
        let params = ["userId": "\(userID)",  "access_token":"\(accessToken)", "clientId": "\(clientId)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        
        MakeHttpPostRequest(url: getMyCourseTopics, params: params, completion: {(success, response) in
            print(response)
            self.arrayCourseList = [CourseList]()
            let list = response.object(forKey: "list") as? NSArray ?? []
            for (index, courses) in list.enumerated() {
                self.arrayCourseList.append(CourseList(courses as! NSDictionary))
            }
            
            var something = ["calenderId" : "0", "courseId" : "-1", "courseImageUrl" : "sales_skills", "courseName" : "Sales Skills"] as [String : Any]
            self.arrayCourseList.append(CourseList(something as NSDictionary))
            
            something = ["calenderId" : "0","courseId" : "-1","courseImageUrl" : "customer_skills","courseName" : "Customer Skills"] as [String : Any]
            self.arrayCourseList.append(CourseList(something as NSDictionary))
            
            something = ["calenderId" : "0","courseId" : "-1","courseImageUrl" : "life_skills","courseName" : "Life Skills"] as [String : Any]
            self.arrayCourseList.append(CourseList(something as NSDictionary))
            
            something = ["calenderId" : "0","courseId" : "-1","courseImageUrl" : "conversation_big","courseName" : "Life Skills"] as [String : Any]
            self.arrayCourseList.append(CourseList(something as NSDictionary))
            
            print(self.arrayCourseList.count)
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                self.collectionViewSkills.reloadData()
                
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
    @IBAction func backButtonAction(_ sender: Any) {
        
        let vcbackDashboard = self.storyboard?.instantiateViewController(withIdentifier: "split") as? SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: vcbackDashboard!)
        aObjNavi.navigationBar.barTintColor = #colorLiteral(red: 0.1383176144, green: 0.2274862162, blue: 0.8604259201, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.present(aObjNavi, animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCourseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillcell", for: indexPath) as! MyskillsCollectionViewCell
        cell.name.text = self.arrayCourseList[indexPath.row].courseName
        if self.arrayCourseList[indexPath.row].courseId == "-1" {
            cell.imageview.image = UIImage(named: self.arrayCourseList[indexPath.row].courseImageUrl)
        }else {
            let fileUrl = URL(string: arrayCourseList[indexPath.row].courseImageUrl)
            if arrayCourseList[indexPath.row].courseImageUrl != ""
            {
                if let data = try? Data(contentsOf: fileUrl!) {
                    if let image = UIImage(data: data) {
                        cell.imageview.contentMode = .scaleAspectFit
                        
                        cell.imageview.image = image
                    }
                }
            }
            
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vcSkills = self.storyboard?.instantiateViewController(withIdentifier: "personalityupgrade") as? personalityUpgradeViewController
            var courseidStored = self.arrayCourseList[indexPath.row].courseId
            var clanderidStored = self.arrayCourseList[indexPath.row].calenderId
            
            print(courseidStored)
            print(clanderidStored)
            vcSkills?.temp = courseidStored
            vcSkills?.temp1 = clanderidStored
            let aObjNavi = UINavigationController(rootViewController: vcSkills!)
            aObjNavi.navigationBar.barTintColor = #colorLiteral(red: 0.08052674438, green: 0.186350315, blue: 0.8756543464, alpha: 1)
            aObjNavi.navigationBar.tintColor = UIColor.white
            aObjNavi.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
            
            self.present(aObjNavi, animated: true, completion: nil)
            break
        default:
            print("Nothing selected")
        }
    }

}
