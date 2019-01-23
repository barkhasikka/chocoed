//
//  NominationOfNGOViewController.swift
//  chocoed
//
//  Created by Tejal on 03/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit



class NominationOfNGOViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collectionNGO: UICollectionView!
    
    var activityUIView: ActivityIndicatorUIView!
    var arrayNGO = [getNgoDetails]()
    
    var from : String = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true

        loadNgoList()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNgoList(){
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        print(userID, "USER ID IS HERE")
      
        let params = ["userId": "\(userID)","clientId": "\(clientID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        
        
        print(params)
        
        
        MakeHttpPostRequest(url: getNgoList, params: params, completion: {(success, response) -> Void in
            print(response)
            let list = response.object(forKey: "list") as? NSArray ?? []
            
            for Ngo in list {
                self.arrayNGO.append(getNgoDetails( Ngo as! NSDictionary))
            }
            
            if self.arrayNGO.count == 0{
                let alert = GetAlertWithOKAction(message: "Not data to show")
                self.present(alert, animated: true, completion: nil)
                
            }
            DispatchQueue.main.async {
                self.collectionNGO.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayNGO.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ngolist", for: indexPath) as! NGONomineeCollectionViewCell
       
//        cell.imageViewBackground.image = UIImage.init(named: "icons_user")
        
        cell.labelName.text = arrayNGO[indexPath.row].name
      
        let fileUrl = URL(string: arrayNGO[indexPath.row].imageURL)
       
        
        cell.logoImage.sd_setImage(with: fileUrl)
        
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if from == "" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "userNGOcell") as? UsersOfNGOViewController
            vc?.ngoId = self.arrayNGO[indexPath.row].id
            self.present(vc!, animated: true, completion: nil)
            
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "userNGOcell") as? UsersOfNGOViewController
            vc?.ngoId = self.arrayNGO[indexPath.row].id
            vc?.from = "sponsership"
            self.present(vc!, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        if from == "sponsership" {
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "empower") as! EmpowerViewController
            self.present(v1, animated: true, completion: nil)
            
        }else{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "nominee") as? NominationViewController
            self.present(vc!, animated: true, completion: nil)
        }
        
        
    }
    
}
