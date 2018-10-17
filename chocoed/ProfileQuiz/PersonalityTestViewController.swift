//
//  PersonalityTestViewController.swift
//  chocoed
//
//  Created by Tejal on 23/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class PersonalityTestViewController: UIViewController {
    var arrayBehaviouralQuestion = [Question]()
    var currentQuestion = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "ic_background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool{
        return false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func continueAction(_ sender: Any) {
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "quizb") as? QuizBahaviouralViewController {
            vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
            vcNewSectionStarted.currentExamID = 3
            vcNewSectionStarted.currentQuestion = currentQuestion
//        self.present(vcNewSectionStarted, animated: true, completion: nil)
//            if let navigator = navigationController {
//                navigator.title = "Personality Test"
//                navigator.pushViewController(vcNewSectionStarted, animated: true)
//            }
            let aObjNavi = UINavigationController(rootViewController: vcNewSectionStarted)
            aObjNavi.navigationBar.barTintColor = UIColor.blue
            self.present(aObjNavi, animated: true, completion: nil)
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
