//
//  PollOptionsViewController.swift
//  chocoed
//
//  Created by Tejal on 25/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class PollOptionsViewController: UIViewController {

    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var pageuiView: UIView!
    @IBOutlet weak var labelQuetion: UILabel!
    var selectedAnswer = ""
    var questionId = ""
    var currentQuestion = Int()
    var QuestionData = [getPollDataList]()
    var optionData = [getOptions]()
    let optionbutton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuizExamDetails()
        // Do any additional setup after loading the view.
    }

    @IBAction func SubmitAction(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadQuizExamDetails(){
        print("\(self.QuestionData)")
        self.labelQuetion.text = self.QuestionData[self.currentQuestion].question
        
        self.optionButtonfunction(voted: self.QuestionData[self.currentQuestion].Voted)
        
    }
    
    func optionButtonfunction(voted: String){
        print("ASNWER TYPE --->>>>>>>>>>>>", voted)
        let optionsList = self.QuestionData[self.currentQuestion].option

        switch voted {
        case "":
            generateTextOnlyOptions(optionList: optionsList, selectedAns: self.QuestionData[self.currentQuestion].namePoll)
            break
        default:
            print("somethig went wrong")
        }
    }
    
            

    class ResizableButton: UIButton {
        override var intrinsicContentSize: CGSize {
            let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
            let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
            
            return desiredButtonSize
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
        for subviews in self.optionView.subviews {
            if subviews is UIButton {
                let testButton = subviews as? UIButton
                testButton?.setImage(UIImage(named: "icons8-circle_filled_75"), for: .normal)
            }
        }
        sender.contentHorizontalAlignment = .left
        sender.setImage(UIImage(named: "icons8-connection_status_on_filled"), for: .normal)
        print(sender.tag, "Selected answer ID", self.QuestionData[self.currentQuestion].id, "<<<<<---- QUESTION ID")
        answerId = sender.tag
        if sender.titleLabel != nil && sender.titleLabel?.text != nil {
            selectedAnswer = (sender.titleLabel?.text)!
        }
        
        questionId = String (self.QuestionData[self.currentQuestion].id)
        print(answerId)
        print(questionId)
        
    }


}
