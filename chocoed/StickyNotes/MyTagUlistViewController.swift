//
//  MyTagUlistViewController.swift
//  chocoed
//
//  Created by Tejal on 05/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class MyTagUlistViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var activityUIView: ActivityIndicatorUIView!
    @IBOutlet weak var tabelViewStickyList: UITableView!
    var arrayTagUlist = [getStickyNotesList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true

        
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)

        loadSTickyNotesList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButton(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTagUlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "mytagu", for: indexPath) as! MytagUlistTableViewCell
        cell.gradiantImage.backgroundColor = UIColor(named: "\(arrayTagUlist[indexPath.row].colour)")
        cell.imagePin.image = UIImage(named: "pin")
        cell.labelName.text = arrayTagUlist[indexPath.row].title
        cell.labelDiscription.text = arrayTagUlist[indexPath.row].notes
        
        return cell
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
