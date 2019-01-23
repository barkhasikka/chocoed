//
//  EmpowerViewController.swift
//  chocoed
//
//  Created by Tejal on 18/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit


class EmpowerViewController: UIViewController , AddContactProtocol,UITableViewDelegate,UITableViewDataSource {
    
    
   
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lableDesc: UILabel!
    
    
    @IBAction func addContact_clicked(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "nominee") as? NominationViewController
        vc?.from = "sponsership"
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    
  
    
    @IBAction func ngoBtn_clicked(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ngoNominee") as? NominationOfNGOViewController
        vc?.from = "sponsership"
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tblView.reloadData()

        
    }


    
    @IBOutlet var tblView: UITableView!
    
    func setUserData() {
        
        self.tblView.reloadData()
    }
    
    
    
    @IBAction func payment_BtnClicked(_ sender: Any) {
        
        
        if GlobalUsersList.count == 0{
            let alert = GetAlertWithOKAction(message: "Select User")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
    }
    
    
    @IBAction func back_btn(_ sender: Any) {
        
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: startVC)
        aObjNavi.navigationBar.barTintColor = UIColor.blue
        self.present(aObjNavi, animated: true, completion: nil)
        
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalUsersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpowerTableViewCell") as! EmpowerTableViewCell
        
        cell.labelDescription.text = GlobalUsersList[indexPath.row].occupation
        cell.NameofContact.text = "\(GlobalUsersList[indexPath.row].firstName) \(GlobalUsersList[indexPath.row].lastName)"
        cell.amountlabel.text = "5000"
        let fileUrl = URL(string: GlobalUsersList[indexPath.row].profileImageUrl)
        cell.imageViewEmpower.sd_setImage(with: fileUrl)
        return cell
        
    }

}
