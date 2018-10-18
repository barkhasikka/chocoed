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
    var label: UILabel = UILabel()
    var btn: UIButton = UIButton()
    var arrayLanguages = [LanguageList]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customElemetsOfview()
        tableViewLanguage = UITableView(frame: CGRect(x: 0, y: 40, width: self.frame.width - 30, height: self.frame.height - 30))
        self.addSubview(tableViewLanguage)
        tableViewLanguage.dataSource = self
        tableViewLanguage.register(CommonLanguageTableViewCell.self, forCellReuseIdentifier: "cell")
        
        loadGetLanguageList()
        }
    func customElemetsOfview()
    {
        btn.frame = CGRect(x: 0, y: 0, width: 30 , height: 40)
        btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.setTitle("X", for: UIControlState.normal)
        btn.setTitleColor(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(closeButton), for: UIControlEvents.touchUpInside)
        self.addSubview(btn)

        label.frame = CGRect(x: 30 , y: 0, width: 300 , height: 40)
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        label.text = "Please select the Preferred language"
        self.addSubview(label)
    }
    @objc func closeButton()
    {
        print("Close button pressed")
        self.isHidden = true
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
