//
//  QuizBahaviouralViewController.swift
//  chocoed
//
//  Created by Tejal on 01/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class QuizBahaviouralViewController: UIViewController, UIGestureRecognizerDelegate,UIDragInteractionDelegate,UIDropInteractionDelegate {
  
    @IBOutlet weak var pagesViews: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var quetionLabel: UILabel!
    var currentQuestion = Int()
    var valueofQuestionNo = Int()
    let optionbutton = UIButton()
    var selectedAnswer = ""
    var questionId = ""
    var arrayBehaviouralQuestion = [Question]()
    var currentExamID: Int = 0
    var startTime: Double = 0
    var activityUIView: ActivityIndicatorUIView!
    var imageView = UIImageView()
    
    @IBOutlet weak var questionsProgressUILabel: UILabel!
    @IBOutlet weak var nextUIButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dragInteraction = UIDragInteraction(delegate: self)
        imageView.addInteraction(dragInteraction)
        imageView.isUserInteractionEnabled = true

        
        activityUIView = ActivityIndicatorUIView(frame: self.view.frame)
        self.view.addSubview(activityUIView)
        activityUIView.isHidden = true
        
        if currentExamID == 1 {
            self.navigationItem.title = "Behavioural Test"
        }else if currentExamID == 2 {
            self.navigationItem.title = "Psychometric Test"
        }else if currentExamID == 3 {
            self.navigationItem.title = "Personality Test"
        }
        
        print("the current question id id", currentQuestion)
        
//        self.pagesViews.layer.borderWidth = 1
//        self.pagesViews.layer.borderColor = UIColor.lightGray.cgColor
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        loadQuizExamDetails()
//        let frameRect = pagesViews.frame
//        let backgroundImage = UIImageView(frame: frameRect)
//        backgroundImage.image = UIImage(named: "pages")
//        backgroundImage.contentMode = UIViewContentMode.top
//        self.pagesViews.insertSubview(backgroundImage, at: 0)
        questionsProgressUILabel.text = "\(self.currentQuestion + 1) / \(self.arrayBehaviouralQuestion.count)"
        startTime = NSDate().timeIntervalSince1970 * 1000
      //  backgroundImagebahavioural()        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func backgroundImagebahavioural() {
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
//        let clientID = UserDefaults.standard.integer(forKey: "clientid")
//        let userid = UserDefaults.standard.string(forKey: "userid")
//        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
//        myActivityIndicator.center = view.center
//        myActivityIndicator.hidesWhenStopped = false
//        myActivityIndicator.startAnimating()
//        view.addSubview(myActivityIndicator)

//        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"1"] as Dictionary<String, String>

//        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
//            print(response)
//            let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
//            for question in questionsList {
//                self.arrayBehaviouralQuestion.append(Question(question as! NSDictionary))
//            }
        
            print("\(self.arrayBehaviouralQuestion)")
//            DispatchQueue.main.async {
                self.quetionLabel.text = self.arrayBehaviouralQuestion[self.currentQuestion].questionName
        self.optionButtonfunction(ansType: self.arrayBehaviouralQuestion[self.currentQuestion].anstype)
