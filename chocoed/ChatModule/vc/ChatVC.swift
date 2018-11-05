//
//  ChatVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import XMPPFramework
import CoreData
import MobileCoreServices

import YPImagePicker


class ChatVC: UIViewController , OneMessageDelegate , UITableViewDelegate , UITableViewDataSource ,UIImagePickerControllerDelegate,UINavigationControllerDelegate , UIDocumentPickerDelegate  {
   
   
    
   
    private let cellID = "cellID"
    
    @IBOutlet var userTitle: UILabel!
    
    @IBOutlet var lblCurrentStatus: UILabel!
    @IBOutlet var tblView: UITableView!
    
    @IBOutlet var editMsg: UITextField!
    
    var friendModel : Friends!
    
    var imagePicker =  YPImagePicker()

    
    
    @IBAction func optionBtn_clicked(_ sender: UIButton) {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Option", message: nil, preferredStyle:.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {
            UIAlertAction in
           // self.openCamera(UIImagePickerController.SourceType.camera)
            
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: .default) {
            UIAlertAction in
          //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            self.openGallary()
            
        }
        
        let pdfAction = UIAlertAction(title: "Document", style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            self.openPdf()
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(pdfAction)

        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openGallary(){
        
        imagePicker.didSelectImage = { [unowned imagePicker] img in
            // image picked
            print(img.size)
            
            let url = self.savefiletoDirector(image: img)
            print(url)
            
            
        //   let isUploaded = self.uploadImage(selectedImage: img, msgID: "1234")
            
            self.saveInCoreDataWith(object: Message(
                msg: "",
                msgId: self.getCurrentTime(),
                msgType: kXMPP.TYPE_IMAGE,
                msgACk: "0",
                fromID: USERDETAILS.mobile,
                toID: self.friendModel.contact_number,
                fileUrl: url,
                isUpload: "0",
                isDownload: "0",
                isStreaming: "0",
                isMine: "1",
                created: self.getCurrentTime(),
                status: "",
                modified: self.getCurrentTime()))
            self.imagePicker.dismiss(animated: true, completion: nil)
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera(){
        
        imagePicker.didSelectImage = { [unowned imagePicker] img in
            // image picked
            print(img.size)
            
            let url = self.savefiletoDirector(image: img)
            print(url)
            
            self.saveInCoreDataWith(object: Message(
                msg: "",
                msgId: self.getCurrentTime(),
                msgType: kXMPP.TYPE_IMAGE,
                msgACk: "0",
                fromID: USERDETAILS.mobile,
                toID: self.friendModel.contact_number,
                fileUrl: url,
                isUpload: "0",
                isDownload: "0",
                isStreaming: "0",
                isMine: "1",
                created: "",
                status: "",
                modified: ""))
        
            self.imagePicker.dismiss(animated: true, completion: nil)
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openPdf(){
        
        let types : [String] = [kUTTypePDF as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        present(documentPicker, animated: true, completion: nil)
    }
    

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        
    }
    
    //MARK : UIDocument Picker
  
    
    func oneStream(_ sender: XMPPStream, didReceiveMessage message: XMPPMessage, from user: XMPPUserCoreDataStorageObject) {
        
        print(message.attributeStringValue(forName: "id") ?? "")
        let userData = (user.jidStr)!.components(separatedBy: "@")
        let friendID = userData[0]

        print(friendID)
        
          do{
            
         let data = message.body?.data(using: .utf8)!
            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
        
        
            self.saveInCoreDataWith(object: Message(
                msg: json.value(forKey: "message") as! String,
                msgId: message.attributeStringValue(forName: "id") ?? "",
                msgType: json.value(forKey: "msgType") as! String,
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
                modified: self.getCurrentTime()))
            
            self.tblView.reloadData()
            
          }catch{
            
          }
        
     
    }
    
    func oneStream(_ sender: XMPPStream, userIsComposing user: XMPPUserCoreDataStorageObject) {
        
        self.lblCurrentStatus.text = "Typing..."
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.lblCurrentStatus.text = ""
        })
        
    
        
    }
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Msg.self))
        
        print(friendModel.contact_number,"<<<  >>>")
        
      //  fetchRequest.predicate = NSPredicate(format: "to_id %@", friendModel.userId)

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "msg_id", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userTitle.text = self.friendModel.name
        OneMessage.sharedInstance.delegate = self
        
                imagePicker.delegate = self
        
       // OneLastActivity.sharedInstance.add
        
        
       
        
        
        
         self.tblView.register(MsgCell.self, forCellReuseIdentifier: cellID)
        
        do {
            try self.fetchedhResultController.performFetch()
            print("COUNT FETCHED FIRST: \(self.fetchedhResultController.sections?[0].numberOfObjects)")
            
            self.tblView.reloadData()
            
        } catch let error  {
            print("ERROR: \(error)")
        }
        
        let longPressRec = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressRec.minimumPressDuration = 1.0
        //longPressRec.delegate = self as! UIGestureRecognizerDelegate
        self.tblView.addGestureRecognizer(longPressRec)
 
       
        
    }
    
