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
        var ProfileImagechat = UIImageView()
        var labelChat = UILabel()
        var labelTime = UILabel()

        override init(frame: CGRect){
            super.init(frame: frame)
            self.addCustomChatView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addCustomChatView(){
            self.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
           ProfileImagechat = UIImageView(frame: frame)
            self.addSubview(ProfileImagechat)
            ProfileImagechat.translatesAutoresizingMaskIntoConstraints = false
            ProfileImagechat.alignmentRectInsets.left
            ProfileImagechat.contentMode = .scaleToFill
            ProfileImagechat.image = UIImage(named: "Woman1_1")
            ProfileImagechat.layer.cornerRadius = 25
            ProfileImagechat.clipsToBounds = true
            ProfileImagechat.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            ProfileImagechat.heightAnchor.constraint(equalToConstant: 50).isActive = true
            ProfileImagechat.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
            ProfileImagechat.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            ProfileImagechat.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
            labelChat = UILabel(frame: frame)
            labelChat.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           labelChat.font = UIFont(name: "Halvetica", size: 15)
            self.addSubview(labelChat)
            labelChat.translatesAutoresizingMaskIntoConstraints = false
        
            labelChat.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
            labelChat.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            labelChat.leadingAnchor.constraint(equalTo: ProfileImagechat.trailingAnchor).isActive = true
            labelChat.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
            labelChat.numberOfLines = 0
            labelChat.lineBreakMode = .byWordWrapping
        
            labelTime = UILabel(frame: frame)
            labelTime.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            labelTime.font = UIFont(name: "Halvetica", size: 10)
            self.addSubview(labelTime)
            labelTime.translatesAutoresizingMaskIntoConstraints = false
        
        
            labelTime.heightAnchor.constraint(equalToConstant: 20).isActive = false
            labelTime.widthAnchor.constraint(equalToConstant: 70).isActive = true
            labelTime.topAnchor.constraint(equalTo: labelChat.topAnchor, constant: 8).isActive = true
            labelTime.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: 0).isActive = true
            labelTime.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -10).isActive = true
            labelTime.textAlignment = .right
            }
        }

class ImagewithLabel : UIView{
    var RandomImagechat : UIImageView!
    var ImagelabelChat : UILabel!
    var labelTime : UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addImageConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addImageConstraint()
    {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        RandomImagechat = UIImageView(frame: frame)
        self.addSubview(RandomImagechat)
        
        RandomImagechat.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        RandomImagechat.translatesAutoresizingMaskIntoConstraints = false
        RandomImagechat.contentMode = .scaleToFill
        RandomImagechat.topAnchor.constraint(equalTo: self.topAnchor , constant: 10).isActive = true
        RandomImagechat.heightAnchor.constraint(equalToConstant: 100).isActive = true
       // RandomImagechat.alignmentRectInsets.right
        RandomImagechat.widthAnchor.constraint(equalToConstant: 100).isActive = true
        RandomImagechat.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -20).isActive = true
        RandomImagechat.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        RandomImagechat.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        RandomImagechat.layer.cornerRadius = 5
        RandomImagechat.image = UIImage(named: "Woman1_1")
        RandomImagechat.clipsToBounds =  true
        
        ImagelabelChat = UILabel(frame: frame)
        self.addSubview(ImagelabelChat)
        ImagelabelChat.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ImagelabelChat.text = "ImageViewChat"
        ImagelabelChat.translatesAutoresizingMaskIntoConstraints = false
        ImagelabelChat.topAnchor.constraint(equalTo: RandomImagechat.bottomAnchor, constant:0).isActive = true
        ImagelabelChat.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 8).isActive = true
        ImagelabelChat.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ImagelabelChat.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ImagelabelChat.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        ImagelabelChat.numberOfLines = 0
        ImagelabelChat.lineBreakMode = .byWordWrapping
        

        
}
}