//                myActivityIndicator.stopAnimating()
//                myActivityIndicator.hidesWhenStopped = true
//            }
//        })
    }
    
    @objc func pressed(sender: UIButton!) {
       print("button Pressed")
        for subviews in self.optionsView.subviews {
            if subviews is UIButton {
                let testButton = subviews as? UIButton
                testButton?.setImage(UIImage(named: "checkbox_off"), for: .normal)
            }
        }
        sender.contentHorizontalAlignment = .left
        sender.setImage(UIImage(named: "checkbox_on"), for: .normal)
        print(sender.tag, "Selected answer ID", self.arrayBehaviouralQuestion[self.currentQuestion].id, "<<<<<---- QUESTION ID")
        answerId = sender.tag
        if sender.titleLabel != nil && sender.titleLabel?.text != nil {
            selectedAnswer = (sender.titleLabel?.text)!
        }
        
        questionId = self.arrayBehaviouralQuestion[self.currentQuestion].id
        print(answerId)
        print(questionId)
    }
    
    @objc func handleTapTextWithImage(sender: UITapGestureRecognizer? = nil) {
        print("handleTapTextWithImage")
        if sender?.state == .ended {
            for subviews in self.optionsView.subviews {
//                if subviews is UIView {
//                    var testButton = subviews as? UIView
                    subviews.layer.borderWidth = 0
                    subviews.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
                    
//                }
            }
            sender?.view?.layer.borderWidth = 1
            sender?.view?.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
            print(sender?.view?.tag ?? 0, "Selected answer ID", self.arrayBehaviouralQuestion[self.currentQuestion].id, "<<<<<---- QUESTION ID")
            answerId = sender?.view?.tag ?? 0
//            if sender.titleLabel != nil && sender.titleLabel?.text != nil {
//                selectedAnswer0 = (sender.titleLabel?.text)!
//            }
            
            questionId = self.arrayBehaviouralQuestion[self.currentQuestion].id
            print(answerId)
            print(questionId)
        }
        
    }
    
    func loadSaveExamQuestionAnswer(){
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        let endTime = NSDate().timeIntervalSince1970 * 1000
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(self.currentExamID)","questionId":"\(questionId)","selectedAns":"\(selectedAnswer)","selectedAnsId":"\(answerId)","startTime":"\(startTime)","endTime":"\(endTime)"] as Dictionary<String, String>
            print(params)
        
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: saveUserExamQuestionAnswer , params: params, completion: {(success, response) -> Void in
            print(response, "<<<<<<-- SAVE ANSWER RESPONSE....")
    ////            let language = response.object(forKey: "appList") as? NSArray ?? []
    ////
    ////            for languages in language {
    ////                self.arrayLanguages.append(LanguageList( languages as! NSDictionary))
    //            }

            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.stopAnimation()
                
            }
        })
    }
    
    @IBAction func NextButton(_ sender: Any) {
        loadSaveExamQuestionAnswer()
        for subviews in self.optionsView.subviews {
//            if subviews is UIButton {
                subviews.removeFromSuperview()
//            }
        }
        self.currentQuestion = self.currentQuestion + 1
        
        print(arrayBehaviouralQuestion.count, self.currentQuestion, "<<<---- CHECK HERE THE VALUES")
        if arrayBehaviouralQuestion.count - 1 > self.currentQuestion {
            questionsProgressUILabel.text = "\(self.currentQuestion+1) / \(self.arrayBehaviouralQuestion.count)"
            self.quetionLabel.text = self.arrayBehaviouralQuestion[self.currentQuestion].questionName
            //self.optionbutton.setTitle(arrayBehaviouralQuestion[self.currentQuestion], for: .normal)
            optionButtonfunction(ansType: self.arrayBehaviouralQuestion[self.currentQuestion].anstype)
            startTime = NSDate().timeIntervalSince1970 * 1000
        } else {
            //user has traversed all the questions. Now we need to hide next button and call end test API and then present new type nest vc
            questionsProgressUILabel.text = "\(self.currentQuestion+1) / \(self.arrayBehaviouralQuestion.count)"
            self.quetionLabel.text = self.arrayBehaviouralQuestion[self.currentQuestion].questionName
            //self.optionbutton.setTitle(arrayBehaviouralQuestion[self.currentQuestion], for: .normal)
            optionButtonfunction(ansType: self.arrayBehaviouralQuestion[self.currentQuestion].anstype)
            startTime = NSDate().timeIntervalSince1970 * 1000
            self.nextUIButton.isHidden = true
//            self.currentExamID = self.currentExamID + 1
//            loadNextTypeQuestions()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewWillApear called")
    }
    func optionButtonfunction(ansType: String){
        print("ASNWER TYPE --->>>>>>>>>>>>", ansType)
        let optionsList = self.arrayBehaviouralQuestion[self.currentQuestion].option
        switch ansType {
        case "1":
            generateTextOnlyOptions(optionList: optionsList, selectedAns: self.arrayBehaviouralQuestion[self.currentQuestion].selectedAns)
            break
        case "2":
            generateTextWithImageOptions(optionList: optionsList)
            break
        case "3":
            generateTextWithImageOptions(optionList: optionsList)
            break
        case "4":
            generateDragDropOptions(optionList: optionsList)
            break
        case "5":
            generateTextOnlyOptions(optionList: optionsList, selectedAns: self.arrayBehaviouralQuestion[self.currentQuestion].selectedAns)
            break
        default:
            print("somethig went wrong")
        }
    }
    
    func loadNextTypeQuestions(){
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
      
        let params = ["access_token":"\(accessToken)","deviceId":"","deviceToken":"","deviceInfo":"","deviceType":"Andriod","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(self.currentExamID)"] as Dictionary<String, String>
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            print(response)
            var currentQuestionID: Int =  -1
            self.arrayBehaviouralQuestion = [Question]()
            let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
            for (index, question) in questionsList.enumerated() {
                self.arrayBehaviouralQuestion.append(Question(question as! NSDictionary))
                if self.arrayBehaviouralQuestion[index].answerSubmitted == 0 && currentQuestionID == -1 {
                    currentQuestionID = index
                }
            }
            DispatchQueue.main.async {
                if self.currentExamID == 3 {
                    if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "personality") as? PersonalityTestViewController {
                        vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
                        vcNewSectionStarted.currentQuestion = currentQuestionID
//                        if let navigator = self.navigationController {
//                            navigator.pushViewController(vcNewSectionStarted, animated: true)
                            self.present(vcNewSectionStarted, animated: true, completion: nil)
//                        }
                        
                    }
                    
                    
                } else if self.currentExamID == 2 {
                    if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "psychometric") as? PsychometricTestViewController {
                        vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
                        vcNewSectionStarted.currentQuestion = currentQuestionID
//                        if let navigator = self.navigationController {
//                            navigator.pushViewController(vcNewSectionStarted, animated: true)
//                        }
                        self.present(vcNewSectionStarted, animated: true, completion: nil)
                    }
                    

                } else {
                    let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "newscreen") as! ExamComplitionScreenViewController
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                }
            }
            
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.stopAnimation()

            }
        })
    }
    
    @IBAction func endTestAction(_ sender: Any) {
        if arrayBehaviouralQuestion.count - 1 > self.currentQuestion {
            showEndTestAlert()
        } else {
            //user has traversed all the questions. Now we need to hide next button and call end test API and then present new type nest vc
            self.nextUIButton.isHidden = true
            loadSaveExamQuestionAnswer()
            self.callEndTestAPI()
            
            if self.currentExamID == 3 {
               
                let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "newscreen") as! ExamComplitionScreenViewController
                self.present(vcNewSectionStarted, animated: true, completion: nil)
            }else {
//                self.currentExamID = self.currentExamID + 1
//                print(self.currentExamID)
//                loadNextTypeQuestions()
            }
        }
    }
    
    func showEndTestAlert() {
        let alertcontrol = UIAlertController(title: "Alert", message: "This will end your assessment and any unanswered questions will be skipped. Do you wish to proceed?", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "CANCEL", style: .cancel) { (action) in
           
        }
        let alertaction1 = UIAlertAction(title: "END", style: .default) { (action) in
            self.callEndTestAPI()
        }
        alertcontrol.addAction(alertaction)
        alertcontrol.addAction(alertaction1)
        self.present(alertcontrol, animated: true, completion: nil)
    }
    
    func callEndTestAPI() {
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        let endTime = NSDate().timeIntervalSince1970 * 1000
        print(endTime)
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(self.currentExamID)", "endTime": "\(endTime)"] as Dictionary<String, String>
        print(params, "<<<<-- end test api")
        activityUIView.isHidden = false
        activityUIView.startAnimation()
        MakeHttpPostRequest(url: endExamAPI, params: params, completion: {(success, response) -> Void in
            print(response)
            self.currentExamID = self.currentExamID + 1
            print(self.currentExamID)
            
            DispatchQueue.main.async {
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
                self.loadNextTypeQuestions()
//                if self.currentExamID == 3 {
//                    if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "personality") as? PersonalityTestViewController {
//                        vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
//                        if let navigator = self.navigationController {
//                            navigator.pushViewController(vcNewSectionStarted, animated: true)
//                        }
//                    }
//
////                    self.present(vcNewSectionStarted, animated: true, completion: nil)
//                } else if self.currentExamID == 2 {
//                    if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "psychometric") as? PsychometricTestViewController{
//                        vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
//                        if let navigator = self.navigationController{
//                            navigator.pushViewController(vcNewSectionStarted, animated: true)
//                        }
//                    }
//
////                    self.present(vcNewSectionStarted, animated: true, completion: nil)
//                } else {
//                    let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "newscreen") as! ExamComplitionScreenViewController
//                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                //                }
            }
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.activityUIView.isHidden = true
                self.activityUIView.stopAnimation()
            }
        })
    }
    
    func generateTextOnlyOptions(optionList: NSArray, selectedAns: String){
        var previousButton: UIButton!
        for option in optionList {
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
                if optionObject.id == selectedAns {
                    optionButton.setImage(UIImage(named: "checkbox_on"), for: .normal)
                }else {
                    optionButton.setImage(UIImage(named: "checkbox_off"), for: .normal)
                }
                
                optionButton.titleLabel?.minimumScaleFactor = 0.5
                optionButton.titleLabel?.numberOfLines = 0
                optionButton.titleLabel?.adjustsFontSizeToFitWidth = true
                optionButton.tag = Int(optionObject.id)!
                optionButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                self.optionsView.addSubview(optionButton)
                self.setOptionButtonConstraint(previousButton: previousButton, currentButton: optionButton)
                previousButton = optionButton
            }
        }
    }
    
    func setOptionButtonConstraint(previousButton: UIButton!, currentButton: UIButton) {
        
        currentButton.translatesAutoresizingMaskIntoConstraints = false
        if previousButton != nil {
            currentButton.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 15).isActive =  true
            
        }else {
            currentButton.topAnchor.constraint(equalTo: self.optionsView.topAnchor, constant: 20).isActive = true
            
        }
        currentButton.leadingAnchor.constraint(equalTo: self.optionsView.leadingAnchor, constant: 50).isActive =  true
        currentButton.trailingAnchor.constraint(equalTo: self.optionsView.trailingAnchor, constant: -10).isActive = true
        currentButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        //  currentButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func generateTextWithImageOptions(optionList: NSArray){
        var previousUIView: UIView!
        
