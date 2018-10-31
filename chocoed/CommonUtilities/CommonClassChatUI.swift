//
//  CommonClassChatUI.swift
//  chocoed
//
//  Created by Tejal on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation
import UIKit

class CommonChatLabel : UIView{
        var ProfileImagechat : UIImageView!
        var labelChat : UILabel!
        var labelTime : UILabel!
    
        override init(frame: CGRect){
            super.init(frame: frame)
            self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            ProfileImagechat = UIImageView(frame: CGRect.zero)
            ProfileImagechat.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            ProfileImagechat.translatesAutoresizingMaskIntoConstraints = false
            ProfileImagechat.heightAnchor.constraint(equalToConstant: 50).isActive = true
            ProfileImagechat.alignmentRectInsets.left
            ProfileImagechat.contentMode = .scaleToFill
            ProfileImagechat.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
            ProfileImagechat.widthAnchor.constraint(equalToConstant: 50).isActive = true
            self.addSubview(ProfileImagechat)
            
            labelChat.translatesAutoresizingMaskIntoConstraints = false
            labelChat = UILabel(frame: CGRect.zero)
            labelChat.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            labelChat.font = UIFont(name: "Halvetica", size: 15)
            labelChat.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            labelChat.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
            labelChat.leadingAnchor.constraint(equalTo: ProfileImagechat.trailingAnchor , constant: 10).isActive = true
            labelChat.numberOfLines = 0
            labelChat.lineBreakMode = .byWordWrapping
            self.addSubview(labelChat)
            
            labelChat.translatesAutoresizingMaskIntoConstraints = false
            labelTime = UILabel(frame: CGRect.zero)
            labelTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            labelTime.font = UIFont(name: "Halvetica", size: 15)
            labelTime.heightAnchor.constraint(equalToConstant: 20).isActive = false
            labelTime.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -10).isActive = true
            labelTime.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -10).isActive = true
            labelTime.textAlignment = .right
            self.addSubview(labelTime)
            
            }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ImagewithLabel : UIView{
    var RandomImagechat : UIImageView!
    var ImagelabelChat : UILabel!
    var labelTime : UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        RandomImagechat.translatesAutoresizingMaskIntoConstraints = false
        RandomImagechat = UIImageView(frame: CGRect.zero)
        RandomImagechat.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        RandomImagechat.contentMode = .scaleToFill
        RandomImagechat.topAnchor.constraint(equalTo: self.topAnchor , constant: 10).isActive = true
        RandomImagechat.heightAnchor.constraint(equalToConstant: 150).isActive = true
        RandomImagechat.alignmentRectInsets.right
        RandomImagechat.widthAnchor.constraint(equalToConstant: 150).isActive = true
        RandomImagechat.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -50).isActive = true
        RandomImagechat.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        RandomImagechat.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.addSubview(RandomImagechat)
        
        ImagelabelChat.translatesAutoresizingMaskIntoConstraints = false
        ImagelabelChat = UILabel(frame: CGRect.zero)
        ImagelabelChat.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ImagelabelChat.topAnchor.constraint(equalTo: RandomImagechat.topAnchor, constant:0).isActive = true
        ImagelabelChat.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 10).isActive = true
        ImagelabelChat.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ImagelabelChat.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        ImagelabelChat.numberOfLines = 0
        ImagelabelChat.lineBreakMode = .byWordWrapping
        self.addSubview(ImagelabelChat)
        
        
}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

