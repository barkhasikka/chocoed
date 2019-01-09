//
//  AddStickiesViewController.swift
//  chocoed
//
//  Created by Tejal on 05/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class AddStickiesViewController: UIViewController {
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var addStickyLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        circleView.layer.cornerRadius = 100
        circleView.layer.borderColor = #colorLiteral(red: 0.1529411765, green: 0.5490196078, blue: 0.937254902, alpha: 1)
        circleView.layer.borderWidth = 2
        circleView.clipsToBounds = true
        
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
