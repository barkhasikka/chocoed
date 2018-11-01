//
//  Models.swift
//  chocoed
//
//  Created by Mahesh Bhople on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

struct FriendList {
    
    var name : String
    var image: String
    var last_msg_time : String
    var last_msg_type : String
    var last_msg : String
    var count : String
    
    
    
    init(_ dictionary : NSDictionary) {
        self.name = dictionary["name"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.last_msg_time = dictionary["last_msg_time"] as? String ?? ""
        self.last_msg_type = dictionary["last_msg_type"] as? String ?? ""
        self.last_msg = dictionary["last_msg"] as? String ?? ""
        self.count = dictionary["count"] as? String ?? ""

        
    }
    
}

struct CustomMessageModel : Codable {
    
    var msgId : String = ""
    var msgType : String = ""
    var message : String = ""
    var fileUrl : String = ""
    var desctructiveTime : String = ""
    
   /* init(msgID : String,msgType : String , message : String , fileURL : String ,time : String) {
        
        self.msgId = msgID
        self.msgType = msgType
        self.message =  message
        self.fileUrl = fileURL
        self.desctructiveTime = time
        
      }
 */
    
}


struct Message {
    
    var msg : String
    var msgId: String
    var msgType : String
    var msgACk : String
    var fromID : String
    var toID : String  
    var fileUrl : String
    var isUpload : String
    var isDownload : String
    var isStreaming : String
    var isMine : String
    var created : String
    var status : String
    var modified : String
    
}

