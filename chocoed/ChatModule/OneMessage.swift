//
//  OneMessage.swift
//  OneChat
//
//  Created by Paul on 27/02/2015.
//  Copyright (c) 2015 ProcessOne. All rights reserved.
//

import Foundation
import XMPPFramework
import SDWebImage

public typealias OneChatMessageCompletionHandler = (_ stream: XMPPStream, _ message: XMPPMessage) -> Void

// MARK: Protocols

public protocol OneMessageDelegate : NSObjectProtocol {
    
    //    func oneStream(_ sender: XMPPStream, didReceiveMessage message: XMPPMessage, from user: XMPPUserCoreDataStorageObject)
    func oneStream(_ sender: XMPPStream, userIsComposing user: XMPPUserCoreDataStorageObject)
    
    //  func oneStream(_ sender: XMPPStream, didReceiptReceive message: XMPPMessage, from user: XMPPUserCoreDataStorageObject)
    
}

open class OneMessage: NSObject {
    open weak var delegate: OneMessageDelegate?
    
    open var xmppMessageStorage: XMPPMessageArchivingCoreDataStorage?
    var xmppMessageArchiving: XMPPMessageArchiving?
    var didSendMessageCompletionBlock: OneChatMessageCompletionHandler?
    
    // MARK: Singleton
    
    open class var sharedInstance : OneMessage {
        struct OneMessageSingleton {
            static let instance = OneMessage()
        }
        
        return OneMessageSingleton.instance
    }
    
    // MARK: private methods
    
    func setupArchiving() {
        xmppMessageStorage = XMPPMessageArchivingCoreDataStorage.sharedInstance()
        xmppMessageArchiving = XMPPMessageArchiving(messageArchivingStorage: xmppMessageStorage)
        
        xmppMessageArchiving?.clientSideMessageArchivingOnly = true
        xmppMessageArchiving?.activate(OneChat.sharedInstance.xmppStream!)
        xmppMessageArchiving?.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    // MARK: public methods
    
    open class func sendMessage(_ message: String, msgId :String, thread:String, to receiver: String, completionHandler completion:@escaping OneChatMessageCompletionHandler) {
        let body = DDXMLElement.element(withName: "body") as! DDXMLElement
        // let messageID = Int64(NSDate().timeIntervalSince1970 * 1000)
        
        body.stringValue = message
        
        let threadElement = DDXMLElement.element(withName: "thread") as! DDXMLElement
        threadElement.stringValue = thread
        
        let completeMessage = DDXMLElement.element(withName: "message") as! DDXMLElement
        
        completeMessage.addAttribute(withName: "id", stringValue: msgId)
        completeMessage.addAttribute(withName: "type", stringValue: "chat")
        completeMessage.addAttribute(withName: "to", stringValue: receiver)
        completeMessage.addChild(body)
        completeMessage.addChild(threadElement)
        
        print(msgId,"<<<<< MSG ID >>>>>")
        
        sharedInstance.didSendMessageCompletionBlock = completion
        OneChat.sharedInstance.xmppStream?.send(completeMessage)
    }
    
    open class func sendIsComposingMessage(_ recipient: String, thread: String,completionHandler completion:@escaping OneChatMessageCompletionHandler) {
        if recipient.count > 0 {
            let message = DDXMLElement.element(withName: "message") as! DDXMLElement
            message.addAttribute(withName: "type", stringValue: "chat")
            message.addAttribute(withName: "to", stringValue: recipient)
            
            let composing = DDXMLElement.element(withName: "composing", stringValue: "http://jabber.org/protocol/chatstates") as! DDXMLElement
            composing.namespaces = [DDXMLElement.namespace(withName: "" , stringValue: "http://jabber.org/protocol/chatstates") as! DDXMLNode];
            message.addChild(composing)
            
            let threadElement = DDXMLElement.element(withName: "thread") as! DDXMLElement
            threadElement.stringValue = thread
            message.addChild(threadElement)
            
            print(message)
            
            sharedInstance.didSendMessageCompletionBlock = completion
            OneChat.sharedInstance.xmppStream?.send(message)
        }
    }
    
    open func loadArchivedMessagesFrom(jid: String, thread: String) -> NSMutableArray {
        let moc = xmppMessageStorage?.mainThreadManagedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "XMPPMessageArchiving_Message_CoreDataObject", in: moc!)
        let request = NSFetchRequest<NSFetchRequestResult>()
        let predicateFormat = "bareJidStr like %@ ANd thread like %@"
        let predicate = NSPredicate(format: predicateFormat, jid, thread)
        let retrievedMessages = NSMutableArray()
        var sortedRetrievedMessages = Array<Any>()
        
        request.predicate = predicate
        request.entity = entityDescription
        
        do {
            let results = try moc?.fetch(request)
            
            for message in results! {
                var element: DDXMLElement!
                do {
                    element = try DDXMLElement(xmlString: (message as AnyObject).messageStr)
                } catch _ {
                    element = nil
                }
                
                let body: String
                let sender: String
                let date: Date
                
                date = (message as AnyObject).timestamp
                
                //if (message as AnyObject).body != nil {
                //    body = (message as AnyObject).body
                //} else {
                body = ""
                //}
                
                if element.attributeStringValue(forName: "to") == jid {
                    let displayName = OneChat.sharedInstance.xmppStream?.myJID
                    sender = displayName!.bare
                } else {
                    sender = jid
                }
                
                let fullMessage = "" //JSQMessage(senderId: sender, senderDisplayName: sender, date: date, text: body)!
                
                retrievedMessages.add(fullMessage)
                
                
                let descriptor:NSSortDescriptor = NSSortDescriptor(key: "date", ascending: true);
                
                sortedRetrievedMessages = retrievedMessages.sortedArray(using: [descriptor]);
                
            }
        } catch _ {
            //catch fetch error here
        }
        return NSMutableArray(array: sortedRetrievedMessages)
    }
    
