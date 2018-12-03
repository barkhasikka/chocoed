//
//  ProfileVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 10/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData


class ProfileVC: UIViewController {
    
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet weak var mediaButton: UIButton!
    @IBOutlet weak var deleteFriendButton: UIButton!
    
    var contactMobileNumber : String = ""
    var profileiMage : String = ""
    var name : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        mediaButton.setTitle("MediabuttonKey".localizableString(loc: language!), for: .normal)
        deleteFriendButton.setTitle("DeleteButtonKey".localizableString(loc: language!), for: .normal)

        
        
        
        self.lblName.text = self.name
        self.profileImage.sd_setImage(with : URL(string: self.profileiMage))
        self.profileImage.contentMode = .scaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back_btn_clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func media_btn_clicked(_ sender: Any) {
        
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "MediaVC") as? MediaVC {
            vcNewSectionStarted.number = self.contactMobileNumber
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
    }
    @IBAction func block_btn_clicked(_ sender: Any) {
        
        let alertView = UIAlertController(title: "Delete", message: "Are you sure you want to delete \(self.name) from your friend list?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Not Now", style: .default, handler: { (alert) in
          
        })
        alertView.addAction(action)
        
        let actionSure = UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
          
            self.deleteAPI()
            
        })
        alertView.addAction(actionSure)
        self.present(alertView, animated: true, completion: nil)
        
        
        
    }
    
    func deleteAPI(){
        
        
        let params = ["my_no": "\(USERDETAILS.mobile)","friend_no": "\(self.contactMobileNumber)"]
        print(params)
        MakeHttpPostRequestChat(url: kXMPP.deleteFriend, params: params, completion: {(success, response) in
            print(response)
            
            
            let res = response.object(forKey: "responce") as? Int ?? 0
            
            if res == 1 {
                
                //
                
                self.clearData()
                
            }
            
           
        }, errorHandler: {(message) -> Void in
            print("message", message)
        })
        
    }
    
    private func clearData() {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Msg.self))
            fetchRequest.predicate = NSPredicate(format: "to_id == %@",self.contactMobileNumber)
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                
                for item in objects!{
                    context.delete(item)
                }
                
                self.clearFriend()
                
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    private func clearFriend() {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Friends.self))
            fetchRequest.predicate = NSPredicate(format: "contact_number == %@",self.contactMobileNumber)
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                
                for item in objects!{
                    context.delete(item)
                }
                
                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "FriendListVC") as? FriendListVC{
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                }
                
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    
}
