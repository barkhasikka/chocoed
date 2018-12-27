//
//  ProgressPollsViewController.swift
//  chocoed
//
//  Created by Tejal on 27/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import YLProgressBar

class ProgressPollsViewController: UIViewController {
    @IBOutlet weak var progressBarYL: YLProgressBar!
    var currentVotePercent = 0.0
    var maxValue = 10.0
    override func viewDidLoad() {
        super.viewDidLoad()

        progressBarYL.type = YLProgressBarType.flat
        progressBarYL.progressTintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        progressBarYL.hideStripes = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func button1(_ sender: Any) {
        progressBarYL.setProgress(CGFloat(currentVotePercent), animated: true)
        perform(#selector(uploadProgress), with: nil, afterDelay: 1.0)
    }
    @objc func uploadProgress(){
        currentVotePercent = currentVotePercent + 1.0
        progressBarYL.progress = CGFloat(currentVotePercent/maxValue)
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
