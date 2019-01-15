//
//  StickyNoteViewController.swift
//  chocoed
//
//  Created by Tejal on 04/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class StickyNoteViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate{

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteTextview: UITextView!
    @IBOutlet weak var pinkColour: UIButton!
    @IBOutlet weak var Parrotgreencolour: UIButton!
    @IBOutlet weak var redcolour: UIButton!
    @IBOutlet weak var blueColour: UIButton!
    @IBOutlet weak var orangeColour: UIButton!
    @IBOutlet weak var greenColour: UIButton!
    @IBOutlet weak var whitecolour: UIButton!
    @IBOutlet weak var colourView: UIView!
    var keyboard = false
    var activityUIView: ActivityIndicatorUIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextview.delegate = self
        noteTitle.delegate = self
        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        self.addDoneButtonOnKeyboard()

//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        colourView.bindToKeyboard()
}
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            noteTextview.resignFirstResponder()
            colourView.unbindFromKeyboard()
            
            return false
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        colourView.unbindFromKeyboard()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //called when return button is pressed on textfield
        self.view.endEditing(true)
        colourView.unbindFromKeyboard()
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        colourView.bindToKeyboard()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        colourView.bindToKeyboard()
    }
    @IBAction func PinkColourAction(_ sender: Any) {
        
        noteTitle.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        noteTextview.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    @IBAction func parrotColourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.3873848702, green: 1, blue: 0.1522773115, alpha: 1)
        noteTextview.backgroundColor = #colorLiteral(red: 0.3873848702, green: 1, blue: 0.1522773115, alpha: 1)

    }
    @IBAction func redColourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.9111873414, green: 0, blue: 0.008497319128, alpha: 1)
        noteTextview.backgroundColor = #colorLiteral(red: 0.9111873414, green: 0, blue: 0.008497319128, alpha: 1)

    }
    @IBAction func orangecolourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        noteTextview.backgroundColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)

    }
    @IBAction func blueColourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.1879768739, green: 0.3261032742, blue: 0.5664893617, alpha: 1)
        noteTextview.backgroundColor = #colorLiteral(red: 0.1879768739, green: 0.3261032742, blue: 0.5664893617, alpha: 1)

    }
    @IBAction func whiteColourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        noteTextview.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    @IBAction func greenCOlourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        noteTextview.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            self.colourView.frame.origin.y -= keyboardSize.height + 40
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        self.view.frame.origin.y = 0
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButton(_ sender: Any) {
     let vc = storyboard?.instantiateViewController(withIdentifier: "taguList") as? MyTagUlistViewController
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    func addEditStickyNotefunc(){
        let userID = UserDefaults.standard.integer(forKey: "userid")
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let hex = noteTextview.backgroundColor?.toHexString
        print(hex)
        
        let params = [ "access_token":"\(accessToken)", "userId": "\(userID)","clientId":"\(clientID)", "color": "#\(hex ?? "000000")", "notes": "\(noteTextview.text!)", "title": "\(noteTitle.text ?? "")", "stickyNoteId" : "0"] as Dictionary<String, String>
        
        print(params)
        
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: addEditStickyNotes , params: params, completion: {(success, response) -> Void in
            print(response)
            
            DispatchQueue.main.async {
                
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "taguList") as? MyTagUlistViewController
            self.present(vc!, animated: true, completion: nil)
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
        })

    }
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "send", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.hideKeyboard))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.noteTextview.inputAccessoryView = doneToolbar
        
    }
    @objc
    func hideKeyboard(){
        self.view.endEditing(true)
        if self.noteTitle.text == "" && self.noteTextview.text == ""{
            print("alert will be presented please enter the data in to add notes")
        }else{
            addEditStickyNotefunc()
        }
    }
    
    
}
extension UIColor {
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
}

extension UIView {
    
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func unbindFromKeyboard(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc
    func keyboardWillChange(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        })
    }
}

