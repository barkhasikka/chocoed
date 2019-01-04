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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextview.delegate = self
        noteTitle.delegate = self
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
        noteTextview.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    @IBAction func parrotColourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.3873848702, green: 1, blue: 0.1522773115, alpha: 1)
        noteTextview.textColor = #colorLiteral(red: 0.3873848702, green: 1, blue: 0.1522773115, alpha: 1)

    }
    @IBAction func redColourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.9111873414, green: 0, blue: 0.008497319128, alpha: 1)
        noteTextview.textColor = #colorLiteral(red: 0.9111873414, green: 0, blue: 0.008497319128, alpha: 1)

    }
    @IBAction func orangecolourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        noteTextview.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)

    }
    @IBAction func blueColourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.1879768739, green: 0.3261032742, blue: 0.5664893617, alpha: 1)
        noteTextview.textColor = #colorLiteral(red: 0.1879768739, green: 0.3261032742, blue: 0.5664893617, alpha: 1)

    }
    @IBAction func whiteColourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        noteTextview.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    @IBAction func greenCOlourAction(_ sender: Any) {
        noteTitle.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        noteTextview.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
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

