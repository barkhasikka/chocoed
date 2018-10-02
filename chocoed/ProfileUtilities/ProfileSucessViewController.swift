//
//  ProfileSucessViewController.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ProfileSucessViewController: UIViewController {

    @IBOutlet weak var letBeginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.view.backgroundColor = UIColor(patternImage: UIImage(named: "perfect")!)

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "perfect")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        ButtonBorder()
        // Do any additional setup after loading the view.
    }

    func ButtonBorder()
    {
        letBeginButton.layer.cornerRadius = 20
        letBeginButton.clipsToBounds = true
        letBeginButton.layer.borderWidth = 1
        letBeginButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
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
