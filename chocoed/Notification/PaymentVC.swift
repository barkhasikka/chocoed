//
//  PaymentVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 08/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import WebKit

class PaymentVC: UIViewController {

    
    @IBOutlet var webView: WKWebView!
    
    
    @IBAction func close_btn_clicked(_ sender: Any) {
        
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = mainStoryBoard.instantiateViewController(withIdentifier: "split") as! SplitviewViewController
        let aObjNavi = UINavigationController(rootViewController: startVC)
        aObjNavi.navigationBar.barTintColor = UIColor.blue
        self.present(aObjNavi, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let string = paymentLink+String(userID)
        print(string)
        self.webView.load(URLRequest(url: URL(string: string)!))
    }
    

   

}
