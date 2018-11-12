//
//  MsgCell.swift
//  chocoed
//
//  Created by Mahesh Bhople on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class MsgCell: UITableViewCell {
    
    
    let mTextView: UITextView = {
        let tView = UITextView()
        tView.font = UIFont.systemFont(ofSize: 18)
        tView.text = "Sample Message"
        tView.backgroundColor = UIColor.clear
        tView.isUserInteractionEnabled = false
        return tView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    static let grayBubbleImage = UIImage(named: "Profile_patch")?.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    static let blueBubbleImage = UIImage(named: "Profile_patch")?.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    
    let bubbleImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.image = MsgCell.grayBubbleImage
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        return imageView
    }()
    
   
    
   // let objChat = CommonChatLabel()
   // let objChatMy = CommonChatLabel()

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //isUserInteractionEnabled = false
        
       // addSubview(objChat)
       // addSubview(objChatMy)
        
        //constraintsToImageChatView()
       // constraintsToTextChatView()
       // constraintsToTextChatViewMy()
        
        addSubview(textBubbleView)
        addSubview(mTextView)
        addSubview(profileImageView)
        
        //addConstraint("H:|-8-[v0(30)]")
        //addConstraint("V:[v0(30)]|")
        
        textBubbleView.addSubview(bubbleImageview)
       // textBubbleView.addConstraintsWithView(format:"H:|[v0]|", view: bubbleImageview)
        //textBubbleView.addConstraintsWithView(format:"V:|[v0]|", view: bubbleImageview)
        
        profileImageView.backgroundColor = UIColor.red
        
      
        
    }
    
   /* func constraintsToTextChatViewMy(){
        
        self.objChatMy.translatesAutoresizingMaskIntoConstraints = false
        self.objChatMy.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        self.objChatMy.topAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
        
        //self.objChat.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        
        self.objChatMy.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200).isActive = true
        self.objChatMy.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -8).isActive = true
        
        
     
        self.objChatMy.layer.cornerRadius = 5
        self.objChatMy.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.objChatMy.clipsToBounds = true
        
    }
    
    func constraintsToTextChatView(){
        
        self.objChat.translatesAutoresizingMaskIntoConstraints = false
        self.objChat.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        self.objChat.topAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true

        self.objChat.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        //  self.objChat.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        //self.objChat.heightAnchor.constraint(equalToConstant: 70).isActive = true
        //self.objChat.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.objChat.layer.cornerRadius = 5
        self.objChat.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.objChat.clipsToBounds = true
        
    }
 
   */
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
   /*  func setMsgCellWith(item: Msg) {
        
        DispatchQueue.main.async {
            
            if item.is_mine == "1"{
                
                self.objChatMy.isHidden = false
                self.objChat.isHidden = true
                
                if item.msg_type == kXMPP.TYPE_TEXT {
                    
                    self.objChat.labelChat.text = item.msg
                   // self.objChat.labelTime.text = Utils.getTimeFromString(date: item.created!)
                    
                }else if item.msg_type == kXMPP.TYPE_IMAGE {
                    
                    
                    
                }
                
                
                
                
            }else{
                
                self.objChatMy.isHidden = true
                self.objChat.isHidden = false
                
                if item.msg_type == kXMPP.TYPE_TEXT {
                    
                    self.objChatMy.labelChat.text = item.msg
                  //  self.objChatMy.labelTime.text = Utils.getTimeFromString(date: item.created!)

                    
                }else if item.msg_type == kXMPP.TYPE_IMAGE {
                    
                    
                }
            }
            
            
          
          
        }
    }
   */
    
}

