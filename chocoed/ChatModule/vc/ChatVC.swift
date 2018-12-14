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


class ChatVC: UIViewController  , UITableViewDelegate , UITableViewDataSource ,UIImagePickerControllerDelegate,UINavigationControllerDelegate , UIDocumentPickerDelegate , UITextFieldDelegate, XMPPLastActivityDelegate  , OneMessageDelegate , UIDocumentInteractionControllerDelegate {
    
    private let cellID = "cellID"
    
    @IBOutlet var detailView: UIView!
    
    
    private var isTyping : Bool = false
    
    
    @IBOutlet var tblView: UITableView!
    @IBOutlet var lblReplyColor: UILabel!
    
    @IBOutlet var userTitle: UILabel!
    
    @IBOutlet var lblCurrentStatus: UILabel!
    @IBOutlet var editMsg: UITextField!
    
    var friendModel : Friends!
    
    
    
    
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
    
    
    @IBOutlet var replyView: UIView!
    
    @IBOutlet var lblReplyTitle: UILabel!
    
    
    @IBOutlet var lblReplyMsg: UILabel!
    
    @IBOutlet var imgReplyType: UIImageView!
    
    
    
    @IBOutlet var imgReplyFile: UIImageView!
    
    var replyeMessageID = ""
    var isKeyEditing = false
    
    var viewHeight : CGFloat!
    var replyHeight : CGFloat!
    
    var count = 0
    
    var isImageApiCalled = 0
    
