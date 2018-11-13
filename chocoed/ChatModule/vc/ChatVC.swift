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
import SDWebImage
import YPImagePicker


class ChatVC: UIViewController , OneMessageDelegate , UITableViewDelegate , UITableViewDataSource ,UIImagePickerControllerDelegate,UINavigationControllerDelegate , UIDocumentPickerDelegate , UITextFieldDelegate, XMPPLastActivityDelegate {
    
    private let cellID = "cellID"
    
    @IBOutlet var userTitle: UILabel!
    
    @IBOutlet var lblCurrentStatus: UILabel!
    @IBOutlet var tblView: UITableView!
    
    @IBOutlet var editMsg: UITextField!
    
    var friendModel : Friends!
    
    var imagePicker =  YPImagePicker()
    
    @IBOutlet var myProfileImage: UIImageView!
    

    @IBOutlet var bottomView: UIView!
    
    var selectedArr = [Msg]()
    
    var selectionType : String = ""
    
    var type = ""
    
    var isMuliselectActionChecked = false
    
    
    
    @IBOutlet var toolbar: UIView!
    
    @IBOutlet var actionView: UIView!
    
    @IBOutlet var btnForward: UIButton!
    
    @IBOutlet var btnDelete: UIButton!
    
    
    
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
            //print(img.size)
            
            let url = self.savefiletoDirector(image: img)
            self.imagePicker.dismiss(animated: true, completion: nil)
            let msgId = self.getCurrentTime()
            self.createMsgEntityFrom(item: Message(
                msg: "",
                msgId: msgId,
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
                modified: self.getCurrentTime(),
                is_permission: "0"))
            
