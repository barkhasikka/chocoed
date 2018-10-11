//
//  personalityUpgradeViewController.swift
//  chocoed
//
//  Created by Tejal on 11/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class personalityUpgradeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arrayPersonalityNameStatus = ["Key to improving Personality part 5","Key to improving Personality part 6","Key to improving Personality part 7"]
    var arraycolour = ["Pending","Completed","Inprogress"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPersonalityNameStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personalitycell") as! PersonalityUpgradeTableViewCell
        cell.labelName.text = arrayPersonalityNameStatus [indexPath.row]
        cell.labelStatus.text = arraycolour[indexPath.row]
        if cell.labelStatus.text == "Completed"{
            cell.labelStatus.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }else if cell.labelStatus.text == "Inprogress" {
            cell.labelStatus.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else{
            cell.labelStatus.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        cell.imageviewComp.image = UIImage(named: "computer")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let vcnextDetails = self.storyboard?.instantiateViewController(withIdentifier: "subview") as? SubViewPersonalityUpgradeViewController
        self.navigationController?.pushViewController(vcnextDetails!, animated: true)
    }
    

  
}
