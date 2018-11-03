//
//  PsuchometricTestViewController.swift
//  chocoed
//
//  Created by Tejal on 23/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class PsychometricTestViewController: UIViewController {
    
    @IBOutlet weak var letsBeginLabel: UILabel!
    
    @IBOutlet weak var psychometricTestLabel: UILabel!
    
    
    @IBOutlet weak var continue1: UIButton!
    
    
    var arrayBehaviouralQuestion = [Question]()
    var currentQuestion = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let language = UserDefaults.standard.string(forKey: "currentlanguage")
        self.letsBeginLabel.text = "चलिए शुरू करते हैं".localizableString(loc: language!)
        self.psychometricTestLabel.text = "साइकोमेट्रिक जांच".localizableString(loc: language!)
        self.continue1.setTitle("जारी रखें".localizableString(loc: language!), for: .normal)
        
        
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
            vcNewSectionStarted.currentExamID = 2
            vcNewSectionStarted.calenderId = "0"
            vcNewSectionStarted.currentQuestion = currentQuestion
            let aObjNavi = UINavigationController(rootViewController: vcNewSectionStarted)
            aObjNavi.navigationBar.barTintColor = UIColor.blue
            self.present(aObjNavi, animated: true, completion: nil)
//            if let navigator = navigationController {
//                navigator.title = "Psychometric Test"
//                navigator.pushViewController(vcNewSectionStarted, animated: true)
//            }else {
//                print("whoops what is going wrong")
//            }
        }
        
        
//        self.present(vcNewSectionStarted, animated: true, completion: nil)
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