    @objc func longPress(longPressGesture : UILongPressGestureRecognizer) {
        
        if longPressGesture.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressGesture.location(in : self.tblView)
            
            if let indexPath = self.tblView.indexPathForRow(at: touchPoint){
                
                print(indexPath.row)
                
                self.openOptionForMsg()
            }
        }
    }
    
    func openOptionForMsg(){
        
        let alert:UIAlertController=UIAlertController(title: "Choose Option", message: nil, preferredStyle:.actionSheet)
        let replyAction = UIAlertAction(title: "Reply", style: .default) {
            UIAlertAction in
            // self.openCamera(UIImagePickerController.SourceType.camera)
            
            // No multi Select
        }
        let forwardAction = UIAlertAction(title: "Forward", style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            
        }
        
        let copyAction = UIAlertAction(title: "Copy", style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            // NO multiselect
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
           
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
        }
        
        alert.addAction(replyAction)
        alert.addAction(forwardAction)
        alert.addAction(copyAction)
        alert.addAction(deleteAction)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func send_msg_clicked(_ sender: UIButton) {
        
        do{
            
            let text = self.editMsg.text
            

            let body = CustomMessageModel(msgId: "", msgType: kXMPP.TYPE_TEXT, message: text!, fileUrl: "", desctructiveTime: "")
            
            let jsonData = try JSONEncoder().encode(body)
            let msg = String(data: jsonData, encoding: .utf8)
            
            print(msg ?? "")
            
            OneMessage.sendMessage(msg!, thread: "test", to: "\(friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
                
                print(message)
                print(stream)
                
                self.saveInCoreDataWith(object: Message(
                    msg: text!,
                    msgId: self.getCurrentTime(),
                    msgType: kXMPP.TYPE_TEXT,
                    msgACk: "0",
                    fromID: USERDETAILS.mobile,
                    toID: self.friendModel.contact_number,
                    fileUrl: "",
                    isUpload: "0",
                    isDownload: "0",
                    isStreaming: "0",
                    isMine: "1",
                    created: self.getCurrentTime(),
                    status: "",
                    modified: self.getCurrentTime()))
                
                
            })
            
            
        }
        catch {print(error)}
       
        
    }
    
 
    @IBAction func back_btn_clicked(_ sender: Any) {
        
        dismiss(animated: false, completion: nil)

    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MsgCell
        
        if let item = fetchedhResultController.object(at: indexPath) as? Msg {
            cell.setMsgCellWith(item: item)
            
          /*  if item.msg_type == kXMPP.TYPE_IMAGE{
                
                if item.is_upload == "0" && item.is_streaming == "0"{
                    
                    let cell = tableView.cellForRow(at: indexPath)
                    if self.uploadImage(selectedImage: (cell?.imageView)!, msgID: item.msg_id){
                        
                        print("imageUploaded")
                        
                    }else{
                        print("fails")
                    }
                    
                }
                
            }
      */
            
            
            
        }
        return cell
    }
    
    
    
    
    /**** CORE DATA ****/
    
    private func saveInCoreDataWith(object: Message) {
        
        self.createMsgEntityFrom(item: object)
        
       
    }
    
    private func createMsgEntityFrom(item: Message) {
    
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let msgObject = NSEntityDescription.insertNewObject(forEntityName: "Msg", into: context) as? Msg {
            
             msgObject.msg = item.msg
             msgObject.created = item.created
             msgObject.file_url = item.fileUrl
             msgObject.from_id = item.fromID
             msgObject.is_download = item.isDownload
             msgObject.is_mine = item.isMine
             msgObject.is_streaming = item.isStreaming
             msgObject.is_upload = item.isUpload
             msgObject.modified = item.modified
             msgObject.msg = item.msg
             msgObject.msg_ack = item.msgACk
             msgObject.msg_id = item.msgId
             msgObject.msg_type = item.msgType
             msgObject.status = item.status
             msgObject.to_id = item.toID
        }
            do {
                try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
            } catch let error {
                print(error)
            }
            
         /*   return msgObject
            
        }
        return nil */
    }
    
    private func clearData() {
        do {
            
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Msg.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    
    
    
    
    private func deleteMsg( id: String ){
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Msg.self))
        fetchRequest.predicate = NSPredicate(format: "msg_id %@", "\(id)")
        do {
            let fetchedresults  = try context.execute(fetchRequest) as? [NSManagedObject]
            
            for entity in fetchedresults! {
                
                context.delete(entity)
            }
            
        } catch let error {
            print("ERROR DELETING : \(error)")
        }

    }
    
    /**** Last Activity ****/
    
    
    func xmppLastActivity(_ sender: XMPPLastActivity!, didReceiveResponse response: XMPPIQ!) {
        
        print(response)
    }
    
    func xmppLastActivity(_ sender: XMPPLastActivity!, didNotReceiveResponse queryID: String!, dueToTimeout timeout: TimeInterval) {
        
        print(timeout)
        
    }
    
    func numberOfIdleTimeSeconds(for sender: XMPPLastActivity!, queryIQ iq: XMPPIQ!, currentIdleTimeSeconds idleSeconds: UInt) -> UInt {
        print(idleSeconds)
        
        return idleSeconds;
    }
    
    
    /*** Files ****/
    
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
    
    private func uploadImage(selectedImage : UIImage,msgID : String) -> Bool {
        
        let imageData = UIImagePNGRepresentation(selectedImage)
        
        let imageUploadParams = ["msg_id": "\(msgID)"] as! Dictionary<String, String>
        MakeHttpMIME2PostRequestChat(url: "http://getsetrecharge.com/chocoed/api/upload_image", imageData: imageData as! NSData, param: imageUploadParams, completion: {(success, response) -> Void in
            print(response, "UPLOAD PROFILE PIC RESPONSE")
            
        })
        
        return true
    }
    
    
    
    private func getCurrentTime() -> String {
        
        let messageID = Int64(NSDate().timeIntervalSince1970 * 1000)
        return String(messageID)
        
    }
    
  
   
}


extension ChatVC: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            self.tblView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            self.tblView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tblView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tblView.beginUpdates()
    }
}

