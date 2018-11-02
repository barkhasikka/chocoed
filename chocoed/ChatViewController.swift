//
//  ChatViewController.swift
//  chocoed
//
//  Created by Tejal on 01/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    let objChat = CommonChatLabel()
    let imageChat = ImagewithLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(objChat)
        self.view.addSubview(imageChat)
        
        constraintsToImageChatView()
        constraintsToTextChatView()
         // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func constraintsToTextChatView(){
        
        self.objChat.translatesAutoresizingMaskIntoConstraints = false
        self.objChat.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        self.objChat.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
      //  self.objChat.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        self.objChat.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.objChat.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.objChat.layer.cornerRadius = 5
        self.objChat.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.objChat.clipsToBounds = true
        
    }
    
    func constraintsToImageChatView() {
        self.imageChat.layer.cornerRadius = 5
        self.imageChat.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.imageChat.clipsToBounds = true
        self.imageChat.translatesAutoresizingMaskIntoConstraints = false
        self.imageChat.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        self.imageChat.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.imageChat.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.imageChat.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200).isActive = true
        self.imageChat.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -8).isActive = true

    }
}
