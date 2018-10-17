//
//  File.swift
//  chocoed
//
//  Created by Tejal on 17/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation
import UIKit

class LanguageUIView : UIView, UITableViewDelegate ,UITableViewDataSource {
    var tableViewLanguage: UITableView!
    
    var arrayLanguages = [LanguageList]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableViewLanguage = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width - 30, height: self.frame.height - 30))
        self.addSubview(tableViewLanguage)
        tableViewLanguage.dataSource = self
        tableViewLanguage.register(CommonLanguageTableViewCell.self, forCellReuseIdentifier: "cell")
        loadGetLanguageList()
    }
    
    func loadGetLanguageList() {
        let clientid = UserDefaults.standard.string(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid)","clientId":"\(clientid)"] as Dictionary<String, String>
//        activityUIView.isHidden = false
//        activityUIView.startAnimation()
        MakeHttpPostRequest(url: getLanguageListCall, params: params, completion: {(success, response) -> Void in
            print(response)
            let language = response.object(forKey: "appList") as? NSArray ?? []
            
            for languages in language {
                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
                
            }
            DispatchQueue.main.async {
                self.tableViewLanguage.reloadData()
//                self.activityUIView.isHidden = true
//                self.activityUIView.stopAnimation()
            }
            print(self.arrayLanguages)
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
//                self.present(alert, animated: true, completion: nil)
//                self.activityUIView.isHidden = true
//                self.activityUIView.stopAnimation()
//
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommonLanguageTableViewCell
        cell.labelLanguage.translatesAutoresizingMaskIntoConstraints =  false
        cell.labelLanguage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cell.labelLanguage.topAnchor.constraint(equalTo: cell.topAnchor, constant: 5).isActive = true
        cell.labelLanguage.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -5).isActive = true
        cell.labelLanguage.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -5).isActive = true
        cell.labelLanguage.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
        cell.labelLanguage.text = "\(arrayLanguages[indexPath.row].dbname) \(arrayLanguages[indexPath.row].langDispalyName)"
        return cell
    }
    
    
}
