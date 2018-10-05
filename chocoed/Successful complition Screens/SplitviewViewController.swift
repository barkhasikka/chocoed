//
//  SplitviewViewController.swift
//  chocoed
//
//  Created by Tejal on 05/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class SplitviewViewController: UISplitViewController {
    var menuvc : ViewControllerMenubar!

    @IBOutlet weak var viewButtonsCircle: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "dashboard_header")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.viewButtonsCircle.insertSubview(backgroundImage, at: 0)

        
        menuvc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! ViewControllerMenubar
        
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(responsetoright))
        swiperight.direction = UISwipeGestureRecognizerDirection.right
        
        
        self.view.addGestureRecognizer(swiperight)
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(responsetoright))
        swipeleft.direction = UISwipeGestureRecognizerDirection.right
        
        
        self.view.addGestureRecognizer(swipeleft)
        
    }

    @objc func responsetoright(gesture : UISwipeGestureRecognizer)
    {
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

    func showmethod()
    {
        UIView.animate(withDuration: 0.3) { ()->Void in
            self.menuvc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.addChildViewController(self.menuvc)
            self.view.addSubview(self.menuvc.view)
            self.menuvc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            AppDelegate.menu_bool = false
        }
        
    }
    func closemethod()
    {
        UIView.animate(withDuration: 0.3, animations: { ()->Void in
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
