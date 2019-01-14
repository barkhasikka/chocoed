//
//  MyTagUlistViewController.swift
//  chocoed
//
//  Created by Tejal on 05/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class MyTagUlistViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var noStickyView: UIView!
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var addStickyLabel: UILabel!
    
    var activityUIView: ActivityIndicatorUIView!
    @IBOutlet weak var tabelViewStickyList: UITableView!
    var arrayTagUlist = [getStickyNotesList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true

        
        circleView.layer.cornerRadius = 100
        circleView.layer.borderColor = #colorLiteral(red: 0.1529411765, green: 0.5490196078, blue: 0.937254902, alpha: 1)
        circleView.layer.borderWidth = 2
        circleView.clipsToBounds = true
        
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
//        self.noStickyView.isHidden = false
        
        loadSTickyNotesList()
        print(arrayTagUlist.count)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButton(_ sender: Any) {
        
        let vcbackDashboard = self.storyboard?.instantiateViewController(withIdentifier: "split") as? SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: vcbackDashboard!)
        aObjNavi.navigationBar.barTintColor = #colorLiteral(red: 0.08052674438, green: 0.186350315, blue: 0.8756543464, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.present(aObjNavi, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTagUlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mytagu", for: indexPath) as! MytagUlistTableViewCell
        let imagecolour = hexStringToUIColor(hex: arrayTagUlist[indexPath.row].colour)
        cell.gradiantImage.backgroundColor = imagecolour
        cell.imagePin.image = UIImage(named: "pin")
        cell.labelName.text = arrayTagUlist[indexPath.row].title
        cell.labelDiscription.text = arrayTagUlist[indexPath.row].notes
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = deleteAction(at: indexPath)
            let share = shareAction(at: indexPath)
            
            return UISwipeActionsConfiguration(actions: [delete,share])
    
        return UISwipeActionsConfiguration()
    }
    
    func shareAction(at indexpath: IndexPath) -> UIContextualAction{
        let todo =  arrayTagUlist[indexpath.row].id
        let action = UIContextualAction(style: .normal, title: "Share") { (action, view, completion) in
            completion(true)
            
        }
       // action.image =
        action.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return action
    }
        
    @IBAction func addStickies(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "stickyNotes") as? StickyNoteViewController
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func addStickyButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "stickyNotes") as? StickyNoteViewController
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    
    func deleteAction(at indexpath: IndexPath) -> UIContextualAction{
        let todo = arrayTagUlist[indexpath.row].id
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            completion(true)
            let userID = UserDefaults.standard.integer(forKey: "userid")
            let clientID = UserDefaults.standard.integer(forKey: "clientid")
            print(userID, "USER ID IS HERE")
            
            let params = ["userId": "\(userID)","clientId": "\(clientID)",  "access_token":"\(accessToken)","stickyNoteId" : "\(self.arrayTagUlist[indexpath.row].id)"] as Dictionary<String, String>
            
            print(params)
            
            
            MakeHttpPostRequest(url: deleteStickyNote, params: params, completion: {(success, response) -> Void in
                print(response)
                
                DispatchQueue.main.async {
                    
                    self.tabelViewStickyList.reloadData()
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                }
                self.arrayTagUlist.removeAll()
                self.loadSTickyNotesList()
                
            }, errorHandler: {(message) -> Void in
                let alert = GetAlertWithOKAction(message: message)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                    
                }
            })

        }
       // action.image =
        action.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return action
        
    }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func loadSTickyNotesList(){
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        print(userID, "USER ID IS HERE")
        
        let params = ["userId": "\(userID)","clientId": "\(clientID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        
        
        print(params)
        
        
        MakeHttpPostRequest(url: StickyNotesList, params: params, completion: {(success, response) -> Void in
            print(response)
            let list = response.object(forKey: "list") as? NSArray ?? []
            
            for stickyNote in list {
                self.arrayTagUlist.append(getStickyNotesList( stickyNote as! NSDictionary))
            }
            
            

            DispatchQueue.main.async {
                
                if self.arrayTagUlist.count == 0{
                    self.noStickyView.isHidden = false
                    self.tabelViewStickyList.isHidden = true

                }else{
                self.noStickyView.isHidden = true
                self.tabelViewStickyList.isHidden = false
                }
                self.tabelViewStickyList.reloadData()
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

