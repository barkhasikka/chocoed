//
//  MyConversationViewController.swift
//  chocoed
//
//  Created by Tejal on 07/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class MyConversationViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var arrayList = [String]()
    var availableString = ""

    
    @IBOutlet var lblTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")

         arrayList = ["MyThoughtKey".localizableString(loc:language!),
                  "MytalksKey".localizableString(loc:language!),
                  "MyVoiceKey".localizableString(loc: language!)]
        
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.availableString = "DearKey".localizableString(loc: language!) + " \(USERDETAILS.firstName) "  + "availableStringKey".localizableString(loc: language!)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conversationcell", for: indexPath) as! ConversationCollectionViewCell
        
        cell.labelName.text = arrayList[indexPath.row]
        
        if indexPath.row == 0 {
            cell.imageView.image = UIImage(named: "Mythoughts")
        }
        
        if indexPath.row == 1 {
            cell.imageView.image = UIImage(named: "Icon-App-40x40-2")
        }
        
        if indexPath.row == 2 {
            cell.imageView.image = UIImage(named: "elections")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(indexPath.row)
        {
        case 0 :
           
             let alert = GetAlertWithOKAction(message: availableString)
             self.present(alert, animated: true, completion: nil)
            
            break
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FriendListVC") as? FriendListVC
            self.present(vc!, animated: true, completion: nil)

            break
        case 2:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "poll") as? PollViewController
            self.present(vc!, animated: true, completion: nil)
            
            break
        default:
            print("defalut is selected")
            break
        }
    }
   
    
    @IBAction func BackButtonAction(_ sender: Any) {
        let vcbackDashboard = self.storyboard?.instantiateViewController(withIdentifier: "split") as? SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: vcbackDashboard!)
        aObjNavi.navigationBar.barTintColor = #colorLiteral(red: 0.08052674438, green: 0.186350315, blue: 0.8756543464, alpha: 1)
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

}
