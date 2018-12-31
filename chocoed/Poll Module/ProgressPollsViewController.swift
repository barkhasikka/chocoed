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
    @IBOutlet weak var progressBarYL2: YLProgressBar!
    @IBOutlet weak var progressBarYL4: YLProgressBar!
    @IBOutlet weak var progressBarYL3: YLProgressBar!
    var currentVotePercent = 0.0
    var maxValue = 10.0
    override func viewDidLoad() {
        super.viewDidLoad()

        progressBarYL.type = YLProgressBarType.flat
        progressBarYL.progressTintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        progressBarYL.hideStripes = true
        
        progressBarYL2.type = YLProgressBarType.flat
        progressBarYL2.progressTintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        progressBarYL2.hideStripes = true
        
        progressBarYL3.type = YLProgressBarType.flat
        progressBarYL3.progressTintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        progressBarYL3.hideStripes = true
        
        progressBarYL4.type = YLProgressBarType.flat
        progressBarYL4.progressTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        progressBarYL4.hideStripes = true
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
