//
//  MyChoiceSkillsViewController.swift
//  chocoed
//
//  Created by Tejal on 10/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class MyChoiceSkillsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillcell", for: indexPath) as! MyskillsCollectionViewCell
        cell.name.text = "Tejal"
        cell.imageview.image = UIImage(named: "image_icon")
        return cell
    }
}
