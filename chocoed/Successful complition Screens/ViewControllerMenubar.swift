//
//  ViewControllerMenubar2DonarViewController.swift
//  chocoed
//
//  Created by Tejal on 05/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ViewControllerMenubar: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arraymenu = ["My Story","My Thought","My Progress","My Profile","Log out"]
    let cousesImages = [UIImage(named:"lotus_icon"),UIImage(named: "lotus_icon"), UIImage(named: "lotus_icon"), UIImage(named: "lotus_icon"), UIImage(named: "lotus_icon")]
    
    override func viewDidLoad() {
     super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraymenu.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell") as! MenuBarTableViewCell
        
        let images = cousesImages[indexPath .row]
        
        cell.labelName.text = arraymenu[indexPath.row]
        
        cell.labelimages.image = images
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
            
            case 0: let v1 = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
            self.present(v1, animated: true, completion: nil)
            break;
            
//        case 1 : let v2 = self.storyboard?.instantiateViewController(withIdentifier: "contactpass") as! ViewControllerContactus
//
//        present(v2, animated: true, completion: nil)
//
//        break;
//
//        case 2 : let v3 = self.storyboard?.instantiateViewController(withIdentifier: "Terms") as! ViewControllerTOU
//
//        present(v3, animated: true, completion: nil)
//        break;
//
//
//        case 3 : let v4 = self.storyboard?.instantiateViewController(withIdentifier: "privacy2") as! viewControllerPrivacypolicy
//
//        present(v4, animated: true, completion: nil)
//        break;
//        case 4 :
//            UserDefaults.standard.set(false, forKey: "isNgoLoggedIn")
//            UserDefaults.standard.synchronize()
//
//            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "pass") as! ViewController
//
//            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//
//            appDel.window?.rootViewController = loginVC
//            //let vc = self.storyboard?.instantiateViewController(withIdentifier: "pass") as! ViewController
//            //    self.present(vc, animated: true, completion: nil)
//            break;
        default: break

        }
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