    open func deleteMessagesFrom(jid: String, messages: NSArray) {
        messages.enumerateObjects({ (message, idx, stop) -> Void in
            let moc = self.xmppMessageStorage?.mainThreadManagedObjectContext
            let entityDescription = NSEntityDescription.entity(forEntityName: "XMPPMessageArchiving_Message_CoreDataObject", in: moc!)
            let request = NSFetchRequest<NSFetchRequestResult>()
            let predicateFormat = "messageStr like %@ "
            let predicate = NSPredicate(format: predicateFormat, message as! String)
            
            request.predicate = predicate
            request.entity = entityDescription
            
            do {
                let results = try moc?.fetch(request)
                
                for messageAny in results! {
                    
                    let message = messageAny as AnyObject
                    
                    var element: DDXMLElement!
                    do {
                        element = try DDXMLElement(xmlString: message.messageStr)
                    } catch _ {
                        element = nil
                    }
                    
                    if element.attributeStringValue(forName: "messageStr") == message as? String {
                        moc?.delete(message as! NSManagedObject)
                    }
                }
            } catch _ {
                //catch fetch error here
            }
        })
    }
}

extension OneMessage: XMPPStreamDelegate {
    
    
    func sendSeenMsgAck(friendID:String){
        
        do{
            
            let body = CustomMessageModel(msgId: "", msgType: kXMPP.TYPE_SEEN, message: "", fileUrl: "", destructiveTime: "",fileType : "",filePermission:"",tagUId:"")
            
            let jsonData = try JSONEncoder().encode(body)
            let msg = String(data: jsonData, encoding: .utf8)
            
            OneMessage.sendMessage(msg!, msgId:self.getCurrentTime(),  thread: "test", to:"\(friendID)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
            })
            
            
        }catch {print(error)}
        
    }
    
    
    private func updateMsgAck(friendID : String){
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "to_id = %@ AND msg_ack = %@", friendID,"1")
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                for item in results {
                    
                    item.setValue("2", forKey: "msg_ack")
                    item.setValue(self.getCurrentTime(), forKey: "seen_time")
                    
                    
                    do{
                        
                        try context.save()
                        
                        
                        
                        
                        
                    }catch{
                        print("Error in update")
                    }
                    
                }
                
            }
            
        }catch{
            print("error executing request")
        }
        
    }
    
    
    private func updateMsg(msg_id : String , type : String , value : String){
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "msg_id = %@", msg_id)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
                
                
                if type == "streaming"{
                    updatObj.setValue(value, forKey: "is_streaming")
                }
                
                if type == "upload"{
                    updatObj.setValue(value, forKey: "is_download")
                    updatObj.setValue("0", forKey: "msg_ack")
                }
                
                if type == "download"{
                    updatObj.setValue(value, forKey: "is_download")
                    updatObj.setValue("0", forKey: "is_permission")
                    
                }
                
                if type == "file"{
                    updatObj.setValue(value, forKey: "file_url")
                }
                if type == "delete_type"{
                    updatObj.setValue(value, forKey: "msg")
                    updatObj.setValue(kXMPP.TYPE_TEXT, forKey: "msg_type")
                }
                
                if type == "msg_ack"{
                    
                    updatObj.setValue(value, forKey: "msg_ack")
                    updatObj.setValue(self.getCurrentTime(), forKey: "sent_time")
                    
                }
                
                do{
                    
                    try context.save()
                    
                    
                }catch{
                    print("Error in update")
                }
            }
            
        }catch{
            print("error executing request")
        }
        
    }
    
    private func getFriend(id : String) -> String {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", id)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                let f = results[0] as! Friends
                return f.name
            }
        }catch{
            print("error executing request")
        }
        
        return ""
    }
    
    
    
    
    private func isFriendPrsent(item : String) -> Bool {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", item)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
        }catch{
            print("error executing request")
        }
        
        return results.count > 0
    }
    
    private func createFriend(number: String) {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if isFriendPrsent(item: number) == false {
            
            if let msgObject = NSEntityDescription.insertNewObject(forEntityName: "Friends", into: context) as? Friends {
                
                msgObject.contact_number = number
                msgObject.created = ""
                msgObject.fcm_id = ""
                msgObject.is_mine = ""
                msgObject.is_typing = "no"
                msgObject.last_msg = ""
                msgObject.last_msg_type = ""
                msgObject.last_msg_time = ""
                msgObject.modified = ""
                msgObject.name = number
                msgObject.profile_image = ""
                msgObject.read_count = "0"
                msgObject.status = ""
                msgObject.user_id = ""
            }
            do {
                try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
            } catch let error {
                print(error)
            }
            
            
        }
        
    }
    
    
    
    
    private func isMSgPrsent(item : Message) -> Bool {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "msg_id = %@", item.msgId)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            
            
        }catch{
            print("error executing request")
        }
        
        return results.count > 0
    }
    
    private func createMsgEntityFrom(item: Message) {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if isMSgPrsent(item: item) == false {
            
            let msgObject = NSEntityDescription.insertNewObject(forEntityName: "Msg", into: context) as? Msg //{
            
            print(item.msgId)
            
            msgObject?.msg = item.msg
            msgObject?.created = item.created
            msgObject?.file_url = item.fileUrl
            msgObject?.from_id = item.fromID
            msgObject?.is_download = item.isDownload
            msgObject?.is_mine = item.isMine
            msgObject?.is_streaming = item.isStreaming
            msgObject?.is_upload = item.isUpload
            msgObject?.modified = item.modified
            msgObject?.msg = item.msg
            msgObject?.msg_ack = item.msgACk
            msgObject?.msg_id = item.msgId
            msgObject?.msg_type = item.msgType
            msgObject?.status = item.status
            msgObject?.to_id = item.toID
            msgObject?.is_permission = item.is_permission
            msgObject?.replyTitle = item.replyTitle
            msgObject?.replyMsgType =  item.replyMsgType
            msgObject?.replyMsgId = item.replyMsgId
            msgObject?.replyMsgFile = item.replyMsgFile
            msgObject?.replyMsg =  item.replyMsg
            
            msgObject?.sent_time =  item.sentTime
            msgObject?.seen_time =  item.seenTime
            msgObject?.distructive_time = item.destructiveTime
            msgObject?.tagid = item.tagid

            
            
            
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            //  }
        }else{
            print("present")
        }
        
        
    }
    
    
    private func getCurrentTime() -> String {
        
        let messageID = Int64(NSDate().timeIntervalSince1970 * 1000)
        return String(messageID)
        
    }
    
    
    private func updateFriendCell(last_msg_time : String , msg : String , msg_type :String , isMine : String, friendID : String){
        
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", friendID)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
                
                var count = Int(updatObj.value(forKey: "read_count") as? String ?? "0")
                count = count! + 1
                
                print(count!,"<<<< COUNT >>>>>>")
                
                updatObj.setValue(msg, forKey: "last_msg")
                updatObj.setValue(msg_type, forKey:"last_msg_type")
                updatObj.setValue("0", forKey: "last_msg_ack")
                updatObj.setValue(last_msg_time, forKey:"last_msg_time")
                updatObj.setValue(isMine, forKey:"is_mine")
                updatObj.setValue(String(count!), forKey: "read_count")
                
                
                do{
                    try context.save()
                    
                }catch{
                    print("Error in update")
                }
            }
            
        }catch{
            print("error executing request")
        }
        
    }
    
    private func isMsg(msgId : String) -> Bool {
        
        
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "msg_id = %@", msgId)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                return true
                
            }
            
        }catch{
            print("error executing request")
        }
        
        return false
    }
    
    private func getMsg(msgId : String) -> Msg {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "msg_id = %@", msgId)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                return results[0] as! Msg
                
            }
        }catch{
            
        }
        
        return results[0] as! Msg
    }
    
    
    
    
    private func updateFriendTyping(friendID : String, typing: String){
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", friendID)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
                
                updatObj.setValue(typing, forKey: "is_typing")
                
                do{
                    try context.save()
                    
                }catch{
                    print("Error in update")
                }
            }
            
        }catch{
            print("error executing request")
        }
    }
    
    
    private func updateFriendLastMsg(friendID : String ,value : String){
        
        // update friend profile
        
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", friendID)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
                
                updatObj.setValue(value, forKey: "last_msg_ack")
                
                
                do{
                    try context.save()
                    
                }catch{
                    print("Error in update")
                }
            }
            
        }catch{
            print("error executing request")
        }
        
    }
    
    func loadPDFAsync(url : String,msgid: String){
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: URL(string: url)!)
        
        
        let task = session.downloadTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            // Success
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("Success: \(statusCode)")
            }
            
            do {
                
                let fileName = "\(Int64(NSDate().timeIntervalSince1970 * 1000)).pdf"
                let documentFolderURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let fileURL = documentFolderURL.appendingPathComponent(fileName)
                
                try FileManager.default.moveItem(at: data!, to: fileURL)
                
                DispatchQueue.main.async {
                    
                    
                    self.updateMsg(msg_id: msgid, type : "download" ,value: "1")
                    self.updateMsg(msg_id: msgid, type : "file" ,value:fileURL.absoluteString)
                    
                }
                
            } catch  {
                print("error writing file  : \(error)")
            }
        }
        task.resume()
        
    }
    
    
    private func savefiletoDirector(image : UIImage) -> String
    {
        
        // get the documents directory url
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = "\(Int64(NSDate().timeIntervalSince1970 * 1000)).jpg"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = UIImageJPEGRepresentation(image, 1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
                
            } catch {
                print("error saving file:", error)
            }
        }
        
        return fileURL.absoluteString
        
    }
    
    
    
    public func xmppStream(_ sender: XMPPStream, didSend message: XMPPMessage) {
        if let completion = OneMessage.sharedInstance.didSendMessageCompletionBlock {
            completion(sender, message)
        }
        //OneMessage.sharedInstance.didSendMessageCompletionBlock!(sender, message)
    }
    
    public func xmppStream(_ sender: XMPPStream, didReceive message: XMPPMessage) {
        
        
        let user = OneChat.sharedInstance.xmppRosterStorage.user(for: message.from, xmppStream: OneChat.sharedInstance.xmppStream, managedObjectContext: OneRoster.sharedInstance.managedObjectContext_roster())
        
        if user != nil {
            
            // if OneChats.knownUserForJid(jidStr: (user?.jidStr)!) {
            //     OneChats.addUserToChatList(jidStr: (user?.jidStr)!)
            // }
            
            
            if message.isChatMessageWithBody {
                
                //    OneMessage.sharedInstance.delegate?.oneStream(sender, didReceiveMessage: message, from: user!)
                
                let userData = (user!.jidStr)!.components(separatedBy: "@")
                let friendID = userData[0]
                
                
                do{
                    
                    self.createFriend(number: friendID)
                    
                    let data = message.body?.data(using: .utf8)!
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    
                    print(json)
                    
                    
                    
                    if json.value(forKey: "msgType") as! String == kXMPP.TYPE_DELETE {
                        
                        // update msg by msgID
                        
                        self.updateMsg(msg_id: json.value(forKey: "msgId") as! String, type: "delete_type", value: kXMPP.DELETE_TEXT_FRIEND)
                        
                        
                        /* let friendNo = UserDefaults.standard.string(forKey: "chatNo")
                         if friendNo == friendID {
                         let mainvc = ChatVC()
                         mainvc.reloadData()
                         } */
                        
                        
                        
                    }else if json.value(forKey: "msgType") as! String == kXMPP.TYPE_PER_GRANT {
                        
                        // download file working
                        
                        let msgID = json.value(forKey: "msgId") as? String ?? ""
                        
                        
                        if self.isMsg(msgId: msgID){
                            
                            let msgData = self.getMsg(msgId: json.value(forKey: "msgId") as! String)
                            
                            if msgData.distructive_time != kXMPP.DESTRUCT_TIME {
                            
                            if msgData.msg_type == kXMPP.TYPE_IMAGE {
                                
                                SDWebImageManager.shared().imageDownloader?.downloadImage(with:  URL(string: msgData.file_url), options: .continueInBackground, progress: nil, completed: {(image : UIImage?,data:Data?,error:Error?,finished:Bool)
                                    in
                                    
                                    if image != nil {
                                        
                                        let localURL  = self.savefiletoDirector(image: image!)
                                        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
                                        
                                        self.updateMsg(msg_id: msgData.msg_id, type : "download" ,value: "1")
                                        self.updateMsg(msg_id: msgData.msg_id, type : "file" ,value: localURL)
                                        
                                    }
                                    
                                })
                                
                            }else if msgData.msg_type == kXMPP.TYPE_PDF {
                                
                                self.loadPDFAsync(url: msgData.file_url, msgid: msgData.msg_id)
                                
                            }
                                
                            }else{
                                 self.updateMsg(msg_id: msgData.msg_id, type : "download" ,value: "1")
                            }
                            
                            //  }
                            
                        }
                        
                        
                        
                    }else if json.value(forKey: "msgType") as! String == kXMPP.TYPE_SEEN {
                        
                        // update msg by msgID
                        
                        self.updateMsgAck(friendID: friendID)
                        
                    }else{
                        
                        var replyMsgType = ""
                        var replyMsgFile = ""
                        var replyMsg = ""
                        var replyTitle = ""
                        var replyMsgId = ""
                        var tagid = ""

                        
                        let msgType = json.value(forKey: "msgType") as! String
                        
                        if msgType == kXMPP.TYPE_REPLY {
                            
                            replyMsgId = json.value(forKey: "msgId") as! String
                            
                            
                            let msgItem = self.getMsg(msgId: replyMsgId)
                            
                            replyMsg = msgItem.msg
                            replyMsgFile = msgItem.file_url
                            
                            if msgItem.is_mine == "1" {
                                replyTitle = "You"
                            }else{
                                replyTitle = self.getFriend(id: friendID)
                            }
                            
                            replyMsgType = msgItem.msg_type
                            
                        }
                        
                        if msgType == kXMPP.TYPE_TAGU {
                            
                            tagid = json.value(forKey: "tagUId") as! String
                        }

                        
                        let filePermission = json.value(forKey: "filePermission") as? String ?? "0"
                        
                        
                        self.createMsgEntityFrom(item: Message(
                            msg: json.value(forKey: "message") as! String,
                            msgId: message.attributeStringValue(forName: "id") ?? "",
                            msgType: msgType,
                            msgACk: "0",
                            fromID: USERDETAILS.mobile,
                            toID: friendID,
                            fileUrl: json.value(forKey: "fileUrl") as! String,
                            isUpload: "0",
                            isDownload: "0",
                            isStreaming: "0",
                            isMine: "0",
                            created: self.getCurrentTime(),
                            status: "",
                            modified: self.getCurrentTime(),
                            is_permission: filePermission,replyTitle: replyTitle, replyMsgType: replyMsgType, replyMsgId: replyMsgId, replyMsgFile: replyMsgFile, replyMsg: replyMsg, sentTime: kXMPP.SEEN_MSG, seenTime: kXMPP.SEEN_MSG, destructiveTime: json.value(forKey: "destructiveTime") as! String, tagid: tagid))
                        
                        
                        self.updateFriendCell(last_msg_time: self.getCurrentTime(), msg: json.value(forKey: "message") as! String, msg_type: json.value(forKey: "msgType") as! String, isMine: "0" , friendID: friendID)
                        
                        
                        let friendNo = UserDefaults.standard.string(forKey: "chatNo")
                        if friendNo == nil || friendNo != friendID {
                        
                        }else{
                            self.sendSeenMsgAck(friendID: friendID)
                        }
                        
                       
                        
                        
                        
                    }
                    
                }catch{
                    
                }
                
                
                
                
            } else {
                
                if let _ = message.forName("received"){
                    
                    self.updateMsg(msg_id: message.forName("received")?.attributeStringValue(forName: "id") ?? "", type: "msg_ack", value: kXMPP.msgSent)
                    
                    
                    let userData = (user!.jidStr)!.components(separatedBy: "@")
                    self.updateFriendLastMsg(friendID: userData[0], value: kXMPP.msgSent)
                    
                    
                    /*  let friendNo = UserDefaults.standard.string(forKey: "chatNo")
                     if friendNo == userData[0] {
                     let mainvc = ChatVC()
                     mainvc.reloadData()
                     } */
                    
                    
                    
                    
                    
                    //  OneMessage.sharedInstance.delegate?.oneStream(sender, didReceiptReceive: message, from: user!)
                }
                
                //was composing
                if let _ = message.forName("composing") {
                    print("<<<<< MESSAGE TYPING>>>>>>")
                    
                    
                    let userData = (user?.jidStr)!.components(separatedBy: "@")
                    let friendID = userData[0]
                    //self.updateFriendLastMsg(friendID: userData[0], value: kXMPP.msgSeen)
                    
                    /* let friendNo = UserDefaults.standard.string(forKey: "chatNo")
                     if friendNo == userData[0] {
                     let mainvc = ChatVC()
                     mainvc.reloadData()
                     } */
                    
                    self.updateFriendTyping(friendID: friendID,typing : "yes")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.updateFriendTyping(friendID: friendID,typing : "no")
                    })
                    
                    
                    OneMessage.sharedInstance.delegate?.oneStream(sender, userIsComposing: user!)
                }
            }
        }
    }
}
