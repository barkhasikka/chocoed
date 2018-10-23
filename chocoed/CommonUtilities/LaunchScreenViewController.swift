//
//  launchScreenViewController.swift
//  chocoed
//
//  Created by Tejal on 22/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var imageLogoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let Gif = UIImage.gifImageWithName("logo_1")
        imageLogoView.image = Gif
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