//        for i in stride(from: 0, to: optionList.count, by: 2) {
        
        
        DispatchQueue.main.async {
            for option in optionList {
                let buttonImageUIViewFirst = UIView()
                let optionObject =  Option(option as! NSDictionary)
//                buttonImageUIViewFirst.translatesAutoresizingMaskIntoConstraints = false
//                buttonImageUIViewFirst.heightAnchor.constraint(equalToConstant: 100).isActive = true
//                buttonImageUIViewFirst.widthAnchor.constraint(equalToConstant: 60).isActive = true
//
                var optionButton = UIImageView()
                var optionText = UILabel()
                
                optionText.text = optionObject.ansText
                optionText.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                optionText.textAlignment = .center
                var url = optionObject.ansImageUrl
                
                var fileUrl = URL(string: url)
                if let data = try? Data(contentsOf: fileUrl!) {
                    if let image = UIImage(data: data) {
                        optionButton.image = image
                    }
                }
                
                buttonImageUIViewFirst.addSubview(optionButton)
                buttonImageUIViewFirst.addSubview(optionText)
                self.setImageTextConstraints(uiView: buttonImageUIViewFirst, imageView: optionButton, label: optionText)
                print(optionObject.id, "<<<<-- otion id is here")
                buttonImageUIViewFirst.tag = Int(optionObject.id)!
                var tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapTextWithImage(sender:)))
                tap.delegate = self // This is not required
                buttonImageUIViewFirst.addGestureRecognizer(tap)
                
                self.optionsView.addSubview(buttonImageUIViewFirst)
                