            self.tblView.reloadData()
            self.tblView.scrollToBottom()
            
            
        }
        
        present(imagePicker, animated: true, completion: nil)
        


    }
    
    func openCamera(){
        
        imagePicker.didSelectImage = { [unowned imagePicker] img in
            // image picked
           
            let url = self.savefiletoDirector(image: img)
            self.imagePicker.dismiss(animated: true, completion: nil)
            let msgId = self.getCurrentTime()
            self.createMsgEntityFrom(item: Message(
                msg: "",
                msgId: msgId,
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
                modified: self.getCurrentTime(),
                is_permission: "0"))
            
            self.tblView.reloadData()
            self.tblView.scrollToBottom()
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
        
            print(json)
        
            self.createMsgEntityFrom(item: Message(
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
                modified: self.getCurrentTime(),
                is_permission: "1"))
            
            
            self.updateFriendCell(last_msg_time: self.getCurrentTime(), msg: json.value(forKey: "message") as! String, msg_type: json.value(forKey: "msgType") as! String, isMine: "0" , friendID: friendID)
            
            self.tblView.reloadData()
            self.tblView.scrollToBottom()
            
          }catch{
            
          }
        
     
    }
    
    
    func oneStream(_ sender: XMPPStream, didReceiptReceive message: XMPPMessage, from user: XMPPUserCoreDataStorageObject) {
        
        print(message.attributeStringValue(forName: "id") ?? "")
        let userData = (user.jidStr)!.components(separatedBy: "@")
        let friendID = userData[0]
        
        print(friendID)
    }
    
    func oneStream(_ sender: XMPPStream, userIsComposing user: XMPPUserCoreDataStorageObject) {
        
        self.lblCurrentStatus.text = "Typing..."
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.lblCurrentStatus.text = "Online"
        })
        
    
        
    }
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Msg.self))
        
        print(friendModel.contact_number,"<<<  >>>")
        
    fetchRequest.predicate = NSPredicate(format: "to_id == %@",self.friendModel.contact_number)

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "msg_id", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.updateReadCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userTitle.text = self.friendModel.name
        OneMessage.sharedInstance.delegate = self
        self.editMsg.delegate = self
        
        
        
        self.toolbar.isHidden = false
        self.actionView.isHidden = true
        
        
        self.bottomView.bindToKeyboard()
        
        imagePicker.delegate = self
        
       // OneLastActivity.sharedInstance.add
        
        
        self.tblView.estimatedRowHeight = 120.0
        self.tblView.rowHeight = UITableViewAutomaticDimension
        
        let myTextNib = UINib(nibName: "MyTextMsgCell", bundle: Bundle.main)
        self.tblView.register(myTextNib, forCellReuseIdentifier: "MyTextMsgCell")
        
        let friendTextNib = UINib(nibName: "FriendTextMsgCell", bundle: Bundle.main)
        self.tblView.register(friendTextNib, forCellReuseIdentifier: "FriendTextMsgCell")
        
        let myFileNib = UINib(nibName: "MyFileViewCell", bundle: Bundle.main)
        self.tblView.register(myFileNib, forCellReuseIdentifier: "MyFileViewCell")
        
        
        let friendFileNib = UINib(nibName: "FriendFileView", bundle: Bundle.main)
        self.tblView.register(friendFileNib, forCellReuseIdentifier: "FriendFileView")
        
    
       
       // self.tblView.register(MyTextMsgCell.self, forCellReuseIdentifier: cellID)
       // self.tblView.register(FriendTextMsgCell.self, forCellReuseIdentifier: "FriendTextMsgCell")

        
        
        
        do {
            try self.fetchedhResultController.performFetch()
            print("COUNT FETCHED FIRST: \(self.fetchedhResultController.sections?[0].numberOfObjects)")
            
            
            self.tblView.reloadData()
            if self.fetchedhResultController.sections?[0].numberOfObjects != 0{
                self.tblView.scrollToBottom()
            }
        } catch let error  {
            print("ERROR: \(error)")
        }
        
        let longPressRec = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressRec.minimumPressDuration = 1.0
        //longPressRec.delegate = self as! UIGestureRecognizerDelegate
        self.tblView.addGestureRecognizer(longPressRec)
 
        
        let taggesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.myProfileImage.isUserInteractionEnabled = true
        self.myProfileImage.addGestureRecognizer(taggesture)
        
        if self.type == "forward"{
            self.type = ""
            self.sendForwardedMsg()
        }
    }
    
    func sendForwardedMsg(){
        
        print(self.selectedArr)
        
    
        
        for item in self.selectedArr {
            
            if item.msg_type == kXMPP.TYPE_TEXT {
                
                do{
                
                let text = item.msg
                    
                 
                        
                        let body = CustomMessageModel(msgId: "", msgType: kXMPP.TYPE_TEXT, message: text, fileUrl: "", desctructiveTime: "")
                        
                
            
                let jsonData = try JSONEncoder().encode(body)
                let msg = String(data: jsonData, encoding: .utf8)
                
                print(msg ?? "")
                    
                    
                    self.createMsgEntityFrom(item: Message(
                        msg: text,
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
                        modified: self.getCurrentTime(),
                        is_permission: "0"))
                    
                    self.updateFriendCell(last_msg_time: self.getCurrentTime(), msg: text, msg_type: kXMPP.TYPE_TEXT, isMine: "1", friendID: self.friendModel.contact_number)
                    
                    self.tblView.reloadData()
                    self.tblView.scrollToBottom()
                
                OneMessage.sendMessage(msg!, thread: "test", to:"\(friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
                })
                    
                    
                }catch{
                    
                }
                
            }
            else if item.msg_type == kXMPP.TYPE_TEXT || item.msg_type == kXMPP.TYPE_PDF {
                
                
                var msgtype = ""
                
                if item.msg_type == kXMPP.TYPE_IMAGE {
                    msgtype = kXMPP.TYPE_IMAGE
                }else {
                    msgtype = kXMPP.TYPE_PDF
                }
                
                
                self.createMsgEntityFrom(item: Message(
                    msg: "",
                    msgId:self.getCurrentTime(),
                    msgType: msgtype,
                    msgACk: "0",
                    fromID: USERDETAILS.mobile,
                    toID: self.friendModel.contact_number,
                    fileUrl: item.file_url,
                    isUpload: "0",
                    isDownload: "0",
                    isStreaming: "0",
                    isMine: "1",
                    created: self.getCurrentTime(),
                    status: "",
                    modified: self.getCurrentTime(),
                    is_permission: "0"))
                
                self.tblView.reloadData()
                self.tblView.scrollToBottom()
                
            }
        }
        
        
        if self.selectedArr.count > 0 {
            
            self.selectedArr.removeAll()
        }
        
    }
    
    @objc func imageTapped(tapGestureRecognizer : UITapGestureRecognizer ){
    
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
            vcNewSectionStarted.name = self.friendModel.name
            vcNewSectionStarted.profileiMage = self.friendModel.profile_image
            vcNewSectionStarted.contactMobileNumber = self.friendModel.contact_number
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
 
      
    
    }
    
    @objc func longPress(longPressGesture : UILongPressGestureRecognizer) {
        
        if longPressGesture.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressGesture.location(in : self.tblView)
            
            if let indexPath = self.tblView.indexPathForRow(at: touchPoint){
                
                print(indexPath.row)
                
                self.openOptionForMsg(row: indexPath)
            }
        }
    }
    
    func openOptionForMsg(row : IndexPath){
        
        let alert:UIAlertController=UIAlertController(title: "Choose Option", message: nil, preferredStyle:.actionSheet)
        let replyAction = UIAlertAction(title: "Reply", style: .default) {
            UIAlertAction in
            // self.openCamera(UIImagePickerController.SourceType.camera)
            
            // No multi Select
        }
        let forwardAction = UIAlertAction(title: "Forward", style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            let item = self.fetchedhResultController.object(at: row) as? Msg
            self.selectedArr.append(item!)
            self.tblView.cellForRow(at: row)?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            self.selectionType = "forward"
            
            self.toolbar.isHidden = true
            self.actionView.isHidden = false
            
            self.isMuliselectActionChecked = true
            
            self.btnDelete.isHidden = true
            self.btnForward.isHidden = false
        }
        
        let copyAction = UIAlertAction(title: "Copy", style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            // NO multiselect
            
            let item = self.fetchedhResultController.object(at: row) as? Msg
            if item?.msg_type == kXMPP.TYPE_TEXT {
                UIPasteboard.general.string = item?.msg
            }

            
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            let item = self.fetchedhResultController.object(at: row) as? Msg
            self.selectedArr.append(item!)
            self.tblView.cellForRow(at: row)?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            self.selectionType = "delete"
            
            self.toolbar.isHidden = true
            self.actionView.isHidden = false
            
            self.isMuliselectActionChecked = true
            
            self.btnDelete.isHidden = false
            self.btnForward.isHidden = true


            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
            
            self.isMuliselectActionChecked = false
            self.toolbar.isHidden = false
            self.actionView.isHidden = true
            if self.selectedArr.count > 0 {
                self.selectedArr.removeAll()
            }

        }
        
        alert.addAction(replyAction)
        alert.addAction(forwardAction)
        alert.addAction(copyAction)
        alert.addAction(deleteAction)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func getFriendStatus(){
        
        
        OneLastActivity.sendLastActivityQueryToJID(("\(self.friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal"), sender: OneChat.sharedInstance.xmppLastActivity) { (response, forJID, error) -> Void in
            
            if response != nil {
            
            let lastActivityResponse = OneLastActivity.sharedInstance.getLastActivityFrom((response?.lastActivitySeconds())!)
            
            
            self.lblCurrentStatus.text = lastActivityResponse
                
            }
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getFriendStatus()
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (timer) in
            self.getFriendStatus()
        })
        
        self.myProfileImage.sd_setImage(with : URL(string: self.friendModel.profile_image))
        self.myProfileImage.layer.cornerRadius = (self.myProfileImage.frame.width) / 2
        self.myProfileImage.clipsToBounds = true
        self.myProfileImage.contentMode = .scaleToFill
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func send_msg_clicked(_ sender: UIButton) {
        
        do{
            
            
        if self.lblCurrentStatus.text == "Online"  {
           
            
            let text = self.editMsg.text
            
            var desrc = ""
            
            if self.type == "destructive" {
                
                self.type = ""
                desrc = "2"
                
            }else{
                
                desrc = ""
                
            }
            
            
            let body = CustomMessageModel(msgId: "", msgType: kXMPP.TYPE_TEXT, message: text!, fileUrl: "", desctructiveTime: desrc)
            
            let jsonData = try JSONEncoder().encode(body)
            let msg = String(data: jsonData, encoding: .utf8)
            
            print(msg ?? "")
            
            self.editMsg.resignFirstResponder()
            self.editMsg.text = ""
            
            
            self.createMsgEntityFrom(item: Message(
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
                modified: self.getCurrentTime(),
                is_permission: "0"))
            
            self.updateFriendCell(last_msg_time: self.getCurrentTime(), msg: text!, msg_type: kXMPP.TYPE_TEXT, isMine: "1", friendID: self.friendModel.contact_number)
            
            
            self.tblView.reloadData()
            self.tblView.scrollToBottom()
            
            OneMessage.sendMessage(msg!, thread: "test", to:"\(friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
            })
                
        }else{
                
                // offline send msg
            
            let text = self.editMsg.text
            
            var desrc = ""
            
            if self.type == "destructive" {
                
                self.type = ""
                desrc = "2"
                
            }else{
                
                desrc = ""
                
            }
            
            let msgId = self.getCurrentTime()
            
            let body = CustomMessageModel(msgId: "", msgType: kXMPP.TYPE_TEXT, message: text!, fileUrl: "", desctructiveTime: desrc)
            
            let jsonData = try JSONEncoder().encode(body)
            let msg = String(data: jsonData, encoding: .utf8)
            
            self.editMsg.resignFirstResponder()
            self.editMsg.text = ""
            
            
            let params = ["friend_no": "\(self.friendModel.contact_number)","my_no":"\(USERDETAILS.mobile)", "data":"\(msg!)", "message_id":"\(msgId)"]
            print(params)
            MakeHttpPostRequestChat(url: kXMPP.sendNotification, params: params, completion: {(success, response) in
                print(response)
                
                
                DispatchQueue.main.async {
             
                self.createMsgEntityFrom(item: Message(
                    msg: text!,
                    msgId: msgId,
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
                    modified: self.getCurrentTime(),
                    is_permission: "0"))
                
                self.updateFriendCell(last_msg_time: self.getCurrentTime(), msg: text!, msg_type: kXMPP.TYPE_TEXT, isMine: "1", friendID: self.friendModel.contact_number)
                
                
                
                
                self.tblView.reloadData()
                self.tblView.scrollToBottom()
                    
                    
                }
                
                
            }, errorHandler: {(message) -> Void in
                print("message", message)
            })
            
                
        }
            
            
        }
        catch {print(error)}
       
        
    }
    
 
    @IBAction func back_btn_clicked(_ sender: Any) {
        
        self.isMuliselectActionChecked = false
        self.toolbar.isHidden = false
        self.actionView.isHidden = true
        if self.selectedArr.count > 0 {
            self.selectedArr.removeAll()
        }
        
        self.updateReadCount()
        
        dismiss(animated: false, completion: nil)

    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            print(count)
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       // let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MsgCell
        
        if let item = fetchedhResultController.object(at: indexPath) as? Msg {
            //cell.setMsgCellWith(item: item)
            
            
            if item.is_mine == "1" {
                
                
                if item.msg_type == kXMPP.TYPE_TEXT {
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MyTextMsgCell", for: indexPath) as! MyTextMsgCell
                    // cell.item = item
                    
                    cell.lblMsg?.text = item.msg
                    cell.lblMsg?.frame.size = (cell.lblMsg?.intrinsicContentSize)!
                    
                    
                    cell.lblTime?.text  = Utils.getTimeFromString(date: item.created!)
                    cell.lblTime?.frame.size = (cell.lblTime?.intrinsicContentSize)!
                    
                    
                    
                    
                    cell.profileImga?.sd_setImage(with : URL(string: USERDETAILS.imageurl))
                    cell.profileImga?.layer.cornerRadius = (cell.profileImga?.frame.width)! / 2
                    cell.profileImga?.clipsToBounds = true
                    cell.profileImga?.contentMode = .scaleToFill
                    
                    if self.selectedArr.contains(item){
                      
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                        
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryType.none

                    }
                    
                    return cell
                    
                }else if item.msg_type == kXMPP.TYPE_IMAGE {
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MyFileViewCell", for: indexPath) as! MyFileViewCell
                   
                    cell.lblTime?.text  = Utils.getTimeFromString(date: item.created!)
                    cell.lblTime?.frame.size = (cell.lblTime?.intrinsicContentSize)!
                    
                    cell.profileImage?.sd_setImage(with : URL(string: USERDETAILS.imageurl))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                    cell.fileview?.sd_setImage(with : URL(string: item.file_url))
                    cell.fileview?.contentMode = .scaleToFill
                    
                    if self.selectedArr.contains(item){
                        
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryType.none
                        
                    }
                    
                    return cell
                    
                    
                }else if item.msg_type == kXMPP.TYPE_PDF {
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MyFileViewCell", for: indexPath) as! MyFileViewCell
                    
                    cell.lblTime?.text  = Utils.getTimeFromString(date: item.created!)
                    cell.lblTime?.frame.size = (cell.lblTime?.intrinsicContentSize)!
                    
                    cell.profileImage?.sd_setImage(with : URL(string: USERDETAILS.imageurl))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                  //  cell.fileview?.sd_setImage(with : URL(string: item.file_url))
                  //  cell.fileview?.contentMode = .scaleToFill
                    
                    if self.selectedArr.contains(item){
                        
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryType.none
                        
                    }
                    
                    return cell
                    
                    
                }
                
              
                
                
            }else {
                
                if item.msg_type == kXMPP.TYPE_TEXT {

                
                  let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTextMsgCell", for: indexPath) as! FriendTextMsgCell
                  //cell.item = item
                
                cell.lblMsg?.text = item.msg
                cell.lblTime?.text  = Utils.getTimeFromString(date: item.created!)
                cell.profileImage?.sd_setImage(with : URL(string: self.friendModel.profile_image))
                cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                cell.profileImage?.clipsToBounds = true
                cell.profileImage?.contentMode = .scaleToFill
                    
                    if self.selectedArr.contains(item){
                        
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryType.none
                        
                    }
                    
                   return cell
                
                }else if item.msg_type == kXMPP.TYPE_IMAGE {
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FriendFileView", for: indexPath) as! FriendFileView
                    
                    cell.lblTime?.text  = Utils.getTimeFromString(date: item.created!)
                    cell.lblTime?.frame.size = (cell.lblTime?.intrinsicContentSize)!
                    
                    cell.profileImage?.sd_setImage(with : URL(string: self.friendModel.profile_image))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                    cell.fileView.alpha = 0.8
                    cell.fileView?.sd_setImage(with : URL(string: item.file_url))
                    cell.fileView?.contentMode = .scaleToFill
                    
                    if item.is_permission == "1" {
                        
                        cell.fileView.alpha = 0.8
                        cell.fileView?.sd_setImage(with : URL(string: item.file_url))
                        cell.fileView?.contentMode = .scaleToFill
                        
                    }else {
                    
                    if item.is_download == "0" {
                        
                        if item.is_streaming == "0"{
                            
                            self.updateMsg(msg_id: item.msg_id, type : "streaming" ,value: "1")
                        
                        SDWebImageManager.shared().imageDownloader?.downloadImage(with:  URL(string: item.file_url), options: .continueInBackground, progress: nil, completed: {(image : UIImage?,data:Data?,error:Error?,finished:Bool)
                            in
                            
                            if image != nil {
                                
                                let localURL  = self.savefiletoDirector(image: image!)
                                
                                print(localURL,"<<<< File URL >>>>>")
                                
                                UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
                                
                                self.updateMsg(msg_id: item.msg_id, type : "download" ,value: "1")
                                self.updateMsg(msg_id: item.msg_id, type : "file" ,value: localURL)

                                
                            }
                            
                            
                            
                        })
                            
                        }
                        
                      }
                    }
                    
                    if self.selectedArr.contains(item){
                        
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryType.none
                        
                    }
                    
                    return cell
                    
                    
                }else if item.msg_type == kXMPP.TYPE_PDF {
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FriendFileView", for: indexPath) as! FriendFileView
                    
                    cell.lblTime?.text  = Utils.getTimeFromString(date: item.created!)
                    cell.lblTime?.frame.size = (cell.lblTime?.intrinsicContentSize)!
                    
                    cell.profileImage?.sd_setImage(with : URL(string: self.friendModel.profile_image))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                    
                    
                    if item.is_permission == "1" {
                        
                        cell.fileView.alpha = 0.8
                        cell.fileView?.sd_setImage(with : URL(string: item.file_url))
                        cell.fileView?.contentMode = .scaleToFill
                        
                    }else {
                        
                        cell.fileView?.sd_setImage(with : URL(string: item.file_url))
                        cell.fileView?.contentMode = .scaleToFill
                    
                    if item.is_download == "0" {
                        
                        if item.is_streaming == "0"{
                            
                            self.updateMsg(msg_id: item.msg_id, type : "streaming" ,value: "1")
                            
                            SDWebImageManager.shared().imageDownloader?.downloadImage(with:  URL(string: item.file_url), options: .continueInBackground, progress: nil, completed: {(image : UIImage?,data:Data?,error:Error?,finished:Bool)
                                in
                                
                                if image != nil {
                                    
                                    let localURL  = self.savefiletoDirector(image: image!)
                                    
                                    print(localURL,"<<<< File URL >>>>>")
                                    
                                    UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
                                    
                                    self.updateMsg(msg_id: item.msg_id, type : "download" ,value: "1")
                                    self.updateMsg(msg_id: item.msg_id, type : "file" ,value: localURL)
                                    
                                    
                                }
                                
                                
                                
                            })
                            
                        }
                        
                    }
                }
                    
                    if self.selectedArr.contains(item){
                        
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryType.none
                        
                    }
                    
                    return cell
                    
                    
                }
            

            }
            
        
            
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if let item = fetchedhResultController.object(at: indexPath) as? Msg {
            
            if item.msg_type == kXMPP.TYPE_IMAGE    {
                
                return CGFloat(180)

            }
        }

        
        return UITableViewAutomaticDimension
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = fetchedhResultController.object(at: indexPath) as? Msg
        

        if self.isMuliselectActionChecked == true{
            
            self.selectedArr.append(item!)
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            
            
            if item?.msg_type != kXMPP.TYPE_TEXT {
                
                if item?.is_permission == "1" {
                    
                    
                    
                    let alertView = UIAlertController(title: "Permission", message: "Take permission from \(self.friendModel.name) to download file", preferredStyle: .alert)
                    
                    
                    let action = UIAlertAction(title: "Not Now", style: .default, handler: { (alert) in
                        
                       
                        
                    })
                    alertView.addAction(action)
                    
                    let actionSure = UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
                        // go to pending list view
                        
                        print("Yes")
                        
                    })
                    alertView.addAction(actionSure)
                    self.present(alertView, animated: true, completion: nil)
                    tableView.deselectRow(at: indexPath, animated: false)

                    
                    
                    
                }else{
                    
                    
                }
                
            }
            
        }
    
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
       
        
        
        
        if self.isMuliselectActionChecked == true{

        self.selectedArr.remove(at: indexPath.row)
         tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
   
            if self.selectedArr.count == 0 {
                
                self.toolbar.isHidden = false
                self.actionView.isHidden = true
            }
      }
    
    }

    
    
    /**** CORE DATA ****/
    
    
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
            
            if type == "download"{
                updatObj.setValue(value, forKey: "is_download")
            }
            
            if type == "file"{
                updatObj.setValue(value, forKey: "is_download")
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
    
    private func isMSgPrsent(item : Message) -> Bool {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "msg_id = %@", item.msgId)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
           /* if results.count != 0 {
                
                let updatObj = results[0]
                updatObj.setValue(item.name, forKey: "name")
                updatObj.setValue(item.profile_image, forKey:"profile_image")
                
                do{
                    try context.save()
                    
                }catch{
                    print("Error in update")
                }
            }
          */
            
            
            
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
            
            do {
                try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
            } catch let error {
                print(error)
            }
      //  }
        }else{
            print("present")
        }
        

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
    
    private func uploadImage(url : String,msgID : String) {
        
        DispatchQueue.global(qos : .background).async {
            
            do{
                let data = try Data.init(contentsOf: URL.init(string: url)!)
                DispatchQueue.main.async {
                    
                        let image : UIImage = UIImage(data:data)!
                    
                    
                       // let imageData = UIImagePNGRepresentation(image)
                    
                        self.uploadImageToServer(image: image, msgId: msgID)
                    
                    
                    
                    
                    
                }
                
            }catch{
                
            }
        }
        
    }
    
    
    
    private func getCurrentTime() -> String {
        
        let messageID = Int64(NSDate().timeIntervalSince1970 * 1000)
        return String(messageID)
        
    }
    
    
    func updateReadCount(){
     
        
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
            fetchRequest.predicate = NSPredicate(format: "contact_number = %@", self.friendModel.contact_number)
            
            var results : [NSManagedObject] = []
            
            do{
                results = try context.fetch(fetchRequest)
                
                if results.count != 0 {
                    
                    let updatObj = results[0]
                   
                    updatObj.setValue("0", forKey: "read_count")
                    
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
    
    
    
    func updateFriendCell(last_msg_time : String , msg : String , msg_type :String , isMine : String, friendID : String){
        
        // update friend profile
        
        print(friendID)
    
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", friendID)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let updatObj = results[0]
                
                var count = updatObj.value(forKey: "read_count") as? Int ?? 0
                count = count + 1
               
                updatObj.setValue(msg, forKey: "last_msg")
                updatObj.setValue(msg_type, forKey:"last_msg_type")
                updatObj.setValue(last_msg_time, forKey:"last_msg_time")
                updatObj.setValue(isMine, forKey:"is_mine")
                updatObj.setValue(String(count), forKey: "read_count")
                
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
    
    
    /* Edit Box Delegate */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.editMsg.resignFirstResponder()
       // self.bottomView.unbindToKeyboard()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 0 {
            
        } else {
            
            if (textField.text?.count )! % 2 != 0 {

            
            OneMessage.sendIsComposingMessage(("\(self.friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal"), thread: "test", completionHandler: { (stream, message) -> Void in
                
            })
                
          }
        }
        
        return true
    }
    
    
    
    
    

    /* ***********8 FILE UPLAD API *********/
    
    
  
    func uploadImageToServer(image : UIImage, msgId : String)
    {
        
        let myUrl = URL(string: kXMPP.uploadImage);
        
        let request = NSMutableURLRequest(url:myUrl!);
        request.httpMethod = "POST";
        
        let param = [
            "msg_id"  : msgId,
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(image, 1)
        
        print(imageData)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = self.createBodyWithParameters(parameters: param, filePathKey: "image", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error?.localizedDescription)")
                return
            }
            
            // You can print out response object
          //   print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
           
                DispatchQueue.main.async {
                    
                    //self.updateMsg(msg_id: json?.object(forKey: "msg_id") as! String, type: "uploaded", value: <#T##String#>)
                    
                    do{
                    
                    if json?.object(forKey: "responce") as! Int == 1 {
                    
                  
                        
                        let body = CustomMessageModel(msgId: "", msgType: kXMPP.TYPE_IMAGE, message: "", fileUrl: json?.object(forKey: "data") as! String, desctructiveTime: "")
                        
                        let jsonData = try JSONEncoder().encode(body)
                        let msg = String(data: jsonData, encoding: .utf8)
                        
                        print(msg ?? "")
                        
                        OneMessage.sendMessage(msg!, thread: "test", to:"\(self.friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
                        
                        })
                        
                    }
                        
                    }catch{
                        
                    }
                    
                }
                
            }catch
            {
                print(error)
            }
            
           
        }
        
        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "\(self.getCurrentTime()).png"
        let mimetype = "image/png"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    
    
    @IBAction func actionCancelClicked(_ sender: UIButton) {
        
        
        self.isMuliselectActionChecked = false
        self.toolbar.isHidden = false
        self.actionView.isHidden = true
        if self.selectedArr.count > 0 {
            self.selectedArr.removeAll()
        }
        
        self.tblView.reloadData()
        self.tblView.scrollToBottom()
    }
    
    @IBAction func actionForwardClicked(_ sender: Any) {
        
        
        
        print(selectedArr)
        
        
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "FriendListVC") as? FriendListVC {
        
            vcNewSectionStarted.selectedArray = self.selectedArr
            vcNewSectionStarted.type = "forward"
            
            self.isMuliselectActionChecked = false
            self.toolbar.isHidden = false
            self.actionView.isHidden = true
            if self.selectedArr.count > 0 {
                self.selectedArr.removeAll()
            }
           
            
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
    
        
       
        
    }
    @IBAction func actionDeleteClicked(_ sender: Any) {
        
        print("delete")
        do{
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            
            
            
            for item in self.selectedArr{
                
                context.delete(item)
            }
            
            self.isMuliselectActionChecked = false
            self.toolbar.isHidden = false
            self.actionView.isHidden = true
            if self.selectedArr.count > 0 {
                self.selectedArr.removeAll()
            }
            self.tblView.reloadData()
         
        }catch let error {
            print("ERROR DELETING : \(error)")
        }
        
      
    }
    
  
   
}

extension UIView{
    
    
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func unbindToKeyboard(){
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    @objc
    func keyboardWillChange(notification: Notification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y+=deltaY
            
            
            
        },completion: nil)
        
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

extension UITableView {
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.numberOfRows(inSection: self.numberOfSections - 1 ) - 1, section : self.numberOfSections - 1)
            
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            
        }
    }
}



