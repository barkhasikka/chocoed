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
        //let params = ["userId": "\(userID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        let params = ["userId": "\(userID)","clientId": "\(clientID)",  "access_token":"\(accessToken)"] as Dictionary<String, String>
        
        
        print(params)
        
        
        MakeHttpPostRequest(url: getNgoList, params: params, completion: {(success, response) -> Void in
            print(response)
            let list = response.object(forKey: "list") as? NSArray ?? []
            
            for Ngo in list {
                self.arrayNGO.append(getNgoDetails( Ngo as! NSDictionary))
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
       
        cell.imageViewBackground.image = UIImage.init(named: "icons_user")
        
        cell.labelName.text = arrayNGO[indexPath.row].name
      
        let fileUrl = URL(string: arrayNGO[indexPath.row].imageURL)
        if arrayNGO[indexPath.row].imageURL != "" {
            if let data = try? Data(contentsOf: fileUrl!) {
                if let image = UIImage(data: data) {
                    cell.logoImage.contentMode = .scaleAspectFit
                    
                    cell.logoImage.image = image
                }
            }
        }
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "nominee") as? NominationViewController
        self.present(vc!, animated: true, completion: nil)
        
    }
    
}