//                var buttonImageUIViewSecond: UIView!
//                if i + 1 < optionList.count {
//                    buttonImageUIViewSecond = UIView()
//                    let optionObjectSecond =  Option(optionList[i+1] as! NSDictionary)
////                    buttonImageUIViewSecond.translatesAutoresizingMaskIntoConstraints = false
////                    buttonImageUIViewSecond.heightAnchor.constraint(equalToConstant: 100).isActive = true
////                    buttonImageUIViewSecond.widthAnchor.constraint(equalToConstant: 60).isActive = true
//
//                    optionButton = UIImageView()
//                    optionText = UILabel()
//
//
//                    optionText.text = optionObjectSecond.ansText
//                    optionText.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//                    optionText.textAlignment = .center
//                    url = optionObjectSecond.ansImageUrl
//
//                    fileUrl = URL(string: url)
//                    if let data = try? Data(contentsOf: fileUrl!) {
//                        if let image = UIImage(data: data) {
//                            optionButton.image = image
//                        }
//                    }
//
//                    buttonImageUIViewSecond.addSubview(optionButton)
//                    buttonImageUIViewSecond.addSubview(optionText)
//                    self.setImageTextConstraints(uiView: buttonImageUIViewSecond, imageView: optionButton, label: optionText)
//                    optionButton.tag = Int(optionObjectSecond.id)!
//                    tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapTextWithImage(sender:)))
//                    tap.delegate = self // This is not required
//                    buttonImageUIViewSecond.addGestureRecognizer(tap)
//
//                    self.optionsView.addSubview(buttonImageUIViewSecond)
//                }
                
                self.setTextWithImageOptionButtonConstraint(previousUIView: previousUIView, currentUIViewFirst: buttonImageUIViewFirst, currentUIViewSecond: nil)
                previousUIView = buttonImageUIViewFirst
            }
        }
    }
    
    func setImageTextConstraints(uiView: UIView, imageView: UIImageView, label: UILabel){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive  = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive  = true
        imageView.contentMode = .scaleAspectFit
        imageView.centerXAnchor.constraint(equalTo: uiView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: uiView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setTextWithImageOptionButtonConstraint(previousUIView: UIView!, currentUIViewFirst: UIView, currentUIViewSecond: UIView!) {
        currentUIViewFirst.translatesAutoresizingMaskIntoConstraints = false
        currentUIViewFirst.centerXAnchor.constraint(equalTo: self.optionsView.centerXAnchor).isActive = true
        currentUIViewFirst.widthAnchor.constraint(equalToConstant: 100).isActive = true
        currentUIViewFirst.heightAnchor.constraint(equalToConstant: 100).isActive = true
        if currentUIViewSecond != nil {
            currentUIViewSecond.translatesAutoresizingMaskIntoConstraints = false
            currentUIViewSecond.widthAnchor.constraint(equalToConstant: 100).isActive = true
            currentUIViewSecond.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
        if previousUIView != nil {
            currentUIViewFirst.topAnchor.constraint(equalTo: previousUIView.bottomAnchor, constant: 15).isActive =  true
            if currentUIViewSecond != nil {
                currentUIViewSecond.topAnchor.constraint(equalTo: previousUIView.bottomAnchor, constant: 15).isActive =  true
            }
        }else {
            currentUIViewFirst.topAnchor.constraint(equalTo: self.optionsView.topAnchor, constant: 20).isActive = true
            if currentUIViewSecond != nil {
                currentUIViewSecond.topAnchor.constraint(equalTo: self.optionsView.topAnchor, constant: 20).isActive = true
            }
        }
//        currentUIViewFirst.leadingAnchor.constraint(equalTo: self.optionsView.leadingAnchor, constant: 20).isActive =  true
        if currentUIViewSecond != nil {
//            currentUIViewSecond.trailingAnchor.constraint(equalTo: self.optionsView.trailingAnchor, constant: -20).isActive = true
            currentUIViewSecond.leadingAnchor.constraint(equalTo: currentUIViewFirst.trailingAnchor, constant: 30).isActive = true
        }
    }
    
    
    func generateImageOnlyOptions(optionList: NSArray){
        var previousButton: UIButton!
        
            DispatchQueue.main.async {
                //    y = y + 50
                //  print("value of y", y)
                for option in optionList {
                    let optionObject =  Option(option as! NSDictionary)
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
    
    func generateDragDropOptions(optionList: NSArray){
        DispatchQueue.main.async {
            let questionImageList = self.arrayBehaviouralQuestion[self.currentQuestion].questionList
            var previousImageView : UIImageView!
            for question in questionImageList {
                let imageView = UIImageView()
                let fileUrl = URL(string: question as! String)
                if let data = try? Data(contentsOf: fileUrl!) {
                    if let image = UIImage(data: data) {
                        imageView.image = image
                    }
                }
                self.optionsView.addSubview(imageView)
                self.setQuestionImageViewConstraints(previousImageView: previousImageView, currentImageUIView: imageView)
                imageView.topAnchor.constraint(equalTo: self.quetionLabel.bottomAnchor, constant: 15).isActive = true
                previousImageView = imageView
            }
            
            
            let dragCircle = UILabel()
            dragCircle.text = "Drag Here"
            dragCircle.textColor = .darkGray
            self.optionsView.addSubview(dragCircle)
            dragCircle.translatesAutoresizingMaskIntoConstraints = false
            dragCircle.textAlignment = NSTextAlignment.center
            dragCircle.heightAnchor.constraint(equalToConstant: 100).isActive = true
            dragCircle.widthAnchor.constraint(equalToConstant: 100).isActive = true
            dragCircle.topAnchor.constraint(equalTo: previousImageView.bottomAnchor, constant: 15).isActive = true
            dragCircle.centerXAnchor.constraint(equalTo: self.optionsView.centerXAnchor).isActive = true
            dragCircle.layer.borderColor = UIColor.darkGray.cgColor
            dragCircle.layer.borderWidth = 1
            dragCircle.layer.cornerRadius = 50
            dragCircle.layer.masksToBounds = true
            
            let dropInteraction = UIDropInteraction(delegate: self)
            dragCircle.addInteraction(dropInteraction)
            dragCircle.isUserInteractionEnabled = true

            previousImageView = nil
            for option in optionList {
                let optionObject =  Option(option as! NSDictionary)
                
                self.imageView = UIImageView()
                
                    let fileUrl = URL(string: optionObject.ansImageUrl)
                    if let data = try? Data(contentsOf: fileUrl!) {
                        if let image = UIImage(data: data) {
                            self.imageView.image = image
                         //   self.imageView.backgroundColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
//                            let dragInteraction = UIDragInteraction(delegate: self)
//                            self.imageView.addInteraction(dragInteraction)
                           self.imageView.isUserInteractionEnabled = true
                        }
                    }
                self.optionsView.addSubview(self.imageView)
              

                self.setQuestionImageViewConstraints(previousImageView: previousImageView, currentImageUIView: self.imageView)
                self.imageView.topAnchor.constraint(equalTo: dragCircle.bottomAnchor, constant: 15).isActive = true
                previousImageView = self.imageView
                
            }
        }
    }
    
    func setQuestionImageViewConstraints(previousImageView: UIImageView!, currentImageUIView: UIImageView){
        currentImageUIView.contentMode = .scaleAspectFit
        currentImageUIView.translatesAutoresizingMaskIntoConstraints = false
        currentImageUIView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        currentImageUIView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        if previousImageView == nil {
            currentImageUIView.leadingAnchor.constraint(equalTo: self.optionsView.leadingAnchor, constant: 15).isActive = true
        }else {
            currentImageUIView.leadingAnchor.constraint(equalTo: previousImageView.trailingAnchor, constant: 15).isActive = true
        }
    }
    
    func generateSeekBarOptions(optionList: NSArray){
        
        let slider = UISlider()
        
            DispatchQueue.main.async {
                self.optionsView.addSubview(slider)
                slider.translatesAutoresizingMaskIntoConstraints = false
                slider.leadingAnchor.constraint(equalTo: self.optionsView.leadingAnchor, constant: 30)
                slider.trailingAnchor.constraint(equalTo: self.optionsView.trailingAnchor, constant: -30)
                slider.maximumValue = Float(optionList.count)
                slider.minimumValue = 0
                slider.isContinuous = false
                slider.addTarget(self, action: #selector(self.valueChanged(slider:)), for: .valueChanged)
                for option in optionList {
                    let optionObject =  Option(option as! NSDictionary)
                    let label = UILabel()
                    label.text = optionObject.ansText
                    self.optionsView.addSubview(label)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10).isActive = true
                    label.leadingAnchor.constraint(equalTo: slider.leadingAnchor, constant: 0).isActive = true
                    self.optionsView.addSubview(label)
                    
                }
            }
        
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let touchedPoint = session.location(in: self.view)
        if let touchedimgeiew = self.view.hitTest(touchedPoint, with: nil) as? UIImageView{
            let touchedimage = touchedimgeiew.image
            let provider = NSItemProvider(object: touchedimage!)
            let item = UIDragItem(itemProvider: provider)
            return [item]
            
        }
        
        return []
    }

    
    
    @objc func valueChanged(slider: UISlider) {
        // round the slider position to the nearest index of the numbers array
        let index = slider.value
        slider.setValue(index, animated: false)
        print("INDEX ON SLIDER IS HERE", index)
//        slider?.setValue(Float(index), animated: false)
       
    }
}
