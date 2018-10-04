//
//  QuizBahaviouralViewController.swift
//  chocoed
//
//  Created by Tejal on 01/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class QuizBahaviouralViewController: UIViewController {
    
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var quetionLabel: UILabel!
    var currentQuestion = Int()
    var valueofQuestionNo = Int()
    let optionbutton = UIButton()

    var arrayBehaviouralQuestion = [BehaviouralQuestion]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuizExamDetails()
        loadSaveExamQuestionAnswer()
      //  backgroundImagebahavioural()        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func backgroundImagebahavioural()
    {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        backgroundImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        backgroundImage.image = UIImage(named: "pages")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "ic_background_pattern")
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
    }
    func loadQuizExamDetails(){
    let clientID = UserDefaults.standard.integer(forKey: "clientid")
    let userid = UserDefaults.standard.string(forKey: "userid")
    
    let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"1"] as Dictionary<String, String>

    MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            print(response)
        let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
       // let optionsList = response.object(forKey: "optionList") as? NSArray ?? []
        
        for question in questionsList {
            self.arrayBehaviouralQuestion.append(BehaviouralQuestion(question as! NSDictionary))
         
                }
        
        print("\(self.arrayBehaviouralQuestion)")
        //print(self.arrayoption)
        DispatchQueue.main.async {
            self.quetionLabel.text = self.arrayBehaviouralQuestion[self.currentQuestion].questionName
//            let optionsList = self.arrayBehaviouralQuestion[self.currentQuestion].option
//            var y = 10;
//            var previousButton: UIButton!
//            for option in optionsList
//            {
//                let optionObject =  BehaviouralOption(option as! NSDictionary)
//                DispatchQueue.main.async {
//                    y = y + 50
//                    print("value of y", y)
//                    let optionButton = UIButton()
//                    let option = optionObject.ansText
//                    optionButton.setTitle(option, for: .normal )
//                    optionButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
//                    optionButton.frame = CGRect(x: 50, y: y, width: 100, height: 50)
//                    optionButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
//                    self.optionsView.addSubview(optionButton)
//                    self.setOptionButtonConstraint(previousButton: previousButton, currentButton: optionButton)
//                    previousButton = optionButton
//
//                }
//            }
            
            self.optionButtonfunction()
            
        }
        
    })
}
    @objc func pressed(sender: UIButton!) {
       print("button Pressed")
    }
    
    func loadSaveExamQuestionAnswer(){
    let clientID = UserDefaults.standard.integer(forKey: "clientid")
    let userid = UserDefaults.standard.string(forKey: "userid")
    
//        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Android","userId":"\(userid!)","clienId":"\(clientID)","examId":"0","questionId":"0","selectedAns":"","selectedAnsId":"","startTime":"","endTime":""] as Dictionary<String, String>
////    print(params)
//    MakeHttpPostRequest(url: saveUserExamQuestionAnswer , params: params, completion: {(success, response) -> Void in
//        print(response)
//        ////            let language = response.object(forKey: "appList") as? NSArray ?? []
//        ////
//        ////            for languages in language {
//        ////                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
//        //            }
//
//    })
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func NextButton(_ sender: Any) {
        for subviews in self.optionsView.subviews {
            if subviews is UIButton {
                subviews.removeFromSuperview()
            }
        }
        self.currentQuestion = self.currentQuestion + 1
        print(arrayBehaviouralQuestion.count)
        if arrayBehaviouralQuestion.count > self.currentQuestion {
        self.quetionLabel.text = self.arrayBehaviouralQuestion[self.currentQuestion].questionName
        //self.optionbutton.setTitle(arrayBehaviouralQuestion[self.currentQuestion], for: .normal)
        optionButtonfunction()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewWillApear called")
    }
    func optionButtonfunction(){
        let optionsList = self.arrayBehaviouralQuestion[self.currentQuestion].option
        //var y = 10;
        var previousButton: UIButton!
        for option in optionsList
        {
            let optionObject =  BehaviouralOption(option as! NSDictionary)
            DispatchQueue.main.async {
            //    y = y + 50
              //  print("value of y", y)
                var optionButton = UIButton()
                optionButton = UIButton(type: UIButtonType.custom) as UIButton
                
                let option = optionObject.ansText
                optionButton.setTitle(option, for: .normal )
                optionButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
                optionButton.contentHorizontalAlignment = .left
                optionButton.setImage(UIImage(named: "checkbox_off"), for: .normal)
                optionButton.titleLabel?.minimumScaleFactor = 0.5
                optionButton.titleLabel?.numberOfLines = 0
                optionButton.titleLabel?.adjustsFontSizeToFitWidth = true
                optionButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                self.optionsView.addSubview(optionButton)
                self.setOptionButtonConstraint(previousButton: previousButton, currentButton: optionButton)
                previousButton = optionButton
                
//                let imageviewopt = UIImageView()
//                let optionurl = optionObject.ansImageUrl
//                let data = try Data.init(contentsOf: URL.init(string:"\(optionurl)")!)
//                    if let data = data{
//                        imageviewopt.image = UIImage(data: data)
//                }
            }
        }
        
    }
    func setOptionButtonConstraint(previousButton: UIButton!, currentButton: UIButton) {
        
        currentButton.translatesAutoresizingMaskIntoConstraints = false
        if previousButton != nil {
            currentButton.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 20).isActive =  true
            
        }else {
            currentButton.topAnchor.constraint(equalTo: self.optionsView.topAnchor, constant: 20).isActive = true
            
        }
        currentButton.leadingAnchor.constraint(equalTo: self.optionsView.leadingAnchor, constant: 50).isActive =  true
        currentButton.trailingAnchor.constraint(equalTo: self.optionsView.trailingAnchor, constant: -10).isActive = true
        currentButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
      //  currentButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
