//
//  PhotoNotificationVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 11/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class PhotoNotificationVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UIDocumentInteractionControllerDelegate{
    

    @IBOutlet var tblView: UITableView!
    var arrayPhotos = [PhotoCellMsg]()
    
    
    @IBAction func back_btn_clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // user_id...contact no own
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getNotification()
    }
    
    func getNotification(){
        
        if self.arrayPhotos.count > 0 {
            self.arrayPhotos.removeAll()
        }
        
      
            let params = ["user_id": "\(USERDETAILS.mobile)"]
            print(params)
            MakeHttpPostRequestChat(url: kXMPP.getFileNotification, params: params, completion: {(success, response) in
                print(response)
                
                let list = response.object(forKey: "data") as? NSArray ?? []
                for (index, friend) in list.enumerated() {
                    self.arrayPhotos.append(PhotoCellMsg(friend as! NSDictionary))
                }
                
                print(self.arrayPhotos)
                DispatchQueue.main.async {

                self.tblView.reloadData()
            
                }
                
            }, errorHandler: {(message) -> Void in
                print("message", message)
            })
      
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let item =  self.arrayPhotos[indexPath.row]
        
        
       
        cell.lblDesc.text = item.desc
        let friend = self.getFriend(id: item.friend_no)
        cell.lblName.text = friend.name
        cell.profileImage.sd_setImage(with: URL(string: friend.profile_image))
        cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
        cell.profileImage?.clipsToBounds = true
        cell.profileImage?.contentMode = .scaleToFill

     
        
        if item.msgType == "0" {
            
            if self.isMsg(msgId: item.msgId){
                
                let msgData = self.getMsg(msgId: item.msgId)

                if msgData.msg_type == kXMPP.TYPE_IMAGE{
                     cell.fileView.sd_setImage(with: URL(string: self.getMsg(msgId: item.msgId).file_url))
                   
                }else{
                    
                     cell.fileView.image = UIImage(named: "pdf_place")
                }
                
                
            }
            
            
       
        }else {
            
            if self.isMsg(msgId: item.msgId){
                
                let msgData = self.getMsg(msgId: item.msgId)
                
                if msgData.msg_type == kXMPP.TYPE_IMAGE{
                    cell.fileView.sd_setImage(with: URL(string: self.getMsg(msgId: item.msgId).file_url))
                    
                    let blureffect = UIBlurEffect(style: UIBlurEffectStyle
                        .regular)
                    let blueeffectView = UIVisualEffectView(effect: blureffect)
                    blueeffectView.frame = (cell.fileView?.bounds)!
                    blueeffectView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
                    cell.fileView?.addSubview(blueeffectView)
                    
                }else{
                    
                    cell.fileView.image = UIImage(named: "pdf_place")
                }
                
        
            }
            
      
            
         

        }
        
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item =  self.arrayPhotos[indexPath.row]
        if item.msgType == "0"{
            self.permissionPopup(cell: item)
            tableView.deselectRow(at: indexPath, animated: false)

        }else{
            
            
        if self.isMsg(msgId: item.msgId){
                
            let msgData = self.getMsg(msgId: item.msgId)
            
           if msgData.is_download == "0" {

            if msgData.msg_type == kXMPP.TYPE_IMAGE {
                
                SDWebImageManager.shared().imageDownloader?.downloadImage(with:  URL(string: msgData.file_url), options: .continueInBackground, progress: nil, completed: {(image : UIImage?,data:Data?,error:Error?,finished:Bool)
                    in
                    
                    if image != nil {
                        
                        let localURL  = self.savefiletoDirector(image: image!)
                        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
                        self.deleteNotification(id: item.notification_id)

                        
                        self.updateMsg(msg_id: msgData.msg_id, type : "download" ,value: "1")
                        self.updateMsg(msg_id: msgData.msg_id, type : "file" ,value: localURL)
                        
                        
                        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "FileViewerVC") as? FileViewerVC {
                            vcNewSectionStarted.fileURL = localURL
                            vcNewSectionStarted.type = kXMPP.TYPE_IMAGE
                            self.present(vcNewSectionStarted, animated: true, completion: nil)
                        }
                    }
                    
                })
                
            }else if msgData.msg_type == kXMPP.TYPE_PDF {
                
                self.loadPDFAsync(url: msgData.file_url, msgid: msgData.msg_id)
                self.deleteNotification(id: item.notification_id)

            }
                
            }else{
                
               self.deleteNotification(id: item.notification_id)

                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "FileViewerVC") as? FileViewerVC {
                    vcNewSectionStarted.fileURL = msgData.file_url
                    vcNewSectionStarted.type = msgData.msg_type
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                }
                
                tableView.deselectRow(at: indexPath, animated: false)
                
            }
            
            
            }else{
                
                self.deleteNotification(id: item.notification_id)

            }
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
                }
                
                if type == "msg_ack"{
                    
                    updatObj.setValue(value, forKey: "msg_ack")
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
    
    private func getFriend(id : String) -> Friends {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", id)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                return results[0] as! Friends
            }
        }catch{
            print("error executing request")
        }
        
        return results[0] as! Friends

    }
    
    
    private func permissionPopup(cell : PhotoCellMsg){
        
        let alertView = UIAlertController(title: "Permission", message: "Grant permission  to download file", preferredStyle: .alert)
        let action = UIAlertAction(title: "Not Now", style: .default, handler: { (alert) in
        })
        alertView.addAction(action)
        
        let actionSure = UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
           
            if self.isMsg(msgId: cell.msgId){
            let msgData = self.getMsg(msgId: cell.msgId)
            self.sendNotify(item: msgData,friend: cell.friend_no)
            }
            
            self.deleteNotification(id: cell.notification_id)
            
        })
        alertView.addAction(actionSure)
        self.present(alertView, animated: true, completion: nil)
        
    }
    
    private func getCurrentTime() -> String {
        
        let messageID = Int64(NSDate().timeIntervalSince1970 * 1000)
        return String(messageID)
        
    }
    
    
    func sendNotify(item: Msg,friend:String){
        
        do{
            
           // let msgId = self.getCurrentTime()
            
            let body = CustomMessageModel(msgId: item.msg_id, msgType: kXMPP.TYPE_PER_GRANT, message: "", fileUrl: "", destructiveTime: "",fileType:"",filePermission:"0")
            
            let jsonData = try JSONEncoder().encode(body)
            let msg = String(data: jsonData, encoding: .utf8)
            
            let params = ["friend_no": "\(friend)","my_no":"\(USERDETAILS.mobile)", "data":"\(msg!)", "message_id":"\(item.msg_id)","body":"Grant Permission download now","type":"1"]
            print(params)
            MakeHttpPostRequestChat(url: kXMPP.sendFileNotification, params: params, completion: {(success, response) in
                print(response)
                
            }, errorHandler: {(message) -> Void in
                print("message", message)
            })
            
            
        }
        catch {print(error)
            
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
                    
                    let dc = UIDocumentInteractionController(url: URL(string: fileURL.absoluteString)!)
                    dc.delegate = self
                    dc.presentPreview(animated: true)
                        
                    
                }
                
            } catch  {
                print("error writing file  : \(error)")
            }
        }
        task.resume()
        
    }
    
    
    func deleteNotification(id:String){
        
       
            
            let params = ["notification_id": "\(id)"]
            print(params)
            MakeHttpPostRequestChat(url: kXMPP.deleteNotification, params: params, completion: {(success, response) in
                print(response)
                
                if self.arrayPhotos.count > 0 {
                    self.arrayPhotos.removeAll()
                }
                self.getNotification()
                
            }, errorHandler: {(message) -> Void in
                print("message", message)
            })
          
    }
    
    
}
