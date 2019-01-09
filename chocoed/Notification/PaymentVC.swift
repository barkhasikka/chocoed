//
//  PaymentVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 08/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import WebKit
//import PaymentSDK

class PaymentVC: UIViewController {//}, PGTransactionDelegate {
    
    
    //this function triggers when transaction gets finished
    /*func didFinishedResponse(_ controller: PGTransactionViewController, response responseString: String) {
        let msg : String = responseString
        var titlemsg : String = ""
        if let data = responseString.data(using: String.Encoding.utf8) {
            do {
                if let jsonresponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] , jsonresponse.count > 0{
                    titlemsg = jsonresponse["STATUS"] as? String ?? ""
                }
            } catch {
                print("Something went wrong")
            }
        }
        let actionSheetController: UIAlertController = UIAlertController(title: titlemsg , message: msg, preferredStyle: .alert)
        let cancelAction : UIAlertAction = UIAlertAction(title: "OK", style: .cancel) {
            action -> Void in
            controller.navigationController?.popViewController(animated: true)
        }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    //this function triggers when transaction gets cancelled
    func didCancelTrasaction(_ controller : PGTransactionViewController) {
        controller.navigationController?.popViewController(animated: true)
    }
    //Called when a required parameter is missing.
    func errorMisssingParameter(_ controller : PGTransactionViewController, error : NSError?) {
        controller.navigationController?.popViewController(animated: true)
    }
    */
    
    

    
    @IBOutlet var webView: WKWebView!
    var activityUIView: ActivityIndicatorUIView!

    
   // var serv : PGServerEnvironment!
    //var txnController : PGTransactionViewController!
    
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
        
      /*  activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        self.loadPayment() */
        
    }
    
    
 /*   func pay(orderID : String,checksum : String,amt : String){
        
        let userID = UserDefaults.standard.integer(forKey: "userid")

        //serv = PGT
        //serv = serv.createStagingEnvironment()
        let type :ServerType = .eServerTypeStaging
        let order = PGOrder(orderID: "", customerID: "", amount: "", eMail: "", mobile: "")
        
        order.params = ["MID": "KgmmBI95435812715183",
                        "ORDER_ID": orderID,
                        "CUST_ID": userID,
                        "MOBILE_NO": USERDETAILS.mobile,
                        "EMAIL": USERDETAILS.email,
                        "CHANNEL_ID": "WAP",
                        "WEBSITE": "chocoed",
                        "TXN_AMOUNT": amt,
                        "INDUSTRY_TYPE_ID": "Retail",
                        "CHECKSUMHASH": checksum,
                        "CALLBACK_URL": "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=\(orderID)"]
        
        self.txnController = PGTransactionViewController(transactionParameters: order.params)
        self.txnController.title = "Paytm Payments"
        self.txnController.setLoggingEnabled(true)
        if(type != ServerType.eServerTypeNone) {
            self.txnController.serverType = type;
        } else {
            return
        }
        self.txnController.merchant = PGMerchantConfiguration.defaultConfiguration()
        //self.txnController.merchant?.checksumGenerationURL = ""
        //self.txnController.merchant?.checksumValidationURL = ""
        self.txnController.delegate = self
        self.present(self.txnController, animated: true)
        
    }
    
    
    func loadPayment(){
        
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let diceRoll = arc4random()
        
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","orderId":"\(diceRoll)","email":"\(USERDETAILS.email)","txnAmount":"200","mobileNo":"\(USERDETAILS.mobile)"] as Dictionary<String, String>
        
        print(params)
        
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: ChecksumGeneration, params: params, completion: {(success, response) -> Void in
            DispatchQueue.main.async {
                print(response)
                let checksum = response.object(forKey: "paytmChecksum") as? String ?? ""
                DispatchQueue.main.async {
                    self.activityUIView.isHidden = true
                    self.activityUIView.stopAnimation()
                    self.pay(orderID: String(diceRoll), checksum: checksum, amt: "200")
                }
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
    
    */
   
   

}
