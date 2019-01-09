//
//  PollOptionsViewController.swift
//  chocoed
//
//  Created by Tejal on 25/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class PollOptionsViewController: UIViewController {

    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var pageuiView: UIView!
    @IBOutlet weak var labelQuetion: UILabel!
    var selectedAnswer = ""
    var questionId = ""
    var currentQuestion = Int()
    var QuestionData = [getPollDataList]()
    //var optionData = [getOptions]()
    let optionbutton = UIButton()
    var arrayOptionList = [Any]()
    
    var pollID = ""
    
    var pollType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuizExamDetails()
        // Do any additional setup after loading the view.
        
        
    }

    
    @IBAction func backBtn_clicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func SubmitAction(_ sender: Any) {
        savePollCall()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func savePollCall(){
        
        
        if self.arrayOptionList.count == 0 {
            
            let alert = GetAlertWithOKAction(message: "Select Answer")
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            
            return
        }
        
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userID = UserDefaults.standard.integer(forKey: "userid")
     
        var poststring = ""
            do{
        
            let postdat = try JSONSerialization.data(withJSONObject: arrayOptionList, options: JSONSerialization.WritingOptions.prettyPrinted)
        
            poststring = String(data : postdat,encoding : .utf8)!
        
        
                }catch{

            }
        poststring = String(poststring.filter {!" \n\t\r".contains($0)})
        poststring = poststring.replacingOccurrences(of: "'\'", with: "")
        
        let params = ["access_token":"\(accessToken)","userId": "\(userID)" ,"clientId":"\(clientID)","pollId": "\(self.pollID)" ,"optionList":poststring ] as Dictionary<String, Any>
            print(params)
        
        
            MakeHttpPostRequest(url: savepoll , params: params, completion: {(success, response) -> Void in
            print(response)
                
                let language = UserDefaults.standard.string(forKey: "currentlanguage")
                let alertView = UIAlertController(title: "Alert", message: "\("alertDear".localizableString(loc: language!)) \(USERDETAILS.firstName), Thank you for registering your choice.", preferredStyle: .alert)
                
                
                
                let action = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                    
                    if self.QuestionData[self.currentQuestion].ShowProgress == 1 {
                        
                        // show graph
                        
                        let optionVC = self.storyboard?.instantiateViewController(withIdentifier: "PollResultVC") as? PollResultVC
                        // optionVC?.optionData = arrayoptions
                        optionVC?.QuestionData = self.QuestionData
                        optionVC?.currentQuestion = self.currentQuestion
                        DispatchQueue.main.async {
                            self.present(optionVC!, animated: true, completion: nil)
                        }
                        
                    }else{
                        
                        // popup msg
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        
                    }
                    
                    
                })
                alertView.addAction(action)
                
                self.present(alertView, animated: true, completion: nil)


                
            }, errorHandler: {(message) -> Void in
                print(message)
                let alert = GetAlertWithOKAction(message:message)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            })
 
        
    }
    
    func loadQuizExamDetails(){
        print("\(self.QuestionData)")
        self.pollID = String(self.QuestionData[self.currentQuestion].id)
        self.pollType = self.QuestionData[self.currentQuestion].PollType
        self.lblTitle.text = self.QuestionData[self.currentQuestion].namePoll
        self.labelQuetion.text = self.QuestionData[self.currentQuestion].question
        self.optionButtonfunction()
        
    }
    
    func optionButtonfunction(){
        
        let optionsList = self.QuestionData[self.currentQuestion].option
        
        print(self.pollType,"<<Poll Type>>")
        
        DispatchQueue.main.async {

        
       if self.pollType  == "1" {
            
        self.generateTextOnlyOptions(optionList: optionsList, selectedAns: self.QuestionData[self.currentQuestion].namePoll)
        
       
        }else if self.pollType  == "2" {
            
        self.generateTextMultiOptions(optionList: optionsList, selectedAns: self.QuestionData[self.currentQuestion].namePoll)
        }
            
     }

     
    }
    
    class ResizableButton: UIButton {
        override var intrinsicContentSize: CGSize {
            let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
            let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
            
            return desiredButtonSize
        }
    }
    
    func generateTextMultiOptions(optionList: NSArray, selectedAns: String){
        var previousButton: ResizableButton!
        for option in optionList {
            let optionObject =  getOptions(option as! NSDictionary)
            DispatchQueue.main.async {
                //    y = y + 50
                //  print("value of y", y)
                var optionButton = ResizableButton()
                optionButton = ResizableButton(type: UIButtonType.custom)
                
                let option = optionObject.name
                optionButton.setTitle(option, for: .normal )
                optionButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
                optionButton.contentHorizontalAlignment = .left
                //var expand : CGFloat = 10.0
                optionButton.imageEdgeInsets = UIEdgeInsetsMake(-10, -20 , -10, 10)
                
                if optionObject.id == selectedAns {
                    optionButton.setImage(UIImage(named: "icons8-connection_status_on_filled"), for: .normal)
                }else {
                    optionButton.setImage(UIImage(named: "icons8-circle_filled_75"), for: .normal)
                }
                
                optionButton.titleLabel?.minimumScaleFactor = 0.5
                optionButton.titleLabel?.numberOfLines = 0
                optionButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                optionButton.titleLabel?.adjustsFontSizeToFitWidth =  true
                // let sizebnt = optionButton.titleLabel?.frame.size.height
                // optionButton.heightAnchor.constraint(equalToConstant: sizebnt!).isActive = true
                // print(sizebnt)
                optionButton.tag = Int(optionObject.id)!
                optionButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                self.optionView.addSubview(optionButton)
                self.setOptionButtonConstraint(previousButton: previousButton , currentButton: optionButton)
                previousButton = optionButton
            }
        }
    }
    
    func generateTextOnlyOptions(optionList: NSArray, selectedAns: String){
        var previousButton: ResizableButton!
        for option in optionList {
            let optionObject =  getOptions(option as! NSDictionary)
            DispatchQueue.main.async {
                //    y = y + 50
                //  print("value of y", y)
                var optionButton = ResizableButton()
                optionButton = ResizableButton(type: UIButtonType.custom)
                
                let option = optionObject.name
                optionButton.setTitle(option, for: .normal )
                optionButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
                optionButton.contentHorizontalAlignment = .left
                //var expand : CGFloat = 10.0
                optionButton.imageEdgeInsets = UIEdgeInsetsMake(-10, -20 , -10, 10)
                
                if optionObject.id == selectedAns {
                    optionButton.setImage(UIImage(named: "icons8-connection_status_on_filled"), for: .normal)
                }else {
                    optionButton.setImage(UIImage(named: "icons8-circle_filled_75"), for: .normal)
                }
                
                optionButton.titleLabel?.minimumScaleFactor = 0.5
                optionButton.titleLabel?.numberOfLines = 0
                optionButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                optionButton.titleLabel?.adjustsFontSizeToFitWidth =  true
                // let sizebnt = optionButton.titleLabel?.frame.size.height
                // optionButton.heightAnchor.constraint(equalToConstant: sizebnt!).isActive = true
                // print(sizebnt)
                optionButton.tag = Int(optionObject.id)!
                optionButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                self.optionView.addSubview(optionButton)
                self.setOptionButtonConstraint(previousButton: previousButton , currentButton: optionButton)
                previousButton = optionButton
            }
        }
    }
    func setOptionButtonConstraint(previousButton: ResizableButton!, currentButton: ResizableButton) {
        currentButton.translatesAutoresizingMaskIntoConstraints = false
        if previousButton != nil {
            currentButton.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 20).isActive =  true
            
        }else {
            currentButton.topAnchor.constraint(equalTo: self.optionView.topAnchor, constant: 20).isActive = true
            
        }
        currentButton.leadingAnchor.constraint(equalTo: self.optionView.leadingAnchor, constant: 40).isActive =  true
        currentButton.trailingAnchor.constraint(equalTo: self.optionView.trailingAnchor, constant: -5).isActive = true
        
    }
    
    @objc func pressed(sender: UIButton!) {
        print("button Pressed")
        
        if self.pollType  == "1" {
           
            for subviews in self.optionView.subviews {
                if subviews is UIButton {
                    let testButton = subviews as? UIButton
                    testButton?.setImage(UIImage(named: "icons8-circle_filled_75"), for: .normal)
                }
            }
            
            sender.setImage(UIImage(named: "icons8-connection_status_on_filled"), for: .normal)

            
        }else{
            
            sender.setImage(UIImage(named: "icons8-connection_status_on_filled"), for: .normal)

        }
        
       
        sender.contentHorizontalAlignment = .left
        print(sender.tag, "Selected answer ID", self.QuestionData[self.currentQuestion].id, "<<<<<---- QUESTION ID")
        answerId = sender.tag
        if sender.titleLabel != nil && sender.titleLabel?.text != nil {
            selectedAnswer = (sender.titleLabel?.text)!
        }
        
        questionId = String (self.QuestionData[self.currentQuestion].id)
        print(answerId)
        print(questionId)
        
        if self.pollType  == "1" {
             if arrayOptionList.count > 0{
                arrayOptionList.removeAll()
              }
        }
        
      
        
        let addSelectedAnswer = ["id": answerId,"name" : "\(selectedAnswer)"] as Dictionary<String,Any>
        arrayOptionList.append(addSelectedAnswer)
        
    }


}