    var keyboard = false
    var lastKeyboardHeight : CGFloat!
    
    
    @IBAction func reply_cancel_clicked(_ sender: Any) {
        
        self.replyView.isHidden = true
        self.replyeMessageID = ""
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    /*func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
     return self
     } */
    
    
    @IBAction func optionBtn_clicked(_ sender: UIButton) {
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        let alert:UIAlertController=UIAlertController(title: "ChooseoptionKey".localizableString(loc: language!), message: nil, preferredStyle:.actionSheet)
        let cameraAction = UIAlertAction(title: "CameraKey".localizableString(loc: language!), style: .default) {
            UIAlertAction in
            // self.openCamera(UIImagePickerController.SourceType.camera)
            
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "GalleryKey".localizableString(loc: language!), style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            self.openGallary()
            
        }
        
        let pdfAction = UIAlertAction(title: "DocumentKey".localizableString(loc: language!), style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            self.openPdf()
            
        }
        
        
        let cancelAction = UIAlertAction(title: "cancelKey".localizableString(loc: language!), style: .cancel) {
            UIAlertAction in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(pdfAction)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func saveImageWithPer(fileurl:String,type:String,permission:String) {
        
        var desrc = ""
        
        
        self.isImageApiCalled = 0
        
        print(self.isImageApiCalled,"<<< APICalled>>>")

        
        if self.type == "destructive" {
            desrc = kXMPP.DESTRUCT_TIME
        }
        
        let msgId = self.getCurrentTime()
        self.createMsgEntityFrom(item: Message(
            msg: "",
            msgId: msgId,
            msgType: type,
            msgACk: "3",
            fromID: USERDETAILS.mobile,
            toID: self.friendModel.contact_number,
            fileUrl: fileurl,
            isUpload: "0",
            isDownload: "0",
            isStreaming: "0",
            isMine: "1",
            created: self.getCurrentTime(),
            status: "",
            modified: self.getCurrentTime(),
            is_permission: permission, replyTitle: "", replyMsgType: "", replyMsgId: "", replyMsgFile: "", replyMsg: "",
            sentTime: kXMPP.SEEN_MSG,
            seenTime: kXMPP.SEEN_MSG,
            destructiveTime: desrc))
        
        
        //self.tblView.reloadData()
        //self.scrollToBottom()
        
    }
    
    private func saveImage(fileurl:String,type:String) {
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        let alert:UIAlertController=UIAlertController(title: "SecureItkey", message: nil, preferredStyle:.actionSheet)
        let cameraAction = UIAlertAction(title: "withPermissionKey".localizableString(loc: language!), style: .default) {
            UIAlertAction in
            
            self.saveImageWithPer(fileurl: fileurl, type: type, permission: "1")
            
        }
        let gallaryAction = UIAlertAction(title: "withoutPermissionKey".localizableString(loc: language!), style: .default) {
            UIAlertAction in
            //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
            
            self.saveImageWithPer(fileurl: fileurl, type: type, permission: "0")
            
        }
        
        
        let cancelAction = UIAlertAction(title: "cancelKey".localizableString(loc: language!), style: .cancel) {
            UIAlertAction in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openGallary(){
        
        var config = YPImagePickerConfiguration()
        config.showsFilters = false
        config.screens = [.library]
        let imagePicker =  YPImagePicker(configuration: config)
        imagePicker.delegate = self
        imagePicker.didFinishPicking { [unowned imagePicker] items, cancelled in
            imagePicker.dismiss(animated: true, completion: nil)
            if cancelled {
                print("Picker was canceled")
            }else{
                let photo  = items.singlePhoto
                let url = self.savefiletoDirector(image: photo!.image)
                self.saveImage(fileurl: url,type: kXMPP.TYPE_IMAGE)
            }
            

            
        }
        present(imagePicker, animated: true, completion: nil)

    }
    
    func openCamera(){
        var config = YPImagePickerConfiguration()
        config.showsFilters = false
        config.screens = [.photo]
        let imagePicker =  YPImagePicker(configuration: config)
        imagePicker.delegate = self
        imagePicker.didFinishPicking { [unowned imagePicker] items, cancelled in
            imagePicker.dismiss(animated: true, completion: nil)
            if cancelled {
                print("Picker was canceled")
                
            }else{
                
                    let photo  = items.singlePhoto
                    let url = self.savefiletoDirector(image: photo!.image)
                    self.saveImage(fileurl: url,type: kXMPP.TYPE_IMAGE)
                
            }
            

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
        
        do{
            
            let fileName = "\(Int64(NSDate().timeIntervalSince1970 * 1000)).pdf"
            let documentFolderURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentFolderURL.appendingPathComponent(fileName)
            try FileManager.default.moveItem(at: urls[0], to: fileURL)
            
            let urlstring = fileURL.absoluteString
            self.saveImage(fileurl: urlstring,type: kXMPP.TYPE_PDF)
            
        }catch{
            
        }
        
    }
    
    func oneStream(_ sender: XMPPStream, userIsComposing user: XMPPUserCoreDataStorageObject) {
        
        let userData = (user.jidStr)!.components(separatedBy: "@")
        
        
        if userData[0] == self.friendModel.contact_number {
            self.lblCurrentStatus.text = "Typing..."
            self.isTyping = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                
                if self.isTyping == true {
                    self.isTyping = false
                }else{
                    
                    self.lblCurrentStatus.text = "Online"
                    
                }
                
                
                
            })
        }
        
        
        
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
        UserDefaults.standard.set("", forKey: "chatNo")
        OneMessage.sharedInstance.delegate = nil
        self.editMsg.delegate = nil
        //self.updateReadCount()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scrollToBottom()
        self.updateTableContentInset()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isImageApiCalled = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
        
        UserDefaults.standard.set(self.friendModel.contact_number, forKey: "chatNo")
        
        UIApplication.shared.cancelAllLocalNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        
        self.userTitle.text = self.friendModel.name
        self.editMsg.borderStyle = .roundedRect
        self.editMsg.autocorrectionType = .no
        
        self.replyView.isHidden = true
        self.replyView.layer.borderColor = UIColor.gray.cgColor
        self.replyView.layer.borderWidth = 1.0
        
        self.toolbar.isHidden = false
        self.actionView.isHidden = true
        
        OneMessage.sharedInstance.delegate = self
        self.editMsg.delegate = self
        
        
        self.sendSeenMsgAck()
        
        
        self.tblView.estimatedRowHeight = 120.0
        self.tblView.rowHeight = UITableViewAutomaticDimension
        self.tblView.estimatedSectionHeaderHeight = 60.0
        
       // self.tblView.tableFooterView = self.bottomView
        
        let myTextNib = UINib(nibName: "MyTextMsgCell", bundle: Bundle.main)
        self.tblView.register(myTextNib, forCellReuseIdentifier: "MyTextMsgCell")
        
        let friendTextNib = UINib(nibName: "FriendTextMsgCell", bundle: Bundle.main)
        self.tblView.register(friendTextNib, forCellReuseIdentifier: "FriendTextMsgCell")
        
        let myFileNib = UINib(nibName: "MyFileViewCell", bundle: Bundle.main)
        self.tblView.register(myFileNib, forCellReuseIdentifier: "MyFileViewCell")
        
        
        let friendFileNib = UINib(nibName: "FriendFileView", bundle: Bundle.main)
        self.tblView.register(friendFileNib, forCellReuseIdentifier: "FriendFileView")
        
        let myReplyView = UINib(nibName: "myTextReplyCell", bundle: Bundle.main)
        self.tblView.register(myReplyView, forCellReuseIdentifier: "myTextReplyCell")
        
        let friendReplyView = UINib(nibName: "FriendTextReplyCell", bundle: Bundle.main)
        self.tblView.register(friendReplyView, forCellReuseIdentifier: "FriendTextReplyCell")
        
        
        
        do {
            try self.fetchedhResultController.performFetch()
        } catch let error  {
            print("ERROR: \(error)")
        }
        
        let longPressRec = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressRec.minimumPressDuration = 1.0
        self.tblView.addGestureRecognizer(longPressRec)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeGesture.direction = .right
        self.tblView.addGestureRecognizer(swipeGesture)
        
        
        let taggesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.myProfileImage.isUserInteractionEnabled = true
        self.myProfileImage.addGestureRecognizer(taggesture)
        
        if self.type == "forward"{
            self.type = ""
            self.sendForwardedMsg()
        }
        
        
        self.scrollToBottom()
        self.updateTableContentInset()
        
     /*   NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardType), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
 
      */
        
     
        
    }
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            
            let count = self.fetchedhResultController.sections?.first?.numberOfObjects ?? 0
            
            if count != 0 {
                let indexPath = IndexPath(row: count - 1, section: 0)
                self.tblView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: false)
                //self.tblView.scrollIndicatorInsets = self.tblView.contentInset
            }
        }
        
        
        
    }
    
    func updateTableContentInset(){
        
        let numRows = tableView(self.tblView, numberOfRowsInSection: 0)
        var contentInsetTop = self.tblView.bounds.size.height
        
        for i in 0..<numRows{
            
            let rowRect = self.tblView.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
            }
            
            self.tblView.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0)
        }
        
        
    }
    
    func sendForwardedMsg(){
        
        print(self.selectedArr)
        
        
        
        for item in self.selectedArr {
            
            if item.msg_type == kXMPP.TYPE_TEXT {
                
                do{
                    
                    let text = item.msg
                    
                    
                    
                    let body = CustomMessageModel(msgId: "", msgType: kXMPP.TYPE_TEXT, message: text, fileUrl: "", destructiveTime : "",fileType : "",filePermission:"")
                    
                    
                    
                    let jsonData = try JSONEncoder().encode(body)
                    let msg = String(data: jsonData, encoding: .utf8)
                    
                    
                    let msgID = self.getCurrentTime()
                    
                    self.createMsgEntityFrom(item: Message(
                        msg: text,
                        msgId: msgID,
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
                        is_permission: "0",replyTitle: "", replyMsgType: "", replyMsgId: "", replyMsgFile: "", replyMsg: "", sentTime: kXMPP.SEEN_MSG, seenTime: kXMPP.SEEN_MSG, destructiveTime: ""))
                    
                    self.updateFriendCell(last_msg_time: self.getCurrentTime(), msg: text, msg_type: kXMPP.TYPE_TEXT, isMine: "1", friendID: self.friendModel.contact_number)
                    
                    //self.tblView.reloadData()
                    //self.scrollToBottom()
                    
                    OneMessage.sendMessage(msg!,msgId: msgID,thread: "test", to:"\(friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
                    })
                    
                    
                }catch{
                    
                }
                
            }
            else if item.msg_type == kXMPP.TYPE_IMAGE || item.msg_type == kXMPP.TYPE_PDF {
                
                
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
                    is_permission: "0",replyTitle: "", replyMsgType: "", replyMsgId: "", replyMsgFile: "", replyMsg: "", sentTime: kXMPP.SEEN_MSG, seenTime: kXMPP.SEEN_MSG, destructiveTime: ""))
                
                // self.tblView.reloadData()
                // self.scrollToBottom()
                
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
    
    @objc func swipeGesture(swipeGesture : UISwipeGestureRecognizer) {
        
        let touchPoint = swipeGesture.location(in : self.tblView)
        
        if let indexPath = self.tblView.indexPathForRow(at: touchPoint){
            
            
            let item = self.fetchedhResultController.object(at: indexPath) as? Msg
            
            self.replyView.isHidden = false
            
            self.replyeMessageID = (item?.msg_id)!
            
            
            if item?.is_mine == "1" {
                self.lblReplyTitle.text = "You"
                self.lblReplyTitle.textColor = #colorLiteral(red: 0.1215686275, green: 0.4235294118, blue: 0.7254901961, alpha: 1)
                self.lblReplyColor.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.4235294118, blue: 0.7254901961, alpha: 1)
            }else{
                self.lblReplyTitle.text = self.friendModel.name
                self.lblReplyTitle.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                self.lblReplyColor.backgroundColor =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
            
            if item?.msg_type == kXMPP.TYPE_TEXT {
                
                self.imgReplyFile.isHidden = true
                self.imgReplyType.isHidden = true
                self.lblReplyMsg.text = item?.msg
                
            }else  if item?.msg_type == kXMPP.TYPE_IMAGE {
                
                self.imgReplyFile.isHidden = false
                self.imgReplyType.isHidden = false
                self.lblReplyMsg.text = "Photo"
                
                self.imgReplyType.image = UIImage(named: "image_gray_icon")
                self.imgReplyFile.sd_setImage(with: URL(string: (item?.file_url)!))
                
            }else  if item?.msg_type == kXMPP.TYPE_PDF {
                
                self.imgReplyFile.isHidden = false
                self.imgReplyType.isHidden = false
                self.lblReplyMsg.text = "Pdf"
                
                self.imgReplyType.image = UIImage(named: "pdf_gray_icon")
                self.imgReplyFile.image = UIImage(named: "pdf_place")
                
            }else if item?.msg_type == kXMPP.TYPE_REPLY {
                
                self.imgReplyFile.isHidden = true
                self.imgReplyType.isHidden = true
                self.lblReplyMsg.text = item?.msg
                
            }
            
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
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        let item1 = self.fetchedhResultController.object(at: row) as? Msg
        
        if item1?.msg == kXMPP.DELETE_TEXT_FRIEND ||
            item1?.msg == kXMPP.DELETE_TEXT_MY || item1?.msg == kXMPP.SELF_DESTRUCT_MSG  {
            
            
            let alert:UIAlertController=UIAlertController(title: "cancelKey".localizableString(loc: language!), message: nil, preferredStyle:.actionSheet)
            let deleteAction = UIAlertAction(title: "DeleteKey".localizableString(loc: language!), style: .default) {
                UIAlertAction in
                
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
            
            
            
            let cancelAction = UIAlertAction(title: "cancelKey".localizableString(loc: language!), style: .cancel) {
                UIAlertAction in
                
                self.isMuliselectActionChecked = false
                self.toolbar.isHidden = false
                self.actionView.isHidden = true
                if self.selectedArr.count > 0 {
                    self.selectedArr.removeAll()
                }
                
            }
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            
            let alert:UIAlertController=UIAlertController(title: "ChooseoptionKey".localizableString(loc: language!), message: nil, preferredStyle:.actionSheet)
            let replyAction = UIAlertAction(title: "ReplyKey".localizableString(loc: language!), style: .default) {
                UIAlertAction in
                // self.openCamera(UIImagePickerController.SourceType.camera)
                let item = self.fetchedhResultController.object(at: row) as? Msg
                
                self.replyView.isHidden = false
                
                self.replyeMessageID = (item?.msg_id)!
                
                
                if item?.is_mine == "1" {
                    self.lblReplyTitle.text = "You"
                    self.lblReplyTitle.textColor = #colorLiteral(red: 0.1215686275, green: 0.4235294118, blue: 0.7254901961, alpha: 1)
                    self.lblReplyColor.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.4235294118, blue: 0.7254901961, alpha: 1)
                }else{
                    self.lblReplyTitle.text = self.friendModel.name
                    self.lblReplyTitle.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    self.lblReplyColor.backgroundColor =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                }
                
                if item?.msg_type == kXMPP.TYPE_TEXT {
                    
                    self.imgReplyFile.isHidden = true
                    self.imgReplyType.isHidden = true
                    self.lblReplyMsg.text = item?.msg
                    
                }else  if item?.msg_type == kXMPP.TYPE_IMAGE {
                    
                    self.imgReplyFile.isHidden = false
                    self.imgReplyType.isHidden = false
                    self.lblReplyMsg.text = "Photo"
                    
                    self.imgReplyType.image = UIImage(named: "image_gray_icon")
                    self.imgReplyFile.sd_setImage(with: URL(string: (item?.file_url)!))
                    
                }else  if item?.msg_type == kXMPP.TYPE_PDF {
                    
                    self.imgReplyFile.isHidden = false
                    self.imgReplyType.isHidden = false
                    self.lblReplyMsg.text = "Pdf"
                    
                    self.imgReplyType.image = UIImage(named: "pdf_gray_icon")
                    self.imgReplyFile.image = UIImage(named: "pdf_place")
                    
                }else if item?.msg_type == kXMPP.TYPE_REPLY {
                    
                    self.imgReplyFile.isHidden = true
                    self.imgReplyType.isHidden = true
                    self.lblReplyMsg.text = item?.msg
                    
                }
                
                
                
                // No multi Select
            }
            let forwardAction = UIAlertAction(title: "ForwardKey".localizableString(loc: language!), style: .default) {
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
            
            let copyAction = UIAlertAction(title: "CopyKey".localizableString(loc: language!), style: .default) {
                UIAlertAction in
                //  self.openCamera(UIImagePickerController.SourceType.photoLibrary)
                
                // NO multiselect
                
                let item = self.fetchedhResultController.object(at: row) as? Msg
                if item?.msg_type == kXMPP.TYPE_TEXT {
                    UIPasteboard.general.string = item?.msg
                }
                
                
                
            }
            
            let deleteAction = UIAlertAction(title: "DeleteKey".localizableString(loc: language!), style: .default) {
                UIAlertAction in
                
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
            
            let item = self.fetchedhResultController.object(at: row) as? Msg
            
            if item?.is_mine == "1" {
                
                let infoAction = UIAlertAction(title: "InfoKey".localizableString(loc: language!), style: .default) {
                    UIAlertAction in
                    
                    self.infoDisplay(row: row)
                }
                alert.addAction(infoAction)
                
                
            }
            
            
            
            let cancelAction = UIAlertAction(title: "cancelKey".localizableString(loc: language!), style: .cancel) {
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
        
    }
    
    private func infoDisplay(row : IndexPath){
        let item = self.fetchedhResultController.object(at: row) as? Msg
        
        var sentTime = ""
        var seenTime = ""
        
        
        if item?.sent_time == kXMPP.SEEN_MSG {
            sentTime = kXMPP.SEEN_MSG
        }else{
            sentTime = Utils.getDateTimeFromString(date :(item?.sent_time)!)
        }
        
        if item?.seen_time == kXMPP.SEEN_MSG {
            seenTime = kXMPP.SEEN_MSG
        }else{
            seenTime =  Utils.getDateTimeFromString(date :(item?.seen_time)!)
        }
    
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        
        let alert:UIAlertController=UIAlertController(title: "MessageDetailsKey".localizableString(loc: language!), message: nil, preferredStyle:.actionSheet)
        
        let forwardAction = UIAlertAction(title: "\("DeliveredKey".localizableString(loc: language!)) (\(sentTime))", style: .default) {
            UIAlertAction in
        }
        
        let copyAction = UIAlertAction(title:" \("ReadKey".localizableString(loc: language!)) (\(seenTime))", style: .default) {
            UIAlertAction in
        }
        
        let cancelAction = UIAlertAction(title: "cancelKey".localizableString(loc: language!), style: .cancel) {
            UIAlertAction in
        }
        
        alert.addAction(forwardAction)
        alert.addAction(copyAction)
        
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func getFriendStatus(){
        
        OneLastActivity.sendLastActivityQueryToJID(("\(self.friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal"), sender: OneChat.sharedInstance.xmppLastActivity) { (response, forJID, error) -> Void in
            
            if response != nil {
                
                let lastActivityResponse = OneLastActivity.sharedInstance.getLastActivityFrom((response?.lastActivitySeconds())!)
                
                self.lblCurrentStatus.text = lastActivityResponse
                
                if self.lblCurrentStatus.text == "last seen on "{
                    self.lblCurrentStatus.text = "last seen never been online"
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.isKeyEditing = false
        self.isImageApiCalled = 0

        self.getFriendStatus()
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (timer) in
            
            
            self.getFriendStatus()
            
            if self.isDestructiveMsg(friendID: self.friendModel.contact_number){
                self.updateDestructiveMsg(friendID: self.friendModel.contact_number)
            }
            
            
        })
        
        self.myProfileImage.sd_setImage(with : URL(string: self.friendModel.profile_image))
        self.myProfileImage.layer.cornerRadius = (self.myProfileImage.frame.width) / 2
        self.myProfileImage.clipsToBounds = true
        self.myProfileImage.contentMode = .scaleToFill
        
        
        self.viewHeight = self.bottomView.frame.origin.y
        self.replyHeight = self.replyView.frame.origin.y
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func send_msg_clicked(_ sender: UIButton) {
        
        if self.editMsg.text?.count == 0 {
            return
        }
        self.replyView.isHidden = true
        self.sendTextMsg(text: self.editMsg.text!)
        
        
    }
    
    func sendSeenMsgAck(){
        
        do{
            
            let body = CustomMessageModel(msgId: "", msgType: kXMPP.TYPE_SEEN, message: "", fileUrl: "", destructiveTime: "",fileType : "",filePermission:"")
            
            let jsonData = try JSONEncoder().encode(body)
            let msg = String(data: jsonData, encoding: .utf8)
            
            print(msg)
            
            OneMessage.sendMessage(msg!, msgId:self.getCurrentTime(),  thread: "test", to:"\(friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
            })
            
            
        }catch {print(error)}
        
    }
    
    func sendTextMsg(text : String){
        
        do{
            
            
            
            var desrc = ""
            
            if self.type == "destructive" {
                
                self.type = ""
                desrc = kXMPP.DESTRUCT_TIME
            }else{
                
                desrc = ""
            }
            
            var replyMsgId = ""
            var msgType = kXMPP.TYPE_TEXT
            
            var replyMsgType = ""
            var replyMsgFile = ""
            var replyMsg = ""
            var replyTitle = ""
            
            if self.replyeMessageID != "" {
                
                replyMsgId = self.replyeMessageID
                msgType = kXMPP.TYPE_REPLY
                
                let msgItem = self.getMsg(msgId: replyMsgId)
                
                replyMsg = self.lblReplyMsg.text!
                replyMsgFile = msgItem.file_url
                
                if msgItem.is_mine == "1" {
                    replyTitle = "You"
                }else{
                    replyTitle = self.friendModel.name
                }
                
                replyMsgType = msgItem.msg_type
                
                
            }
            
            
            let body = CustomMessageModel(msgId: replyMsgId, msgType: msgType, message: text, fileUrl: "", destructiveTime: desrc,fileType : "",filePermission:"")
            
            let jsonData = try JSONEncoder().encode(body)
            let msg = String(data: jsonData, encoding: .utf8)
            
            print(msg ?? "")
            
            //self.editMsg.resignFirstResponder()
            self.editMsg.text = ""
            
            let msgID = self.getCurrentTime()
            
            self.createMsgEntityFrom(item: Message(
                msg: text,
                msgId: msgID,
                msgType: msgType,
                msgACk: kXMPP.msgSend,
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
                is_permission: "0", replyTitle: replyTitle, replyMsgType: replyMsgType, replyMsgId: self.replyeMessageID, replyMsgFile: replyMsgFile, replyMsg : replyMsg, sentTime: kXMPP.SEEN_MSG, seenTime: kXMPP.SEEN_MSG, destructiveTime: desrc))
            
            self.updateFriendCell(last_msg_time: self.getCurrentTime(), msg: text, msg_type: kXMPP.TYPE_TEXT, isMine: "1", friendID: self.friendModel.contact_number)
            
            
            
            self.replyeMessageID = ""
            
            OneMessage.sendMessage(msg!, msgId:msgID,  thread: "test", to:"\(friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
            })
            
            
            if self.lblCurrentStatus.text != "Online"  {
                
                let params = ["friend_no": "\(self.friendModel.contact_number)","my_no":"\(USERDETAILS.mobile)", "data":"\(text)", "message_id":"\(msgID)","body":"\(text)"]
                print(params)
                MakeHttpPostRequestChat(url: kXMPP.sendNotification, params: params, completion: {(success, response) in
                    print(response)
                    
                }, errorHandler: {(message) -> Void in
                    print("message", message)
                })
                
            }
            
        }
        catch {print(error)}
        
        
        
    }
    
    
    @IBAction func back_btn_clicked(_ sender: Any) {
        
        self.type = ""
        self.isMuliselectActionChecked = false
        self.toolbar.isHidden = false
        self.actionView.isHidden = true
        if self.selectedArr.count > 0 {
            self.selectedArr.removeAll()
        }
        UserDefaults.standard.set("", forKey: "chatNo")
        
        self.updateReadCount()
        //OneMessage.sharedInstance.delegate = nil
        
        
        let startVC = self.storyboard?.instantiateViewController(withIdentifier: "FriendListVC") as! FriendListVC
        self.present(startVC, animated: true, completion: nil)
        
        
       // dismiss(animated: false, completion: nil)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        // let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MsgCell
        
        if let item = fetchedhResultController.object(at: indexPath) as? Msg {
            //cell.setMsgCellWith(item: item)
            
            var isMyProfileShow = true
            var isDateShow = true
            
            if indexPath.row  - 1 >= 0 {
                
                let prevPath = IndexPath(row: indexPath.row - 1, section: 0)
                
                if let prevItem = fetchedhResultController.object(at: prevPath) as? Msg {
                    if item.is_mine == prevItem.is_mine {
                        isMyProfileShow = false
                    }else{
                        isMyProfileShow = true
                    }
                    
                }
                
                
                // let prevPath = IndexPath(row: indexPath.row - 1, section: 0)
                if let prevItem = fetchedhResultController.object(at: prevPath) as? Msg {
                    
                    if Utils.getMsgDate(date: item.created!) == Utils.getMsgDate(date: prevItem.created!) {
                        
                        isDateShow = false
                        
                    }else{
                        isDateShow = true
                    }
                }
                
                
                
            }
            
            if item.is_mine == "1" {
                
                if item.msg_type == kXMPP.TYPE_REPLY {
                    
                    print(item)
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myTextReplyCell", for: indexPath) as! myTextReplyCell
                    // cell.item = item
                    cell.lblMsg?.numberOfLines = 0
                    cell.lblMsg?.text = item.msg
                    cell.lblMsg?.frame.size = (cell.lblMsg?.intrinsicContentSize)!
                    
                    cell.replyTitle?.text = "You"
                    
                    if item.replyMsgType == kXMPP.TYPE_TEXT {
                        cell.lblreplyMsg?.text = item.replyMsg
                    }else if item.replyMsgType == kXMPP.TYPE_IMAGE {
                        cell.lblreplyMsg?.text = "Photo"
                        cell.replyFile.sd_setImage(with: URL(string: item.replyMsgFile))
                    }
                    else if item.replyMsgType == kXMPP.TYPE_PDF {
                        cell.lblreplyMsg?.text = "Pdf"
                    }else  if item.replyMsgType == kXMPP.TYPE_REPLY {
                        cell.lblreplyMsg?.text = item.replyMsg
                    }
                    
                    
                    
                    cell.lbltime?.text  = Utils.getTimeFromString(date: item.created!)
                    cell.lbltime?.frame.size = (cell.lbltime?.intrinsicContentSize)!
                    
                    if item.msg_ack == kXMPP.msgSend{
                        
                        cell.imgAck.image = UIImage(named: "send_gray_icon")
                        
                    }else  if item.msg_ack == kXMPP.msgSent{
                        
                        cell.imgAck.image = UIImage(named: "receive_gray_icon")
                        
                    }else  if item.msg_ack == kXMPP.msgSeen{
                        
                        cell.imgAck.image = UIImage(named: "read_blue_icon")
                        
                    }
                    
                    
                    if isMyProfileShow == true {
                        
                        cell.imgProfile?.isHidden = false
                        
                    }else{
                        cell.imgProfile?.isHidden = true
                        
                    }
                    
                    cell.imgProfile?.sd_setImage(with : URL(string: USERDETAILS.imageurl))
                    cell.imgProfile?.layer.cornerRadius = (cell.imgProfile?.frame.width)! / 2
                    cell.imgProfile?.clipsToBounds = true
                    cell.imgProfile?.contentMode = .scaleToFill
                    
                    
                    
                    cell.replyView?.layer.cornerRadius = 6
                    cell.replyView?.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.4941176471, blue: 0.8156862745, alpha: 1)
                    cell.replyView?.layer.borderWidth = 1
                    
                    
                    if item.distructive_time == kXMPP.DESTRUCT_TIME || item.msg == kXMPP.SELF_DESTRUCT_MSG {
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.862745098, blue: 0.8705882353, alpha: 1)
                        
                    }else{
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.4941176471, blue: 0.8156862745, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
                        
                    }
                    
                    cell.lbDat?.isHidden = true

                    
                    if self.selectedArr.contains(item){
                        
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                        
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryType.none
                        
                    }
                    
                    return cell
                    
                }else if item.msg_type == kXMPP.TYPE_TEXT {
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MyTextMsgCell", for: indexPath) as! MyTextMsgCell
                    
                    cell.lblMsg?.numberOfLines = 0
                    cell.lblMsg?.text = " "+item.msg+" "
                    
                    if item.msg == kXMPP.DELETE_TEXT_MY ||
                        item.msg == kXMPP.DELETE_TEXT_FRIEND {
                        
                        cell.imgAck?.isHidden = true
                        
                    }else{
                        
                        cell.imgAck?.isHidden = false
                        
                    }
                    
                    
                    cell.lblTime?.text  = Utils.getTimeFromString(date: item.created!)
                    if item.msg_ack == kXMPP.msgSend{
                        cell.imgAck.image = UIImage(named: "send_gray_icon")
                    }else  if item.msg_ack == kXMPP.msgSent{
                        cell.imgAck.image = UIImage(named: "receive_gray_icon")
                    }else  if item.msg_ack == kXMPP.msgSeen{
                        cell.imgAck.image = UIImage(named: "read_blue_icon")
                    }
                    
                    
                    if isMyProfileShow == true {
                        
                        cell.profileImga?.isHidden = false
                        
                    }else{
                        cell.profileImga?.isHidden = true
                        
                    }
                    
                    cell.lblDate?.isHidden = true
                    
                    if isDateShow == true {
                        // cell.lblDate?.isHidden = false
                        //cell.lblDate.frame.size.height = 30
                        //cell.lblDate.layer.cornerRadius = 10
                        
                        
                        cell.lblDate?.text = Utils.getMsgDate(date: item.created!)
                        
                    }else{
                        // cell.lblDate?.isHidden = true
                        // cell.lblDate.frame.size.height = 0
                        cell.lblDate?.text = ""
                        
                    }
                    
                    cell.profileImga?.sd_setImage(with : URL(string: USERDETAILS.imageurl))
                    cell.profileImga?.layer.cornerRadius = (cell.profileImga?.frame.width)! / 2
                    cell.profileImga?.clipsToBounds = true
                    cell.profileImga?.contentMode = .scaleToFill
                    
                    
                    
                    if item.distructive_time == kXMPP.DESTRUCT_TIME || item.msg == kXMPP.SELF_DESTRUCT_MSG {
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.862745098, blue: 0.8705882353, alpha: 1)
                        
                    }else{
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.4941176471, blue: 0.8156862745, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
                        
                    }
                    
                    
                    
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
                    
                    if item.msg_ack == kXMPP.msgSend{
                        
                        cell.msgAck.image = UIImage(named: "send_gray_icon")
                        cell.msgAck.isHidden = false
                        
                    }else  if item.msg_ack == kXMPP.msgSent{
                        
                        cell.msgAck.image = UIImage(named: "receive_gray_icon")
                        cell.msgAck.isHidden = false
                        
                    }else  if item.msg_ack == kXMPP.msgSeen{
                        
                        cell.msgAck.image = UIImage(named: "read_blue_icon")
                        cell.msgAck.isHidden = false
                        
                    }else {
                        
                        cell.msgAck.isHidden = true
                    }
                    
                    if isMyProfileShow == true {
                        
                        cell.profileImage?.isHidden = false
                        
                    }else{
                        cell.profileImage?.isHidden = true
                        
                    }
                    
                    cell.profileImage?.sd_setImage(with : URL(string: USERDETAILS.imageurl))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                    cell.fileview?.sd_setImage(with : URL(string: item.file_url))
                    cell.fileview?.contentMode = .scaleAspectFill
                    cell.fileview?.clipsToBounds = true
                    
                    
                    if item.distructive_time == kXMPP.DESTRUCT_TIME || item.msg == kXMPP.SELF_DESTRUCT_MSG {
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.862745098, blue: 0.8705882353, alpha: 1)
                        
                    }else{
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.4941176471, blue: 0.8156862745, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
                        
                    }
                    
                    
                    
                    
                    if item.is_download == "0" {
                        
                        cell.progressView.isHidden = false
                        cell.progressView.startAnimating()
                        
                        
                        if item.is_streaming == "0" {
                            
                            cell.btnUpload.isHidden = true
                            cell.progressView.stopAnimating()
                            
                            
                            
                            SDWebImageManager.shared().imageDownloader?.downloadImage(with:  URL(string: item.file_url), options: .continueInBackground, progress: nil, completed: {(image : UIImage?,data:Data?,error:Error?,finished:Bool)
                                in
                                
                                if image != nil {
                                    
                                    self.updateMsg(msg_id: item.msg_id, type : "streaming" ,value: "1")
                                    
                                    self.uploadImageToServer(image: image!, msgId: item.msg_id, type: item.msg_type, fileURL: "", permission: item.is_permission)
                                    
                                }
                                
                            })
                            
                            
                        }else if item.is_streaming == "3" {
                            
                            
                            cell.progressView.isHidden = true
                            cell.progressView.stopAnimating()
                            cell.btnUpload.isHidden = false
                            
                        }
                        
                    }else{
                        cell.progressView.isHidden = true
                        cell.progressView.stopAnimating()
                        
                        if item.is_permission == "1" {
                            
                            cell.btnUpload.isHidden = false
                            // show lock
                            
                            cell.btnUpload.image = UIImage(named: "per_lock")

                        }else if item.is_permission == "3" {
                            
                            cell.btnUpload.isHidden = false
                            // show lock
                            
                            cell.btnUpload.image = UIImage(named: "per_grant")
                            
                        }else{
                            
                            cell.btnUpload.isHidden = true

                        }
                        
                        
                    }
                    
                     cell.lblDate?.isHidden = true
                  
                    
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
                    
                    
                    if item.msg_ack == kXMPP.msgSend{
                        
                        cell.msgAck.image = UIImage(named: "send_gray_icon")
                        
                    }else  if item.msg_ack == kXMPP.msgSent{
                        
                        cell.msgAck.image = UIImage(named: "receive_gray_icon")
                        
                        
                    }else  if item.msg_ack == kXMPP.msgSeen{
                        
                        cell.msgAck.image = UIImage(named: "read_blue_icon")
                        
                    }
                    
                    
                    if item.distructive_time == kXMPP.DESTRUCT_TIME || item.msg == kXMPP.SELF_DESTRUCT_MSG {
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.862745098, blue: 0.8705882353, alpha: 1)
                        
                    }else{
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.4941176471, blue: 0.8156862745, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
                        
                    }
                    
                    
                    if isMyProfileShow == true {
                        
                        cell.profileImage?.isHidden = false
                        
                    }else{
                        cell.profileImage?.isHidden = true
                        
                    }
                    
                    cell.profileImage?.sd_setImage(with : URL(string: USERDETAILS.imageurl))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                    cell.fileview?.image = UIImage(named: "pdf_place")
                    cell.fileview?.contentMode = .scaleAspectFill
                    cell.fileview?.clipsToBounds = true
                    
                    if item.is_download == "0" {
                        
                        cell.progressView.isHidden = false
                        cell.progressView.startAnimating()
                        
                        
                        if item.is_streaming == "0" {
                            
                            cell.btnUpload.isHidden = true
                            cell.progressView.stopAnimating()
                            
                            DispatchQueue.global(qos : .background).async {
                                
                                DispatchQueue.main.async {
                                    
                                    
                                    self.updateMsg(msg_id: item.msg_id, type : "streaming" ,value: "1")
                                    
                                    self.uploadImageToServer(image: UIImage(), msgId: item.msg_id, type: item.msg_type, fileURL: item.file_url, permission: item.is_permission)
                                    
                                    
                                    
                                }
                                
                            }
                            
                            
                        }else if item.is_streaming == "3" {
                            
                            cell.progressView.isHidden = true
                            cell.progressView.stopAnimating()
                            cell.btnUpload.isHidden = false
                            
                        }else{
                            
                            
                            if item.msg_ack == kXMPP.msgFail {
                                
                                
                            }else{
                                
                                //  cell.btnUpload.isHidden = false
                                //  cell.progressView.isHidden = true
                            }
                            
                            
                            
                        }
                        
                    }else{
                        cell.progressView.isHidden = true
                        cell.progressView.stopAnimating()
                        
                        if item.is_permission == "1" {
                            
                            cell.btnUpload.isHidden = false
                            // show lock
                            
                            cell.btnUpload.image = UIImage(named: "per_lock")
                            
                        }else if item.is_permission == "3" {
                            
                            cell.btnUpload.isHidden = false
                            // show lock
                            
                            cell.btnUpload.image = UIImage(named: "per_grant")
                            
                        }else{
                            
                            cell.btnUpload.isHidden = true
                            
                        }
                        
                    }
                    
                     cell.lblDate?.isHidden = true
                    
                    
                    if self.selectedArr.contains(item){
                        
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryType.none
                        
                    }
                    
                    return cell
                    
                    
                }
                
                
                
                
            }else {
                
                if item.msg_type == kXMPP.TYPE_REPLY {
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTextReplyCell", for: indexPath) as! FriendTextReplyCell
                    // cell.item = item
                    cell.msg?.numberOfLines = 0
                    cell.msg?.text = item.msg
                    cell.msg?.frame.size = (cell.msg?.intrinsicContentSize)!
                    
                    cell.replyTitle?.text = self.friendModel.name
                    
                    if item.replyMsgType == kXMPP.TYPE_TEXT {
                        cell.replyMsg?.text = item.replyMsg
                    }else if item.replyMsgType == kXMPP.TYPE_IMAGE {
                        cell.replyMsg?.text = "Photo"
                        cell.replyFile.sd_setImage(with: URL(string: item.replyMsgFile))
                    }
                    else if item.replyMsgType == kXMPP.TYPE_PDF {
                        cell.replyMsg?.text = "Pdf"
                    }
                    
                    cell.msgTime?.text  = Utils.getTimeFromString(date: item.created!)
                    cell.msgTime?.frame.size = (cell.msgTime?.intrinsicContentSize)!
                    
                    if isMyProfileShow == true {
                        
                        cell.profileImage?.isHidden = false
                        
                    }else{
                        cell.profileImage?.isHidden = true
                        
                    }
                    
                    cell.profileImage?.sd_setImage(with : URL(string: self.friendModel.profile_image))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                    
                    
                    cell.replyView?.layer.cornerRadius = 2
                    cell.replyView?.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    cell.replyView?.layer.borderWidth = 1
                    
                    
                    
                    if item.distructive_time == kXMPP.DESTRUCT_TIME || item.msg == kXMPP.SELF_DESTRUCT_MSG {
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.862745098, blue: 0.8705882353, alpha: 1)
                        
                    }else{
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        
                    }
                    
                     cell.lblDate?.isHidden = true
                    
                    
                    if self.selectedArr.contains(item){
                        
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                        
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryType.none
                        
                    }
                    
                    return cell
                    
                }else if item.msg_type == kXMPP.TYPE_TEXT {
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTextMsgCell", for: indexPath) as! FriendTextMsgCell
                    //cell.item = item
                    
                    cell.lblMsg?.text = item.msg
                    cell.lblTime?.text  = Utils.getTimeFromString(date: item.created!)
                    
                    if item.msg == kXMPP.DELETE_TEXT_MY ||
                        item.msg == kXMPP.DELETE_TEXT_FRIEND {
                        cell.lblTime?.isHidden = true
                    }else{
                        cell.lblTime?.isHidden = false
                    }
                    
                    
                    if isMyProfileShow == true {
                        
                        cell.profileImage?.isHidden = false
                        
                    }else{
                        cell.profileImage?.isHidden = true
                        
                    }
                    
                    
                    if isDateShow == true {
                        // cell.lblDate?.isHidden = false
                        cell.lblDate?.text = Utils.getMsgDate(date: item.created!)
                    }else{
                        //cell.lblDate?.isHidden = true
                        cell.lblDate?.text = ""
                    }
                    
                    cell.profileImage?.sd_setImage(with : URL(string: self.friendModel.profile_image))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                    
                    
                    
                    if item.distructive_time == kXMPP.DESTRUCT_TIME || item.msg == kXMPP.SELF_DESTRUCT_MSG {
                        
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.862745098, blue: 0.8705882353, alpha: 1)
                        
                    }else{
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        
                    }
                    
                     cell.lblDate?.isHidden = true
                    
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
                    
                    if isMyProfileShow == true {
                        cell.profileImage.isHidden = false
                    }else{
                        cell.profileImage.isHidden = true
                    }
                    
                    cell.profileImage?.sd_setImage(with : URL(string: self.friendModel.profile_image))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                    cell.fileView.alpha = 0.8
                    cell.fileView?.sd_setImage(with : URL(string: item.file_url))
                    cell.fileView?.contentMode = .scaleAspectFill
                    cell.fileView?.clipsToBounds = true
                    
                    if item.distructive_time == kXMPP.DESTRUCT_TIME || item.msg == kXMPP.SELF_DESTRUCT_MSG {
                        
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.862745098, blue: 0.8705882353, alpha: 1)
                        
                    }else{
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        
                    }
                    
                    
                    
                    if item.is_permission == "1" {
                        
                        cell.btnDownload.isHidden = false
                        cell.btnDownload.image = UIImage(named: "per_lock")
                        cell.progressView.isHidden = true
                        
                        cell.fileView?.sd_setImage(with: URL(string: item.file_url), placeholderImage: UIImage(named: "image_placeholder"), options: .continueInBackground, progress: nil, completed: nil)
                        cell.fileView?.contentMode = .scaleAspectFill
                        cell.fileView?.clipsToBounds = true
                        
                        let blureffect = UIBlurEffect(style: UIBlurEffectStyle
                            .regular)
                        let blueeffectView = UIVisualEffectView(effect: blureffect)
                        blueeffectView.frame = (cell.fileView?.bounds)!
                        blueeffectView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
                        cell.fileView?.addSubview(blueeffectView)
                        
                    }else {
                        
                        // cell.progressView.isHidden = true
                        
                        if item.distructive_time == kXMPP.DESTRUCT_TIME {
                            
                            cell.btnDownload.isHidden = true
                            cell.progressView.isHidden = true
                            
                            cell.fileView?.sd_setImage(with: URL(string: item.file_url), placeholderImage: UIImage(named: "image_placeholder"), options: .continueInBackground, progress: nil, completed: nil)
                            cell.fileView?.contentMode = .scaleAspectFill
                            cell.fileView?.clipsToBounds = true
                        
                        
                        }else if item.is_download == "0" {
                            
                            
                            if item.is_streaming == "1" {
                                
                                cell.btnDownload.isHidden = true
                                cell.progressView.isHidden = false
                                
                            }else{
                                
                                cell.btnDownload.isHidden = false
                                cell.progressView.isHidden = true
                                
                            }
                            
                            
                            cell.fileView?.sd_setImage(with: URL(string: item.file_url), placeholderImage: UIImage(named: "image_placeholder"), options: .continueInBackground, progress: nil, completed: nil)
                            cell.fileView?.contentMode = .scaleAspectFill
                            cell.fileView?.clipsToBounds = true
                            
                            let blureffect = UIBlurEffect(style: UIBlurEffectStyle
                                .regular)
                            let blueeffectView = UIVisualEffectView(effect: blureffect)
                            blueeffectView.frame = (cell.fileView?.bounds)!
                            blueeffectView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
                            cell.fileView?.addSubview(blueeffectView)
                            
                        }else{
                            
                            
                            cell.btnDownload.isHidden = true
                            cell.progressView.isHidden = true
                            
                            
                            cell.fileView?.sd_setImage(with: URL(string: item.file_url), placeholderImage: UIImage(named: "image_placeholder"), options: .continueInBackground, progress: nil, completed: nil)
                            cell.fileView?.contentMode = .scaleAspectFill
                            cell.fileView?.clipsToBounds = true
                            
                        }
                        
                    }
                    
                     cell.lblDate?.isHidden = true
                    
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
                    
                    if isMyProfileShow == true {
                        cell.profileImage?.isHidden = false
                    }else{
                        cell.profileImage?.isHidden = true
                    }
                    
                    cell.profileImage?.sd_setImage(with : URL(string: self.friendModel.profile_image))
                    cell.profileImage?.layer.cornerRadius = (cell.profileImage?.frame.width)! / 2
                    cell.profileImage?.clipsToBounds = true
                    cell.profileImage?.contentMode = .scaleToFill
                    
                    if item.distructive_time == kXMPP.DESTRUCT_TIME || item.msg == kXMPP.SELF_DESTRUCT_MSG {
                        
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.862745098, blue: 0.8705882353, alpha: 1)
                        
                    }else{
                        
                        cell.mainView?.layer.cornerRadius = 6
                        cell.mainView?.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.mainView?.layer.borderWidth = 1
                        cell.mainView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        
                    }
                    
                    
                    
                    
                    
                    if item.is_permission == "1" {
                        
                        cell.btnDownload.isHidden = false
                        cell.btnDownload.image = UIImage(named: "per_lock")
                        
                        cell.progressView.isHidden = true
                        
                        cell.fileView?.image = UIImage(named: "pdf_place")
                        cell.fileView?.contentMode = .scaleAspectFill
                        cell.fileView?.clipsToBounds = true
                        cell.progressView.isHidden = true
                        
                        
                    }else {
                        
                        if item.distructive_time == kXMPP.DESTRUCT_TIME {
                            
                            cell.fileView?.image = UIImage(named: "pdf_place")
                            cell.fileView?.contentMode = .scaleAspectFill
                            cell.fileView?.clipsToBounds = true
                            cell.progressView.isHidden = true
                            
                            
                        }else if item.is_download == "0" {
                            
                            
                            if item.is_streaming == "1" {
                                cell.btnDownload.isHidden = true
                                cell.progressView.isHidden = false
                            }else{
                                cell.btnDownload.isHidden = false
                                cell.progressView.isHidden = true
                            }
                            
                            cell.fileView?.image = UIImage(named: "pdf_place")
                            cell.fileView?.contentMode = .scaleAspectFill
                            cell.fileView?.clipsToBounds = true
                            cell.progressView.isHidden = true
                            
                        }else{
                            
                            
                            cell.btnDownload.isHidden = true
                            cell.progressView.isHidden = true
                            
                            
                            cell.fileView?.image = UIImage(named: "pdf_place")
                            cell.fileView?.contentMode = .scaleAspectFill
                            cell.fileView?.clipsToBounds = true
                            
                        }
                        
                    }
                    
                     cell.lblDate?.isHidden = true
                    
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
                
                return CGFloat(230)
                
            }else if item.msg_type == kXMPP.TYPE_PDF   {
                
                return CGFloat(230)
                
            }else if item.msg_type == kXMPP.TYPE_REPLY   {
                
                 return UITableViewAutomaticDimension
                
            }
        }
        
        
        return UITableViewAutomaticDimension
    }
    
    private func permissionPopup(item: Msg,type:String,msg:String){
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        var msg1 = ""
        var title = ""
        if type == kXMPP.TYPE_PER_GRANT {
            msg1 = ""
            title = "GrantPermissionKey".localizableString(loc: language!)
        }else{
            msg1 = msg
            title = "RequestPermissionKey".localizableString(loc: language!)
        }
        
        let alertView = UIAlertController(title: "SecuredMessageKey".localizableString(loc: language! ), message: msg1, preferredStyle: .alert)
        let action = UIAlertAction(title: "NotNowKey".localizableString(loc: language!), style: .default, handler: { (alert) in
        })
        alertView.addAction(action)
        
        let actionSure = UIAlertAction(title: title, style: .default, handler: { (alert) in
            
            self.sendNotify(item: item,type:type)
            
        })
        alertView.addAction(actionSure)
        self.present(alertView, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = fetchedhResultController.object(at: indexPath) as? Msg
        
        print(item!)
        
        if self.isMuliselectActionChecked == true{
            
            self.selectedArr.append(item!)
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            
            
            if item?.msg_type == kXMPP.TYPE_REPLY && item?.is_permission == "1" {
                
                self.permissionPopup(item: item!,type:kXMPP.TYPE_PER_GRANT,msg: "Grant permission")
                tableView.deselectRow(at: indexPath, animated: false)
                
            }
            
            
            if item?.msg_type == kXMPP.TYPE_IMAGE || item?.msg_type == kXMPP.TYPE_PDF {
                
                
                if item?.is_mine == "1"{
                    
                    if item?.is_download == "0" {
                        
                        // upload file
                        
                    }else if item?.is_streaming == "3"{
                        
                        // again upload file
                        
                    }else{
                        
                        self.showFile(fileURL: (item?.file_url)!)
                        tableView.deselectRow(at: indexPath, animated: false)
                        
                    }
                    
                }else{
                    
                    
                    if item?.is_permission == "1"{
                        
                        self.permissionPopup(item: item!,type:kXMPP.TYPE_PER_ASK,msg: "This message requires permission from \(self.friendModel.name)")
                        tableView.deselectRow(at: indexPath, animated: false)
                        
                        
                    }else if item?.is_streaming == "3"{
                        
                        // download
                        
                        
                        if item?.msg_type == kXMPP.TYPE_IMAGE {
                            
                            
                            if item?.distructive_time == kXMPP.DESTRUCT_TIME {
                                
                                self.showFile(fileURL: (item?.file_url)!)

                            }else{

                            
                            SDWebImageManager.shared().imageDownloader?.downloadImage(with:  URL(string: (item?.file_url)!), options: .continueInBackground, progress: nil, completed: {(image : UIImage?,data:Data?,error:Error?,finished:Bool)
                                in
                                
                                if image != nil {
                                    
                                    let localURL  = self.savefiletoDirector(image: image!)
                                    UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
                                    
                                    self.updateMsg(msg_id: (item?.msg_id)!, type : "download" ,value: "1")
                                    self.updateMsg(msg_id: (item?.msg_id)!, type : "file" ,value: localURL)
                                }
                                
                            })
                                
                            }
                            
                            
                            
                        }else if item?.msg_type == kXMPP.TYPE_PDF {
                            
                            
                            if item?.distructive_time == kXMPP.DESTRUCT_TIME {
                                self.showFile(fileURL: (item?.file_url)!)

                                
                            }else{

                            self.loadPDFAsync(url: (item?.file_url)!, msgid: (item?.msg_id)!)
                            }
                            
                            }
                        
                    }else{
                        
                        if item?.is_download == "0"{
                           

                            if item?.msg_type == kXMPP.TYPE_IMAGE {
                                
                                if item?.distructive_time == kXMPP.DESTRUCT_TIME {
                                    
                                    self.showFile(fileURL: (item?.file_url)!)
                                    
                                    
                                }else{

                                
                                SDWebImageManager.shared().imageDownloader?.downloadImage(with:  URL(string: (item?.file_url)!), options: .continueInBackground, progress: nil, completed: {(image : UIImage?,data:Data?,error:Error?,finished:Bool)
                                    in
                                    
                                    if image != nil {
                                        
                                        let localURL  = self.savefiletoDirector(image: image!)
                                        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
                                        
                                        self.updateMsg(msg_id: (item?.msg_id)!, type : "download" ,value: "1")
                                        self.updateMsg(msg_id: (item?.msg_id)!, type : "file" ,value: localURL)
                                    }
                                    
                                })
                                    
                                }
                            
                          }else if item?.msg_type == kXMPP.TYPE_PDF {
                                
                                
                                if item?.distructive_time == kXMPP.DESTRUCT_TIME {
                                    
                                    self.showFile(fileURL: (item?.file_url)!)

                                    
                                }else{

                                self.loadPDFAsync(url: (item?.file_url)!, msgid: (item?.msg_id)!)
                                    
                                }
                            }
                            
                            
                        }else{
                            
                            self.showFile(fileURL: (item?.file_url)!)
                            tableView.deselectRow(at: indexPath, animated: false)
                            
                        }
                        
                    }
                    
                    
                    
                }
                
                
                
            }
            
        }
        
    }
    
    
    private func showFile(fileURL:String){
        
        
        if fileURL.contains("http") {
     
         
         if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "FileViewerVC") as? FileViewerVC {
            vcNewSectionStarted.fileURL = fileURL
            vcNewSectionStarted.type = "image"
         self.present(vcNewSectionStarted, animated: true, completion: nil)
         }
            
        }else{
            
            let dc = UIDocumentInteractionController(url: URL(string: fileURL)!)
            dc.delegate = self
            dc.presentPreview(animated: true)
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
    
    
    
    private func updateMsgAck(friendID : String){
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "to_id = %@ AND msg_ack != %@", friendID,"2")
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                for item in results {
                    
                    item.setValue("2", forKey: "msg_ack")
                    
                    do{
                        
                        try context.save()
                        
                        
                    }catch{
                        print("Error in update")
                    }
                    
                }
                
                // self.tblView.reloadData()
                // self.scrollToBottom()
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
                }
                
                if type == "permission"{
                    updatObj.setValue(value, forKey: "is_permission")
                }
                
                do{
                    
                    try context.save()
                    
                    
                    
                    //
                    // self.scrollToBottom()
                    
                }catch{
                    print("Error in update")
                }
            }
            
        }catch{
            print("error executing request")
        }
        
    }
    
    
    private func isDestructiveMsg(friendID : String) -> Bool {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "to_id = %@ AND distructive_time != %@", friendID,"")
        
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
    
    private func updateDestructiveMsg(friendID : String) {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "to_id = %@ AND distructive_time != %@", friendID,"")
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                for item in results {
                    
                    let data = item as! Msg
                    
                    let getmsgTime = data.created
                    let upatedData = Utils.getDateTimeToDate(date: getmsgTime!).addingTimeInterval(2.0 * 60.0)
                    
                    if upatedData < Date() {
                        
                        item.setValue(kXMPP.SELF_DESTRUCT_MSG, forKey: "msg")
                        item.setValue("", forKey: "distructive_time")
                        item.setValue(kXMPP.TYPE_TEXT, forKey: "msg_type")
                        
                    }
                    
                    
                }
                
                do{
                    
                    try context.save()
                    // self.reloadData()
                    
                    
                }catch{
                    print("Error in update")
                }
                
                
                
            }
            
            
            
        }catch{
            print("error executing request")
        }
        
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
            print("error executing request")
        }
        
        return results[0] as! Msg
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
            
            // print(item.msgId)
            
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
    
    
    
    
    
    func updateFriendLastMsg(friendID : String ,value : String){
        
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
    
    
    
    func updateFriendCell(last_msg_time : String , msg : String , msg_type :String , isMine : String, friendID : String){
        
        // update friend profile
        
        
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
                updatObj.setValue("0", forKey: "last_msg_ack")
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
    
    
    func updateGrantMsgs(replyID : String){
        
        // update friend profile
        
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
        fetchRequest.predicate = NSPredicate(format: "replyMsgId = %@", replyID)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                
                for r in results {
                    
                    let updatObj = r as! Msg
                    
                    
                    updatObj.setValue("You have granted permission to download this file", forKey: "msg")
                    updatObj.setValue("0", forKey:"is_permission")
                    
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
    
    
    
    /* ***********8 FILE UPLAD API *********/
    
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait
    }
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
    
    func uploadImageToServer(image : UIImage, msgId : String,type:String,fileURL: String,permission:String)
    {
        print(self.isImageApiCalled,"<<<< isImageApiCalled1 >>>>>")
        
        if self.isImageApiCalled == 1 {
            print("<<<<<< API RETURN >>>>>")
            return
        }
    
        self.isImageApiCalled = 1
        
        print(self.isImageApiCalled,"<<<< isImageApiCalled2 >>>>>")

       
        
        
        print("<<<<<< API CALLLINGNGNGNNGNG >>>>>")
      
       
        let myUrl = URL(string: kXMPP.uploadImage);
        
        let request = NSMutableURLRequest(url:myUrl!);
        request.httpMethod = "POST";
        
        let param = [
            "msg_id"  : msgId,
            ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData : Data
        
        if type == kXMPP.TYPE_PDF {
            
            do{
                
                let pdfData = try! Data(contentsOf: URL(string: fileURL)!)
                imageData = pdfData
                
            }catch{
                
            }
            
            
        }else{
            imageData = UIImageJPEGRepresentation(image, 0.0)!
        }
        
        //if(imageData==nil)  { return; }
        
        request.httpBody = self.createBodyWithParameters(parameters: param, filePathKey: "image", imageDataKey: imageData as NSData, boundary: boundary, type:type) as Data
        
        print(request.httpBody!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print(error?.localizedDescription)
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
                            
                           
                            
                            
                            
                            var desrc = ""
                            
                            if self.type == "destructive" {
                                
                                desrc = kXMPP.DESTRUCT_TIME

                            }else{
                                desrc = ""
                            }
                            
                            
                            let body = CustomMessageModel(msgId: json?.object(forKey: "msg_id") as! String , msgType: type, message: "", fileUrl: json?.object(forKey: "data") as! String, destructiveTime: desrc ,fileType : type,filePermission:permission)
                            
                            let jsonData = try JSONEncoder().encode(body)
                            let msg = String(data: jsonData, encoding: .utf8)
                            
                            
                            print(msg ?? "")
                            
                            self.updateMsg(msg_id: msgId, type : "streaming" ,value: "1")
                            self.updateMsg(msg_id: json?.object(forKey: "msg_id") as! String , type : "upload" ,value: "1")
                            
                            OneMessage.sendMessage(msg!,msgId: json?.object(forKey: "msg_id") as! String  ,thread: "test", to:"\(self.friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
                                
                                self.type = ""

                                
                                
                            })
                            
                            
                        }else{
                            
                            self.updateMsg(msg_id: msgId, type : "streaming" ,value: "3")
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
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String,type:String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        var filename = ""
        var mimetype = ""
        
        if type == kXMPP.TYPE_PDF{
            filename = "\(self.getCurrentTime()).pdf"
            mimetype = "pdf"
        }else{
            filename = "\(self.getCurrentTime()).jpg"
            mimetype = "image/jpg"
        }
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name= image; filename=\"\(filename)\"\r\n")
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
        self.scrollToBottom()
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
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        
        if self.selectedArr.count == 1 {
            
            let item1 = self.selectedArr[0]
            
            if item1.msg == kXMPP.DELETE_TEXT_FRIEND ||
                item1.msg == kXMPP.DELETE_TEXT_MY {
                
                for item in self.selectedArr{
                    context.delete(item)
                }
                
                self.isMuliselectActionChecked = false
                self.toolbar.isHidden = false
                self.actionView.isHidden = true
                if self.selectedArr.count > 0 {
                    self.selectedArr.removeAll()
                }
                
            }else{
                
                
                if selectedArr[0].is_mine == "1" {
                    
                    
                    let alert:UIAlertController=UIAlertController(title: "cancelKey".localizableString(loc: language!), message: nil, preferredStyle:.actionSheet)
                    let cameraAction = UIAlertAction(title: "DeleteformeKey".localizableString(loc: language!), style: .default) {
                        UIAlertAction in
                        
                        
                        
                        for item in self.selectedArr{
                            
                            context.delete(item)
                            //print(item.created)
                        }
                        
                        
                        self.isMuliselectActionChecked = false
                        self.toolbar.isHidden = false
                        self.actionView.isHidden = true
                        if self.selectedArr.count > 0 {
                            self.selectedArr.removeAll()
                        }
                        self.tblView.reloadData()
                        
                        
                    }
                    let gallaryAction = UIAlertAction(title: "DeleteforeveryoneKey".localizableString(loc: language!), style: .default) {
                        UIAlertAction in
                        
                        do{
                            
                            let text = kXMPP.DELETE_TEXT_FRIEND
                            let body = CustomMessageModel(msgId: self.selectedArr[0].msg_id, msgType: kXMPP.TYPE_DELETE, message: text, fileUrl:self.selectedArr[0].file_url , destructiveTime : "",fileType : self.selectedArr[0].msg_type,filePermission:"")
                            
                            let jsonData = try JSONEncoder().encode(body)
                            let msg = String(data: jsonData, encoding: .utf8)
                            
                            
                            let msgID = self.getCurrentTime()
                            
                            self.updateMsg(msg_id: self.selectedArr[0].msg_id, type: "delete_type", value: kXMPP.DELETE_TEXT_MY)
                            
                            self.isMuliselectActionChecked = false
                            self.toolbar.isHidden = false
                            self.actionView.isHidden = true
                            if self.selectedArr.count > 0 {
                                self.selectedArr.removeAll()
                            }
                            
                            self.tblView.reloadData()
                            
                            
                            OneMessage.sendMessage(msg!,msgId: msgID,thread: "test", to:"\(self.friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
                                
                                
                                
                                
                                
                            })
                            
                            
                            
                        }catch{
                            
                        }
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    let cancelAction = UIAlertAction(title: "cancelKey".localizableString(loc: language!), style: .cancel) {
                        UIAlertAction in
                        
                        
                        self.isMuliselectActionChecked = false
                        self.toolbar.isHidden = false
                        self.actionView.isHidden = true
                        if self.selectedArr.count > 0 {
                            self.selectedArr.removeAll()
                        }
                    }
                    
                    alert.addAction(cameraAction)
                    alert.addAction(gallaryAction)
                    
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                }else{
                    
                    for item in self.selectedArr{
                        context.delete(item)
                    }
                    
                    self.isMuliselectActionChecked = false
                    self.toolbar.isHidden = false
                    self.actionView.isHidden = true
                    if self.selectedArr.count > 0 {
                        self.selectedArr.removeAll()
                    }
                    
                }
            }
            
        }else{
            
            for item in self.selectedArr{
                
                context.delete(item)
                //print(item.created)
            }
            
            
            self.isMuliselectActionChecked = false
            self.toolbar.isHidden = false
            self.actionView.isHidden = true
            if self.selectedArr.count > 0 {
                self.selectedArr.removeAll()
            }
            
        }
        
        
        //  self.tblView.reloadData()
        
        
    }
    
    /**** Send image    ***/
    
    
    func sendNotify(item: Msg,type:String){
        
        var notificationText = ""
        
        do{
            
            
            if type == kXMPP.TYPE_PER_ASK {
                
                notificationText = "\(USERDETAILS.firstName) \(USERDETAILS.lastname) is asking for your permission to download this file.Click here to grant permission."
                
                self.replyeMessageID = item.msg_id
                
                do{
                    
                    var replyMsgId = ""
                    var msgType = kXMPP.TYPE_TEXT
                    
                    if self.replyeMessageID != "" {
                        replyMsgId = self.replyeMessageID
                        msgType = kXMPP.TYPE_REPLY
                    }
                    
                    
                    let body = CustomMessageModel(msgId: replyMsgId, msgType: msgType, message: "\(USERDETAILS.firstName) \(USERDETAILS.lastname) is asking for your permission to download this file.Click here to grant permission.", fileUrl: "", destructiveTime: "",fileType : "",filePermission:"1")
                    
                    let jsonData = try JSONEncoder().encode(body)
                    let msg = String(data: jsonData, encoding: .utf8)
                    
                    print(msg ?? "")
                    
                    self.editMsg.resignFirstResponder()
                    self.editMsg.text = ""
                    
                    let msgID = self.getCurrentTime()
                    
                    
                    
                    self.replyeMessageID = ""
                    
                    OneMessage.sendMessage(msg!, msgId:msgID,  thread: "test", to:"\(friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
                    })
                    
                    let body1 = CustomMessageModel(msgId: item.msg_id, msgType: kXMPP.TYPE_PER_ASK, message: "", fileUrl: "", destructiveTime: "",fileType:"",filePermission:"0")
                    
                    let jsonData1 = try JSONEncoder().encode(body1)
                    let msg1 = String(data: jsonData1, encoding: .utf8)
                    
                    let params = ["friend_no": "\(self.friendModel.contact_number)","my_no":"\(USERDETAILS.mobile)", "data":"\(msg1!)", "message_id":"\(item.msg_id)","body":notificationText,"type":"0"]
                    print(params)
                    MakeHttpPostRequestChat(url: kXMPP.sendFileNotification, params: params, completion: {(success, response) in
                        print(response)
                        
                    }, errorHandler: {(message) -> Void in
                        print("message", message)
                    })
                    
                }
                catch {print(error)}
                
            } else{
                
                
                /// update msg with text same replyid
                // is permission 0
                
                
                
                notificationText = "Permission granted  to download file"
                
                let body = CustomMessageModel(msgId: item.replyMsgId, msgType: kXMPP.TYPE_PER_GRANT, message: "", fileUrl: "", destructiveTime: "",fileType : "",filePermission:"1")
                
                //1543567377997
                
                let jsonData = try JSONEncoder().encode(body)
                let msg = String(data: jsonData, encoding: .utf8)
                
                print(msg ?? "")
                
                self.editMsg.resignFirstResponder()
                self.editMsg.text = ""
                
                let msgID = self.getCurrentTime()
                
                
                
                OneMessage.sendMessage(msg!, msgId:msgID,  thread: "test", to:"\(friendModel.contact_number)@ip-172-31-9-114.ap-south-1.compute.internal", completionHandler: { (stream, message) -> Void in
                    
                    self.updateGrantMsgs(replyID: item.replyMsgId)
                    self.updateMsg(msg_id: item.replyMsgId, type: "permission", value: "3")
                    
                })
                
                let body1 = CustomMessageModel(msgId: item.msg_id, msgType: kXMPP.TYPE_PER_ASK, message: "", fileUrl: "", destructiveTime: "",fileType:"",filePermission:"0")
                
                let jsonData1 = try JSONEncoder().encode(body1)
                let msg1 = String(data: jsonData1, encoding: .utf8)
                
                let params = ["friend_no": "\(self.friendModel.contact_number)","my_no":"\(USERDETAILS.mobile)", "data":"\(msg1!)", "message_id":"\(item.msg_id)","body":notificationText,"type":"1"]
                print(params)
                MakeHttpPostRequestChat(url: kXMPP.sendFileNotification, params: params, completion: {(success, response) in
                    print(response)
                    
                }, errorHandler: {(message) -> Void in
                    print("message", message)
                })
                
                
                
            }
            
            
            
            
            
        }
        catch {print(error)
            
        }
    }
    
    
    /******* SCroll View ****** */
    
    /* Edit Box Delegate */
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.editMsg.resignFirstResponder()
        self.replyView.isHidden = true
        self.isKeyEditing = false
        
        
        // self.bottomView.unbindToKeyboard()
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
    
    
 /*   @objc func keyboardWillShow(notification: NSNotification) {
        
        
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize.height,"notification: Keyboard will show")
            
            // if self.tblView.frame.origin.y == 0{
            // self.tblView.frame.origin.y -= keyboardSize.height
            //  }
            
            if self.isKeyEditing == false {
                self.isKeyEditing = true
                let count = fetchedhResultController.sections?.first?.numberOfObjects ?? 0
                if count != 0 {
                    let contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height , 0.0)
                    self.tblView.contentInset = contentInset
                    self.scrollToBottom()
                }
                
                
                // self.bottomView.frame.origin.y = self.viewHeight - 40.0
                // self.replyView.frame.origin.y = self.viewHeight - 40.0
                
        
                self.bottomView.frame.origin.y -= keyboardSize.height
                self.replyView.frame.origin.y -= keyboardSize.height
                
                // self.viewHeight = self.bottomView.frame.origin.y
                
                
            }
            
        }
    }
    
    @objc func keyboardType(notification: NSNotification) {
        
               if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                
                print(keyboardSize.height,"<<<< Keyboard SIZE  >>>>>")
                
               }
        
  
        
        if self.isKeyEditing == true {
            
            if count == 0 {
                
                //self.isKeyEditing = false
                count = count + 1
                self.bottomView.frame.origin.y +=  50
                self.replyView.frame.origin.y +=  50
                
            }else{
                count = 0
                self.bottomView.frame.origin.y -=  50
                self.replyView.frame.origin.y -=  50
                
            }
            
            
        }
     
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            // if self.tblView.frame.origin.y != 0 {
            //    self.tblView.frame.origin.y += keyboardSize.height
            // }
            
            let contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
            self.tblView.contentInset = contentInset
            // self.tblView.scrollIndicatorInsets = self.tblView.contentInset
            
            self.bottomView.frame.origin.y = self.viewHeight
            self.replyView.frame.origin.y = self.replyHeight
            self.isKeyEditing = false
            
            //self.tblView.reloadData()
            self.updateTableContentInset()
            
            //self.scrollToBottom()
            
            
            
            
        }
    }
    */
 
    

    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        if keyboard == false{
            keyboard = true
            lastKeyboardHeight = keyboardSize.height
           // chatDetailView.frame.origin.y = chatDetailView.frame.origin.y-(keyboardSize.height-bottomMenu.frame.height)
            
            let count = fetchedhResultController.sections?.first?.numberOfObjects ?? 0
            if count != 0 {
                let contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height , 0.0)
                self.tblView.contentInset = contentInset
                self.scrollToBottom()
            }
            
            self.bottomView.frame.origin.y = self.bottomView.frame.origin.y - keyboardSize.height
            self.replyView.frame.origin.y = self.replyView.frame.origin.y - keyboardSize.height
        
        }
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        let keyboardSize1 = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        if keyboard == true && lastKeyboardHeight != keyboardSize1.height {
            if lastKeyboardHeight < keyboardSize1.height{
                let keyboardDifference: CGFloat = keyboardSize1.height-lastKeyboardHeight
               // chatDetailView.frame.origin.y -= keyboardDifference
                
                let contentInset = UIEdgeInsetsMake(0.0, 0.0,keyboardDifference , 0.0)
                self.tblView.contentInset = contentInset
                
                self.bottomView.frame.origin.y -= keyboardDifference
                self.replyView.frame.origin.y -= keyboardDifference
                
                
            } else {
                let keyboardDifference: CGFloat = lastKeyboardHeight-keyboardSize1.height
              //  chatDetailView.frame.origin.y += keyboardDifference
                
                let contentInset = UIEdgeInsetsMake(0.0, 0.0,keyboardDifference , 0.0)
                self.tblView.contentInset = contentInset
                
                self.bottomView.frame.origin.y += keyboardDifference
                self.replyView.frame.origin.y += keyboardDifference
                
                

            }
            lastKeyboardHeight = keyboardSize1.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboard == true {
            keyboard = false
           // chatDetailView.frame.origin.y = chatDetailView.frame.origin.y+(lastKeyboardHeight-bottomMenu.frame.height)
            let contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
            self.tblView.contentInset = contentInset
            self.bottomView.frame.origin.y =  self.viewHeight
            self.replyView.frame.origin.y = self.replyHeight
            self.updateTableContentInset()
            
        }
    }
    
    
    /// Get Friend is Typing or not
    private func getFriend(id : String) -> String {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Friends")
        fetchRequest.predicate = NSPredicate(format: "contact_number = %@", id)
        
        var results : [NSManagedObject] = []
        
        do{
            results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                let f = results[0] as! Friends
                return f.is_typing
            }
        }catch{
            print("error executing request")
        }
        
        return ""
    }
    
}

extension ChatVC: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            self.tblView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            self.tblView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            self.tblView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tblView.endUpdates()
        self.scrollToBottom()
        
        // self.tblView.reloadData()
        
        //     self.reloadData()
        
        
        // self.updateTableContentInset()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tblView.beginUpdates()
    }
}





