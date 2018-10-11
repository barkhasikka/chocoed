//
//  MyChoiceSkillsViewController.swift
//  chocoed
//
//  Created by Tejal on 10/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class MyChoiceSkillsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    let arrayTitle = ["Soft Skills","Sales Skills","Customer Skills","Life Skills","Retail Skills"]
    let images = [UIImage(named: "soft_skills"),UIImage(named: "sales_skills"),UIImage(named: "customer_skills"), UIImage(named: "life_skills"),UIImage(named: "conversation_big")]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return arrayTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillcell", for: indexPath) as! MyskillsCollectionViewCell
        cell.name.text = arrayTitle[indexPath.row]
        cell.imageview.image = images[indexPath.row]
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
