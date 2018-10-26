//
//  ProgressViewController.swift
//  chocoed
//
//  Created by Tejal on 26/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tabelViewProgressReport: UITableView!
    @IBOutlet weak var prgressBar1: ProgressBarView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        // On iOS 10 it has some strange behaviour if you put this in viewDidLoad. I found that in view didAppear it works without problems.
//        prgressBar1.initBar()
//
//        // The level of progress can be set from any point in the program.
//        prgressBar1.setProgressValue(currentValue: 90)
//
//        delayAction(withTime: 2.0) { () in
//            self.prgressBar1.setProgressValue(currentValue: 10)
//
//            delayAction(withTime: 2.0) { () in
//                self.prgressBar1.setProgressValue(currentValue: 70)
//
//                delayAction(withTime: 2.0) { () in
//                    self.prgressBar1.setProgressValue(currentValue: 100)
//                }
//            }
//        }
//    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "progresscell") as! ProgressViewTableViewCell
        
        cell.imagePerson.image = UIImage(named: "Man3_3")
        
        cell.namePerson.text = "Tushar"
        
        cell.noofSteps.text = "75455"
        
        cell.Steps.text = "Steps"
        
        return cell
    }
    
    
    
    func delayAction(withTime _time: Double, done: () -> Void){
//        let delayTime = dispatch_time(Int64(1 * Double(NSEC_PER_SEC)), Int64(delayTime))
//    dispatch_after(delayTime, dispatch_get_main_queue()) {
    print("test")
   // }
    }
}
