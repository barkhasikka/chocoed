//
//  LanguageSelectionViewController.swift
//  chocoed
//
//  Created by Tejal on 22/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import DropDown

class LanguageSelectionViewController: UIViewController {
    var arrayLanguages = [LanguageList]()
    @IBOutlet weak var primaryLangButton: ButtonWithImage!
    @IBOutlet weak var SecondaryLangButton: ButtonWithImage!
    @IBOutlet weak var ApplicationLangButton: ButtonWithImage!
    var dropDown: DropDown!
    var activityUIView: ActivityIndicatorUIView!
    var tableViewData =  [String]()
   // var selctedLang = LanguageList()
    var storedApplang = "en"
    var currentSelectedButton: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        loadGetLanguageList()
        dropDown = DropDown()
        dropDown.direction = .any
        dropDown.dismissMode = .automatic
        dropDown.hide()
        dropDown.layer.cornerRadius = 8
        dropDown.clipsToBounds =  true
        dropDown.layer.borderWidth = 5
        dropDown.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
//        if selctedLang != nil && selctedLang.id != nil {
//            initView()
//        }
//
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            switch self.currentSelectedButton {
            case "Application":
                self.storedApplang = self.arrayLanguages[index].langDispalyName
                self.ApplicationLangButton.setTitle(self.arrayLanguages[index].langDispalyName, for: .normal)
                switch item {
                case "English":
                    UserDefaults.standard.set("en", forKey: "currentlanguage")
                    
                case "हिंदी":
                    UserDefaults.standard.set("hi", forKey: "currentlanguage")
                default:
                    UserDefaults.standard.set("en", forKey: "currentlanguage")
                    print("other are yet to come")
                }
            case "Primary":
               // self.selctedLang.langDispalyName = self.arrayLanguages[index].langDispalyName
                self.primaryLangButton.setTitle(self.arrayLanguages[index].langDispalyName, for: .normal)
            case "Secondary":
                //self.selctedLang.langDispalyName = self.arrayLanguages[index].langDispalyName
                self.SecondaryLangButton.setTitle(self.arrayLanguages[index].langDispalyName, for: .normal)
            default:
                print("whoops")
            }
    }
}
    
    @IBAction func SecondaryLernLangAction(_ sender: Any) {
        self.view.endEditing(true)
        var tableViewData =  [String]()
        
        for Seclang in  self.arrayLanguages {
            tableViewData.append(String(Seclang.langDispalyName))
        }
        dropDown.show()
        dropDown.anchorView = SecondaryLangButton
        dropDown.dataSource = tableViewData
        currentSelectedButton = "Secondary"
    }
    
    @IBAction func PrimaryLernLangAction(_ sender: Any) {
        self.view.endEditing(true)
        var tableViewData =  [String]()
        
        for priLang in self.arrayLanguages {
            tableViewData.append(String(priLang.langDispalyName))
        }
        dropDown.show()
        dropDown.anchorView = primaryLangButton
        dropDown.dataSource = tableViewData
        currentSelectedButton = "Primary"
    }
    @IBAction func apllLangAction(_ sender: Any) {
        self.view.endEditing(true)
        var tableViewData =  [String]()
        
        for appLang in  self.arrayLanguages {
            tableViewData.append(String(appLang.langDispalyName))
        }
        dropDown.show()
        dropDown.anchorView = ApplicationLangButton
        dropDown.dataSource = tableViewData
        currentSelectedButton = "Application"
        
    //    UserDefaults.standard.set("hi", forKey: "currentlanguage")
        
//        switch self.storedApplang {
//        case "English":
//            UserDefaults.standard.set("en", forKey: "currentlanguage")
//
//        case "हिंदी":
//            UserDefaults.standard.set("hi", forKey: "currentlanguage")
//        default:
//            UserDefaults.standard.set("hi", forKey: "currentlanguage")
//            print("other are yet to come")
//        }
    }
    @IBAction func DoneButtonaction(_ sender: Any) {
        let startVC = self.storyboard?.instantiateViewController(withIdentifier: "profileSuccess") as! ProfileSucessViewController
        DispatchQueue.main.async {
            self.present(startVC, animated: true, completion: nil)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func initView() {
//        self.ApplicationLangButton.setTitle(selctedLang.langDispalyName , for: .normal)
//        self.primaryLangButton.setTitle(selctedLang.langDispalyName, for: .normal)
//        self.SecondaryLangButton.setTitle(selctedLang.langDispalyName, for: .normal)
//       
//    }

    func loadGetLanguageList() {
        let clientid = UserDefaults.standard.string(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid)","clientId":"\(clientid)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getLanguageListCall, params: params, completion: {(success, response) -> Void in
            print(response)
            let language = response.object(forKey: "appList") as? NSArray ?? []
            
            for languages in language {
                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
                
            }
            DispatchQueue.main.async {
               // self.tableViewLanguage.reloadData()
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
            print(self.arrayLanguages)
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                
            }
        })
        
    }


}
