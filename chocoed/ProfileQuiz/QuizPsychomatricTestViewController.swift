//
//  QuizPsychomatricTestViewController.swift
//  chocoed
//
//  Created by Tejal on 03/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class QuizPsychomatricTestViewController: UIViewController {
    
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var optionsVIew: UIView!
    var currentQuestion = Int()
    var valueofQuestionNo = Int()
    let optionbutton = UIButton()
    var selectedAnswer = ""
    var questionId = ""
    var arrayBehaviouralQuestion = [Question]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuizExamDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loadQuizExamDetails(){
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"2"] as Dictionary<String, String>
        
        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            print(response)
            let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
            
            for question in questionsList {
                self.arrayBehaviouralQuestion.append(Question(question as! NSDictionary))
                
            }
            
            print("\(self.arrayBehaviouralQuestion)")
            //print(self.arrayoption)
            DispatchQueue.main.async {
                self.labelQuestion.text = self.arrayBehaviouralQuestion[self.currentQuestion].questionName
                
                self.optionButtonfunction()
                
            }
            DispatchQueue.main.async {
                myActivityIndicator.stopAnimating()
                myActivityIndicator.hidesWhenStopped = true
            }
            
        })
    }
    
    @objc func pressed(sender: UIButton!) {
        print("button Pressed")
        for subviews in self.optionsVIew.subviews {
            if subviews is UIButton {
                var testButton = subviews as? UIButton
                testButton?.setImage(UIImage(named: "checkbox_off"), for: .normal)
            }
        }
        sender.contentHorizontalAlignment = .left
        sender.setImage(UIImage(named: "checkbox_on"), for: .normal)
        print(sender.tag, "Selected answer ID", self.arrayBehaviouralQuestion[self.currentQuestion].id, "<<<<<---- QUESTION ID")
        answerId = sender.tag
        
        selectedAnswer = (sender.titleLabel?.text)!
        questionId = self.arrayBehaviouralQuestion[self.currentQuestion].id
        print(answerId)
        print(questionId)
    }

    func loadSaveExamQuestionAnswer(){
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clienId":"\(clientID)","examId":"1","questionId":"\(questionId)","selectedAns":"\(selectedAnswer)","selectedAnsId":"\(answerId)","startTime":"1","endTime":"3"] as Dictionary<String, String>
        print(params)
        MakeHttpPostRequest(url: saveUserExamQuestionAnswer , params: params, completion: {(success, response) -> Void in
            print(response)
            ////            let language = response.object(forKey: "appList") as? NSArray ?? []
            ////
            ////            for languages in language {
            ////                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
            //            }
            
        })
    }

    @IBAction func nextButton(_ sender: Any) {
        for subviews in self.optionsVIew.subviews {
            if subviews is UIButton {
                subviews.removeFromSuperview()
            }
        }
        self.currentQuestion = self.currentQuestion + 1
        print(arrayBehaviouralQuestion.count)
        if arrayBehaviouralQuestion.count > self.currentQuestion {
            self.labelQuestion.text = self.arrayBehaviouralQuestion[self.currentQuestion].questionName
            //self.optionbutton.setTitle(arrayBehaviouralQuestion[self.currentQuestion], for: .normal)
            optionButtonfunction()
        }
        
        loadSaveExamQuestionAnswer()
        if arrayBehaviouralQuestion.count < self.currentQuestion
        {
            let vcNewSectionStarted = storyboard?.instantiateViewController(withIdentifier: "personality") as! PersonalityTestViewController
            self.present(vcNewSectionStarted, animated: true, completion: nil)
            
        }

        
    }
    
    func optionButtonfunction(){
        let optionsList = self.arrayBehaviouralQuestion[self.currentQuestion].option
        //var y = 10;
        var previousButton: UIButton!
        for option in optionsList
        {
            let optionObject =  Option(option as! NSDictionary)
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
                optionButton.tag = Int(optionObject.id)!
                optionButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                self.optionsVIew.addSubview(optionButton)
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
            currentButton.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 10).isActive =  true
            
        }else {
            currentButton.topAnchor.constraint(equalTo: self.optionsVIew.topAnchor, constant: 20).isActive = true
            
        }
        currentButton.leadingAnchor.constraint(equalTo: self.optionsVIew.leadingAnchor, constant: 50).isActive =  true
        currentButton.trailingAnchor.constraint(equalTo: self.optionsVIew.trailingAnchor, constant: -10).isActive = true
        currentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //  currentButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    
    
}
