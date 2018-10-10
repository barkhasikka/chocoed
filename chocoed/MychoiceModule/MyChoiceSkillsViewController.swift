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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        let vcbackDashboard = self.storyboard?.instantiateViewController(withIdentifier: "split") as? SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: vcbackDashboard!)
        aObjNavi.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
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
}
