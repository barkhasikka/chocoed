//
//  BehavioralViewController.swift
//  chocoed
//
//  Created by Tejal on 23/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class BehavioralViewController: UIViewController {
    var arrayBehaviouralQuestion = [Question]()
    var currentQuestion = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "ic_background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait
    }
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    @IBAction func continueAction(_ sender: Any) {
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "quizb") as? QuizBahaviouralViewController {
            vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
            vcNewSectionStarted.currentExamID = 1
            vcNewSectionStarted.calenderId = "0"
            vcNewSectionStarted.currentQuestion = self.currentQuestion
            let aObjNavi = UINavigationController(rootViewController: vcNewSectionStarted)
            aObjNavi.navigationBar.barTintColor = UIColor.blue
            self.present(aObjNavi, animated: true, completion: nil)
            
//            if let navigator = navigationController {
//                navigator.title = "Behavioural Test"
////
//                navigator.navigationBar.tintColor = .white
////                navigator.navigationBar.titleTextAttributes = []
//
//                navigator.pushViewController(vcNewSectionStarted, animated: true)
//            }
//            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }
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
