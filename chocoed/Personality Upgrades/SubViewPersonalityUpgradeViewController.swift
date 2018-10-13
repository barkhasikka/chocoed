//
//  SubViewPersonalityUpgradeViewController.swift
//  chocoed
//
//  Created by Tejal on 11/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class SubViewPersonalityUpgradeViewController: UIViewController {

    @IBOutlet weak var SubstatusLabel: UILabel!
    @IBOutlet weak var subTopicNameLabel: UILabel!
    @IBOutlet weak var subtopiclabel: UILabel!
    @IBOutlet weak var topicNameLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    var arrayDuplicatevalues: CourseSubTopicList!
    var activityUIView: ActivityIndicatorUIView!
    var arrayCourseSubTopicList = [CourseSubTopicList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        self.subTopicNameLabel.text = arrayDuplicatevalues.subTopicName
        SubstatusLabel.text = arrayDuplicatevalues.topicStatus
        topicNameLabel.text = arrayDuplicatevalues.topicName
        
        if SubstatusLabel.text == "Completed"{
           SubstatusLabel.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }else if SubstatusLabel.text == "Inprogress" {
            SubstatusLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else{
            SubstatusLabel.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
