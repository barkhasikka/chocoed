//
//  SplitviewViewController.swift
//  chocoed
//
//  Created by Tejal on 05/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class SplitviewViewController: UIViewController {
    var menuvc : ViewControllerMenubar!
    var toggle = true
    var drag = ""
    @IBOutlet weak var mainviewConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var arcView: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var userProgressView: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var constraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var buttonLotus: UIButton!
    @IBOutlet weak var buttonMiddleProfile: UIButton!
    @IBOutlet weak var buttonMsg: UIButton!
    @IBOutlet weak var viewButtonsCircle: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arcView.isHidden = true
        let fileUrl = URL(string: USERDETAILS.imageurl)
        if fileUrl != nil {
            if let data = try? Data(contentsOf: fileUrl!) {
                if let image = UIImage(data: data) {
                    self.imageProfile.image = image
                }
            }
            imageProfile.layer.borderWidth = 1.0
            imageProfile.layer.masksToBounds = false
            imageProfile.layer.borderColor = UIColor.darkGray.cgColor
            imageProfile.layer.cornerRadius = imageProfile.frame.width / 2
            imageProfile.clipsToBounds = true
            imageProfile.contentMode = .center
        }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageViewLogo.isUserInteractionEnabled = true
        imageViewLogo.addGestureRecognizer(tapGestureRecognizer)
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:200)
        let backgroundImage = UIImageView(frame: frame)
        backgroundImage.image = UIImage(named: "dashboard_header")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.viewButtonsCircle.insertSubview(backgroundImage, at: 0 )
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
//        constraintsToButton()
        
//        let frame1 = CGRect(x: 0, y: 620, width: UIScreen.main.bounds.width, height: 120)
//        let backgroundImage1 = UIImageView(frame: frame1)
//        backgroundImage1.image = UIImage(named: "ic_choice_conversion_content_connect")
//        backgroundImage1.contentMode = UIViewContentMode.scaleAspectFill
//        self.arcView.insertSubview(backgroundImage, at: 0 )
        
        menuvc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! ViewControllerMenubar
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(responsetoright))
        swiperight.direction = UISwipeGestureRecognizerDirection.right
       
        self.view.addGestureRecognizer(swiperight)
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(responsetoright))
        swipeleft.direction = UISwipeGestureRecognizerDirection.right
        
        
        self.view.addGestureRecognizer(swipeleft)
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        print("Please select image")
        toggle = !toggle
        print(toggle)
        if toggle == true{
        self.arcView.isHidden = true
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, animations: {
            self.constraintOutlet.constant = 20
            self.mainviewConstraintOutlet.constant = 800
            self.view.layoutIfNeeded()
            })
        }else{
          
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 1, animations: {
                self.constraintOutlet.constant = 150
                self.mainviewConstraintOutlet.constant = 900
                self.view.layoutIfNeeded()
                self.arcView.isHidden = false

        })
        }
    }
    @IBAction func menuButton(_ sender: UIBarButtonItem) {
        if AppDelegate.menu_bool {
            showmethod()
        }
        else
        {
            closemethod()
        }
    }
    func constraintsToButton(){
        buttonMsg.translatesAutoresizingMaskIntoConstraints = false
        self.buttonMsg.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250).isActive = true
        self.buttonMsg.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonMsg.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonMsg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    
        buttonLotus.translatesAutoresizingMaskIntoConstraints =  false
        self.buttonLotus.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250).isActive =  true
        self.buttonLotus.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonLotus.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonLotus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        buttonMiddleProfile.translatesAutoresizingMaskIntoConstraints = false
        self.buttonMiddleProfile.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive =  true
        self.buttonMiddleProfile.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonMiddleProfile.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonMiddleProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    @objc func responsetoright(gesture : UISwipeGestureRecognizer) {
        switch gesture.direction
        {
        case UISwipeGestureRecognizerDirection.right:
            print("left swipe")
            showmethod()
        case UISwipeGestureRecognizerDirection.left:
            print("left swipe")
            close_swipe()
        default : break
            
        }
    }

    func showmethod() {
        UIView.animate(withDuration: 0.1) { ()->Void in
            self.menuvc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.addChildViewController(self.menuvc)
            self.view.addSubview(self.menuvc.view)
            self.menuvc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            AppDelegate.menu_bool = false
        }
        
    }
    func closemethod()
    {
        UIView.animate(withDuration: 0.1, animations: { ()->Void in
            self.menuvc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.menuvc.view.removeFromSuperview()
            
        }
        AppDelegate.menu_bool = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close_swipe()
    {
        if AppDelegate.menu_bool {
            showmethod()
        }
        else
        {
            closemethod()
        }
    }
}
