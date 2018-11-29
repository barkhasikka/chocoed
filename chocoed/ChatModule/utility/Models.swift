//
//  Models.swift
//  chocoed
//
//  Created by Mahesh Bhople on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

struct FriendListChat {
    
    var user_name : String
    var user_contact_no : String
    var user_email: String
    var user_photo : String
    var user_id : String
 
    
    init(_ dictionary : NSDictionary) {
        self.user_name = dictionary["user_name"] as? String ?? ""
        self.user_contact_no = dictionary["user_contact_no"] as? String ?? ""
        self.user_email = dictionary["user_email"] as? String ?? ""
        self.user_photo = dictionary["user_photo"] as? String ?? ""
        self.user_id = dictionary["user_id"] as? String ?? ""

    }
    
}

struct PhotoCellMsg  {
    
    var msgId : String = ""
    var msgType : String = ""
    var friend_no : String
    var desc : String
    var userId : String
    var notification_id : String

    
    init(_ dictionary : NSDictionary) {
        self.msgId = dictionary["msg_id"] as? String ?? ""
        self.msgType = dictionary["type"] as? String ?? ""
        self.friend_no = dictionary["user_id"] as? String ?? ""
        self.userId = dictionary["friend_id"] as? String ?? ""
        self.desc = dictionary["body"] as? String ?? ""
        self.notification_id = dictionary["notification_id"] as? String ?? ""


    }
}

struct CustomMessageModel : Codable {
    
    var msgId : String = ""
    var msgType : String = ""
    var message : String = ""
    var fileUrl : String = ""
    var destructiveTime : String = ""
    var fileType : String = ""
    var filePermission : String = ""

   /* init(msgID : String,msgType : String , message : String , fileURL : String ,time : String) {
        
        self.msgId = msgID
        self.msgType = msgType
        self.message =  message
        self.fileUrl = fileURL
        self.desctructiveTime = time
        
      }
 */
    
}

struct Friend {
    
     var   created : String
     var   contact_number: String
     var   fcm_id : String
     var   is_mine : String
     var   is_typing : String
     var   last_msg : String
     var   last_msg_type : String
     var   last_msg_time : String
     var   modified : String
     var   name : String
     var   profile_image : String
     var   read_count : String
     var   status : String
     var   user_id : String
     var   last_msg_ack : String

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
    var is_permission : String
    var replyTitle : String
    var replyMsgType : String
    var replyMsgId : String
    var replyMsgFile : String
    var replyMsg : String
    var sentTime : String
    var seenTime : String
    var destructiveTime : String

    
}

