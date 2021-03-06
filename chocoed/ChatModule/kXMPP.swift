//
//  kXMPP.swift
//  OneChat
//
//  Created by Paul on 19/02/2015.
//  Copyright (c) 2015 ProcessOne. All rights reserved.
//

import Foundation

public struct kXMPP {
    

	public static let myJID: String = "myJID"
	public static let myPassword: String = "myPass"
    public static let DESTRUCT_TIME : String = "2"
    public static let msgSend: String = "0"
    public static let msgSent: String = "1"
    public static let msgSeen: String = "2"
    public static let msgFail: String = "3"
    public static let TYPE_TEXT: String = "text"
    public static let TYPE_TAGU: String = "tag_u"
    public static let TYPE_IMAGE: String = "image"
    public static let TYPE_PDF: String = "pdf"
    public static let TYPE_REPLY: String = "reply"
    public static let TYPE_PER_ASK: String = "per_ask"
    public static let TYPE_PER_GRANT: String = "per_grant"
    public static let SEEN_MSG : String = "..."
    public static var IS_RECORDING = false
    public static let SELF_DESTRUCT_MSG : String = "This message was self-destructed"
    public static let DELETE_TEXT_FRIEND : String = "This message has been deleted"
    public static let DELETE_TEXT_MY : String = "You deleted this message"
    public static let TYPE_DELETE: String = "delete"
    public static let TYPE_SEEN: String = "seen_msg"
    public static let registerUSER : String  = "http://13.232.161.176/index.php/Api_openfire/register"
    public static let uploadImage : String  = "http://13.232.161.176/index.php/Api_openfire/upload_image"
    public static let sendNotification : String  = "http://13.232.161.176/index.php/Api_openfire/send_notification"
     public static let addFriend : String  = "http://13.232.161.176/index.php/Api_openfire/add_friend"
     public static let sendFileNotification : String  = "http://13.232.161.176/index.php/Api_openfire/send_file_notification"
     public static let getFileNotification : String  = "http://13.232.161.176/index.php/Api_openfire/get_image_notification"
    public static let deleteFriend : String  = "http://13.232.161.176/index.php/Api_openfire/delete_friend"
     public static let deleteNotification : String  = "http://13.232.161.176/index.php/Api_openfire/delete_file_notification"
    public static let notificationCount : String  = "http://13.232.161.176/index.php/Api_openfire/notification_count"

    
}
