//
//  VideoVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 14/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import AVFoundation


class VideoVC: UIViewController {
    
    
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var topView: UIView!
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    var isVideoPlaying = false
    
    var currentPosition : Int = 0
    var arrayTopic = [TopicList]()
    
    var calenderId = ""
    var topicId = ""
    var videoURl = ""
    var courseId = ""
    var correctAnsId = ""
    
    var fromType = ""
    var videoPosition : Float = 0

    
    var isStartFromFirst = false
    var isCalled = false
    var isEndPlaying = false
    
    var autoPlayCount = 0
    
    var closed = false
    var hidShowControls = true
    
    var currentQuesIndex = 0
    var currentExamID = ""
    var isLastQuestion = false
    var selectAnsID = ""
    var startTime: String = ""
    var currentQuesId : String = ""
    var selectedAnsText = ""
    
    var selectedTopicId = ""

    @IBOutlet var btnPlayAction: UIButton!
    
    //@IBOutlet var btnPlayAction: UIButton!
    
    
    var arrayExams = [KnowledgeList]()

    @IBOutlet var btnOption1: UIButton!
    
    @IBOutlet var btnOption2: UIButton!
    
    @IBOutlet var btnOption3: UIButton!
    
    
    @IBOutlet var btnOption4: UIButton!
    
    
    
    @IBOutlet var lblQuestion: UILabel!
    
  
    @IBOutlet var btnNextQues: UIButton!
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var viewQues: UIView!
    
   
    
    var arrayBehaviouralQuestion = [Question]()

    var isExamLoaded  = false
    
    @IBAction func nextQuestion_clicked(_ sender: Any) {
        
       // if self.isLastQuestion == true {
            
          //  self.viewQues.isHidden = true;
          //  player.play()
            
        //    self.loadSaveExamQuestionAnswer()

            
      //  }else{
            
            //self.currentQuesIndex = self.currentQuesIndex + 1
            //self.loadQuest()
            
            if self.selectAnsID == "" {
                
                let alert = GetAlertWithOKAction(message: "Select Answer")
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                self.loadSaveExamQuestionAnswer()
            }
            
      //  }
        
       
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var array1  = [TopicList]()
        var array2  = [TopicList]()
        
        for obj in self.arrayTopic{
            
            if obj.topicId == "0"{
                
                array2.append(obj)
                
            }else{
                
                array1.append(obj)
            }
        }
        
        if array2.count > 0{
            
            array1 = array1 + array2
            
            self.arrayTopic = array1
            
        }else{
            
            self.arrayTopic = array1

        }
        
        for (index,element) in self.arrayTopic.enumerated(){
            
            if element.topicId == self.selectedTopicId {
                self.currentPosition = index
            }
        }
       
      
        print("Sorted Array",self.arrayTopic)
        closed = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewQues.isHidden = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "quiz_bg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.viewQues.insertSubview(backgroundImage, at: 0)

        currentData()
     
        if self.currentPosition == 0 && self.arrayTopic[self.currentPosition].videoViewCount == 0
        {
            autoPlayCount = 0
            isStartFromFirst = true
        }
        
        self.hideControls()
        
        
    
        var videoURL = self.arrayTopic[self.currentPosition].topicVideoUrl
        if currentSelectedLang != "English" {
         videoURL = videoURL.replacingOccurrences(of: ".mp4", with: "_\(currentSelectedLang).mp4")
        }
        
        print(videoURL)
        
        let url = URL(string: videoURL )!
        player = AVPlayer(url: url)
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        
        self.timeSlider.maximumValue = 0
        self.timeSlider.minimumValue = 0
        self.timeSlider.value = 0
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        videoView.layer.addSublayer(playerLayer)
        
        addTopicAudit(videopostion: 0,status: "start")
        
        if self.arrayTopic[self.currentPosition].videoPosition != "" {
            let position = Int64(self.arrayTopic[self.currentPosition].videoPosition)
            player.seek(to: CMTimeMake(position!, 1000))
        }
        
    
         player.play()
        isVideoPlaying = !isVideoPlaying
        addTimeObserver()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.hideShow(sender:)))
        self.videoView.addGestureRecognizer(gesture)
        

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        
        let notificationCenter1 = NotificationCenter.default
        notificationCenter1.addObserver(self, selector: #selector(appMovedToFront), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        
        if player != nil {

       // player.pause()
       // self.btnPlayAction.setTitle("Play", for: .normal)
      //  self.btnPlayAction.setImage(UIImage(named: "icons_play"), for: UIControlState.normal)
        self.addTopicAudit(videopostion: Double(self.getMillisecond()),status: "pause")
        isVideoPlaying = !isVideoPlaying
       }
    }
    
    @objc func appMovedToFront() {
        print("App retur to front!")
        
        if player != nil {
            
            player.play()
            // self.btnPlayAction.setTitle("Pause", for: .normal)
            // self.btnPlayAction.setImage(UIImage(named: "icons_pause"), for: UIControlState.normal)
            self.addTopicAudit(videopostion: self.getMillisecond(),status: "start")
            isVideoPlaying = !isVideoPlaying
        }
        
       
        
    }
    
  
    
    func currentData(){
        
        calenderId = self.arrayTopic[self.currentPosition].calenderId
        topicId = self.arrayTopic[self.currentPosition].topicId
        self.lblTitle.text=self.arrayTopic[self.currentPosition].topicName
        
        if self.arrayExams.count > 0 {
            self.arrayExams.removeAll()
        }
        
        if self.arrayBehaviouralQuestion.count > 0 {
            self.arrayBehaviouralQuestion.removeAll()
        }
        
         currentQuesIndex = 0
         currentExamID = ""
         isLastQuestion = false
         isExamLoaded = false
        
        
        
        for exam in self.arrayTopic[self.currentPosition].topicLayouts {
            self.arrayExams.append(KnowledgeList( exam as! NSDictionary))
        }

    }
    
    func isExamPresent(dur : Float) -> Bool {
        
        if self.arrayExams.count > 0 {
        
        for e in 0...self.arrayExams.count - 1{
            
            //print("Curr Time",dur)
            //print("Stop Time",self.arrayExams[e].videoPosition)

            
            if dur <= (self.arrayExams[e].videoPosition + 500) && dur > self.arrayExams[e].videoPosition  {
                
                self.videoPosition = self.arrayExams[e].videoPosition
                self.currentExamID = self.arrayExams[e].examId
                self.arrayExams.remove(at: e)
                return true
            }
         }
            
        }
        
        return false
    }
    
    /*** Control hide and show methods ****/
    
    @objc func hideShow(sender : UITapGestureRecognizer){
        self.hidShowControls ? self.showControls() : self.hideControls()
    }

    func showControls(){
        self.topView.isHidden = false
        self.bottomView.isHidden = false
        self.hidShowControls = false
    }

    func hideControls(){
        self.topView.isHidden = true
        self.bottomView.isHidden = true
        self.hidShowControls = true
    }
    
    
    /** button controls ****/
    
    @IBAction func back_bt_pressesd(_ sender: UIButton) {
   
        let dur = self.getMillisecond()
        self.addTopicAudit(videopostion: dur,status: "quit")

    }
    
   
    
   /*** Method for next play ***/
 
    func playNext(){
        
        self.currentPosition = self.currentPosition + 1;
        
        print(self.currentPosition,"Current Position")
        print(self.arrayTopic.count,"Topic Count")

        
        if self.currentPosition < self.arrayTopic.count  {
        
        
        if  self.arrayTopic[self.currentPosition].topicId == "0" {
            
            
            
            isEndPlaying = true
            
            if self.autoPlayCount >= 1 {
                
              
                self.showExamPopup()
                
                
            }else{
                
                self.showRewindOption()
            }
            
            
            
        }else{
            
            self.isCalled = false
            currentData()
            
            player.pause()
            player.currentItem?.removeObserver(self, forKeyPath: "duration")
            player = nil
            
            
            
            var videoURL = self.arrayTopic[self.currentPosition].topicVideoUrl
            if currentSelectedLang != "English" {
                videoURL = videoURL.replacingOccurrences(of: ".mp4", with: "_\(currentSelectedLang).mp4")
            }
            
            print(videoURL)
        
            let url = URL(string: videoURL)!
            
            
            
            player = AVPlayer(url: url)
            player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
            
            self.timeSlider.maximumValue = 0
            self.timeSlider.minimumValue = 0
            self.timeSlider.value = 0
            
            // playerLayer = AVPlayerLayer(player: player)
            
            playerLayer.player = player
            
            
            playerLayer.videoGravity = .resize
            // videoView.layer.addSublayer(playerLayer)
            
            // if self.arrayTopic[self.currentPosition].topicStatus == "Pending"{
            addTopicAudit(videopostion: 0,status: "start")
            // }else{
            //    addTopicAudit(videopostion: 0,status: "start")
            // }
            
            player.play()
            isVideoPlaying = !isVideoPlaying
            addTimeObserver()
            
            
          }
            
        
    }else{
    
            isEndPlaying = true
            self.showRewindOption()
          
    }
    
}
    
    /*** Auto Play Method with position 0  **/
    
    func playAgain(){
        
        
        self.isCalled = false
        currentData();
        
        player.pause()
        player.currentItem?.removeObserver(self, forKeyPath: "duration")
        
        player = nil
        // playerLayer.removeFromSuperlayer()
        // playerLayer = nil
        
        
        var videoURL = self.arrayTopic[self.currentPosition].topicVideoUrl
        if currentSelectedLang != "English" {
            videoURL = videoURL.replacingOccurrences(of: ".mp4", with: "_\(currentSelectedLang).mp4")
        }
        
        print(videoURL)
        
        let url = URL(string: videoURL)!
        
        
        player = AVPlayer(url: url)
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        
        self.timeSlider.maximumValue = 0
        self.timeSlider.minimumValue = 0
        self.timeSlider.value = 0
        
        // playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.player = player
        
        
        playerLayer.videoGravity = .resize
        // videoView.layer.addSublayer(playerLayer)
        
        // if self.arrayTopic[self.currentPosition].topicStatus == "Pending"{
        addTopicAudit(videopostion: 0,status: "start")
        // }else{
        //    addTopicAudit(videopostion: 0,status: "start")
        // }
        
        player.play()
        isVideoPlaying = !isVideoPlaying
        addTimeObserver()
        
        
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    func addTimeObserver() {
        
        let calenderId = self.arrayTopic[self.currentPosition].calenderId
        
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using:
            { [weak self] time in
                
                
                if self?.closed == false {
                    
                    guard let currentItem = self?.player.currentItem else {return}
                    
                    if Float(currentItem.duration.seconds) >= 0 {
                        
                        self?.timeSlider.maximumValue = Float(currentItem.duration.seconds)
                        self?.timeSlider.minimumValue = 0
                        self?.timeSlider.value = Float(currentItem.currentTime().seconds)
                        self?.currentTimeLabel.text = self?.getTimeString(from: currentItem.currentTime())
                     
                      
                       
                        if (self?.isExamPresent(dur: Float(currentItem.currentTime().seconds * 1000)))!{
                            
                          
                            if self?.isExamLoaded == false{
                                self?.isExamLoaded = true
                                self?.player.pause()
                                self?.loadExam(calenderId:calenderId,examid: (self?.currentExamID)!)
                            }
                            
                            
                            
                        }
                        
                        
                        if self?.currentTimeLabel.text == self?.durationLabel.text && self?.durationLabel.text != "00:00"{
                            
                            //video completed play next
                            
                            if self?.isCalled == false {
                                self?.isCalled = true
                                self?.addTopicAudit(videopostion: (self?.getMillisecond())!,status: "complete")
                            }
                            
                        }
                    }
                    
                }
                
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func playPressed(_ sender: UIButton) {
        
        
        
        if isVideoPlaying {
            player.pause()
            sender.setTitle("Play", for: .normal)
            sender.setImage(UIImage(named: "icons_play"), for: UIControlState.normal)
            self.addTopicAudit(videopostion: Double(self.getMillisecond()),status: "pause")
            
            
        }else {
            player.play()
            sender.setTitle("Pause", for: .normal)
            sender.setImage(UIImage(named: "icons_pause"), for: UIControlState.normal)
            self.addTopicAudit(videopostion: self.getMillisecond(),status: "start")
            
            
        }
        
        // playNext()
        
        
        isVideoPlaying = !isVideoPlaying
    }
    
    
   
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        player.seek(to: CMTimeMake(Int64(sender.value*1000), 1000))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
            self.durationLabel.text = getTimeString(from: player.currentItem!.duration)
        }
    }
    
    func getTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
        }else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    }
    
    /*** API to add Topic ***/
    
    func addTopicAudit(videopostion:Double,status:String)
    {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = formatter.string(from: Date())
        
        
        let clientid = UserDefaults.standard.string(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let position = String(format: "%.f", videopostion)
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clientId":"\(clientid!)","courseId":"\(self.courseId)","calenderId":"\(self.calenderId)","topicId":"\(self.topicId)","videoPosition":"\(position)","language":"\(currentSelectedLang)"
            ,"dateTime":"\(currentDate)","status":"\(status)"] as Dictionary<String, String>
        
        print(params)
        
        //activityUIView.isHidden = false
        //activityUIView.startAnimation()
        MakeHttpPostRequest(url: userTopicsAudit, params: params, completion: {(success, response) -> Void in
            print(response)
            
            
            if status == "complete"{
                
                
                if self.currentExamID != "" {
                    
                    self.callEndTestAPI(examId : self.currentExamID)
                }
                
                
                
                if self.isStartFromFirst == true {
                
                        DispatchQueue.main.async {
                            self.playNext()
                    }
                    
                }else{
                    
                    
                    DispatchQueue.main.async {
                        self.closedPlayer()
                    }
                }
                
            }else if status == "quit" {
            
               DispatchQueue.main.async {
                    self.closedPlayer()
                }
            }
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        })
        
        
    }
    
    func showRewindOption(){
        
        let userAppLang1 = "English"
        let userAppLang2 = UserDefaults.standard.string(forKey: "Language2")
        
        if userAppLang1 == userAppLang2 {
            
            if self.currentPosition < self.arrayTopic.count {
                
                
                if  self.arrayTopic[self.currentPosition].topicId == "0" {
                    
                    self.showExamPopup()
                    
                }else{
                    
                    self.closedPlayer()
                    
                }
                
            }else{
                
                self.closedPlayer()

            }
         

                
            
            
        } else {
            
            let alertView = UIAlertController(title: "Congratulations!", message: "Dear \(USERDETAILS.firstName),you are doing great .To completely get Chocoed ,watch today’s videos in \(userAppLang2!) ", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Not Now", style: .default, handler: { (alert) in
                
                // closed player
                
               // self.closedPlayer()
                
               // self.showExamPopup()
                
                
                
                if self.currentPosition < self.arrayTopic.count {
                    
                        self.showExamPopup()
                    
                    
                }else{
                    
                    self.closedPlayer()
                    
                }
                
                
            })
            alertView.addAction(action)
            
            let actionSure = UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
                
                currentSelectedLang = userAppLang2!
                
                DispatchQueue.main.async {
                    
                    self.isCalled = false
                    self.isStartFromFirst = true
                    self.currentPosition = 0
                    self.playAgain()
                    self.autoPlayCount = 1
                }
                
            })
            alertView.addAction(actionSure)
            self.present(alertView, animated: true, completion: nil)
            
        }
        
        
       
        
    }
    
    
    func getMillisecond() -> Double{
        
        if self.player != nil
        {

        let currentTime = self.player.currentItem?.currentTime()
        let dur = CMTimeGetSeconds(currentTime!) * 1000
        return dur
            
        }
        
        return 0
    }
    
    
    /***** Orientation Related methods ***/
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.landscapeRight
    }
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeRight
    }
    
    /*** Play Closed ***/
    
    func closedPlayer(){
        if player != nil{
            player.pause()
            player.currentItem?.removeObserver(self, forKeyPath: "duration")
            player = nil
        }
       
        self.closed = true
        
        // add from choice
        
        
        if self.fromType == "choice"{
            
          /*  let v1 = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! TopicsStatusViewController
            self.present(v1, animated: true, completion: nil)
           */
            self.dismiss(animated: true, completion: nil)

            
        }else{
            
            let v1 = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
            self.present(v1, animated: true, completion: nil)
            
            
            
        }
        
       
       
        // self.dismiss(animated: true, completion: nil)
    
    }

    
    /*** Load Exam Details ****/
    
    func loadExam(calenderId: String,examid : String){
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(examid)","calendarId":"\(calenderId)","language":"\(currentSelectedLang)","position":"\(self.videoPosition.clean)"] as Dictionary<String, String>
        
        print(params)
        MakeHttpPostRequest(url: examKCDetails, params: params, completion: {(success, response) -> Void in
            print(response)

            self.arrayBehaviouralQuestion = [Question]()
            let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
            for (index, question) in questionsList.enumerated() {
                self.arrayBehaviouralQuestion.append(Question(question as! NSDictionary))
               
                /*if self.arrayBehaviouralQuestion[index].answerSubmitted == 0 && currentQuestionID == -1 {
                    currentQuestionID = index
                }*/
                
            }
        
            
            DispatchQueue.main.async {
                
                if(self.arrayBehaviouralQuestion.count > 0){
                    
                    self.viewQues.isHidden = false
                    self.loadQuest()
                }
                
            
        
            }
        
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    
    func loadQuest(){
        
        self.defaultButtons()
        
         selectAnsID = ""
         currentQuesId = ""
         selectedAnsText = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        self.startTime = formatter.string(from: Date())
        
        self.currentQuesId = self.arrayBehaviouralQuestion[self.currentQuesIndex].id
        
        self.lblQuestion.text = self.arrayBehaviouralQuestion[self.currentQuesIndex].questionName
        
        self.correctAnsId = self.arrayBehaviouralQuestion[self.currentQuesIndex].correctAnsId
        
        print(self.correctAnsId)
        
        self.btnOption1.isHidden = true
        self.btnOption2.isHidden = true
        self.btnOption3.isHidden = true
        self.btnOption4.isHidden = true


        
        var i = self.arrayBehaviouralQuestion[self.currentQuesIndex].option.count - 1
        
        while i >= 0   {
            
            let optionObject =  Option(self.arrayBehaviouralQuestion[self.currentQuesIndex].option[i] as! NSDictionary)

            if i == 3 {
              
                self.btnOption4.isHidden = false
                self.btnOption4.setTitle(optionObject.ansText, for: .normal)
            }
            
            if i == 2 {
               
                self.btnOption3.isHidden = false
                self.btnOption3.setTitle(optionObject.ansText, for: .normal)
            }
            
            if i == 1 {
                
               
                self.btnOption2.isHidden = false
                self.btnOption2.setTitle(optionObject.ansText, for: .normal)
            }
            
            if i == 0 {
                
               
                self.btnOption1.isHidden = false
                self.btnOption1.setTitle(optionObject.ansText, for: .normal)
            }
            
            
            i -= 1
        }
       
        
        if self.currentQuesIndex + 1  == self.arrayBehaviouralQuestion.count{
            self.btnNextQues.setTitle("Close", for: UIControlState.normal)
            self.isLastQuestion = true
        }else{
            self.btnNextQues.setTitle("Next", for: UIControlState.normal)
            self.isLastQuestion = false
        }

    }
    
    func showCorrectAns(){
        
        var i = self.arrayBehaviouralQuestion[self.currentQuesIndex].option.count - 1
        
        while i >= 0   {
            
            let optionObject =  Option(self.arrayBehaviouralQuestion[self.currentQuesIndex].option[i] as! NSDictionary)
            
            if i == 3 {
                
                if self.correctAnsId == optionObject.id  {
                    self.btnOption4.backgroundColor = self.getGreenColor()
                    return
                }else{
                   // self.btnOption4.backgroundColor = UIColor.red
                    

                }
            }
            
            if i == 2 {
                if self.correctAnsId == optionObject.id {
                    self.btnOption3.backgroundColor = self.getGreenColor()
                    return
                }else{
                  //  self.btnOption3.backgroundColor = UIColor.red
                    
                }
            }
            
            if i == 1 {
                if self.correctAnsId == optionObject.id {
                    self.btnOption2.backgroundColor = self.getGreenColor()
                    return
                }else{
                   // self.btnOption2.backgroundColor = UIColor.red
                    
                }
            }
            
            if i == 0 {
                if self.correctAnsId == optionObject.id {
                    self.btnOption1.backgroundColor = self.getGreenColor()
                    return
                }else{
                   // self.btnOption1.backgroundColor = UIColor.red
                    
                }
            }
            
            i -= 1
        }
        
    }
    
    
    @IBAction func option_a_clicked(_ sender: Any) {
        
        let optionObject =  Option(self.arrayBehaviouralQuestion[self.currentQuesIndex].option[0] as! NSDictionary)
        
        self.selectedAnsText = optionObject.ansText
        self.selectAnsID = optionObject.id
        self.defaultButtons()
       
        //print(self.correctAnsId)
        
        if self.correctAnsId == optionObject.id || self.correctAnsId == "0" {
            self.btnOption1.backgroundColor = self.getGreenColor()
        }else{
            self.btnOption1.backgroundColor = self.getRedColor()
            self.showCorrectAns()
        }
    
    }
    @IBAction func option_b_clicked(_ sender: Any) {
        
         let optionObject =  Option(self.arrayBehaviouralQuestion[self.currentQuesIndex].option[1] as! NSDictionary)
        
        self.selectedAnsText = optionObject.ansText
        self.selectAnsID = optionObject.id
        self.defaultButtons()
        
        print(self.correctAnsId)

        if self.correctAnsId == optionObject.id || self.correctAnsId == "0" {

            self.btnOption2.backgroundColor = self.getGreenColor()
            
        }else{
            self.btnOption2.backgroundColor = self.getRedColor()

            self.showCorrectAns()
        }
        
        
        
    
    }
    
    @IBAction func option_c_clicked(_ sender: Any) {
        
        
        let optionObject =  Option(self.arrayBehaviouralQuestion[self.currentQuesIndex].option[2] as! NSDictionary)
        
        self.selectedAnsText = optionObject.ansText
        self.selectAnsID = optionObject.id
        self.defaultButtons()
        
        print(self.correctAnsId)

        if self.correctAnsId == optionObject.id || self.correctAnsId == "0" {

            self.btnOption3.backgroundColor = self.getGreenColor()
            
        }else{
            self.btnOption3.backgroundColor = self.getRedColor()

            self.showCorrectAns()
        }
        

    }
    @IBAction func option_d_clicked(_ sender: Any) {
        
        let optionObject =  Option(self.arrayBehaviouralQuestion[self.currentQuesIndex].option[3] as! NSDictionary)
        self.defaultButtons()

        self.selectedAnsText = optionObject.ansText
        self.selectAnsID = optionObject.id
        print(self.correctAnsId)

        if self.correctAnsId == optionObject.id || self.correctAnsId == "0" {

            self.btnOption4.backgroundColor = self.getGreenColor()

        }else{
            self.btnOption4.backgroundColor = self.getRedColor()

            self.showCorrectAns()
        }
        
        
    }
    
    
    func defaultButtons(){
        
        
        self.btnOption1.titleLabel?.numberOfLines = 0
        self.btnOption1.layer.borderColor = UIColor.white.cgColor
        self.btnOption1.layer.borderWidth = 1
        self.btnOption1.layer.cornerRadius = 6  //self.btnOption1.frame.height / 2
        self.btnOption1.backgroundColor = .clear
        
        self.btnOption2.titleLabel?.numberOfLines = 0
        self.btnOption2.layer.borderColor = UIColor.white.cgColor
        self.btnOption2.layer.borderWidth = 1
        self.btnOption2.layer.cornerRadius = 6 //self.btnOption2.frame.height / 2
        self.btnOption2.backgroundColor = .clear
        
        self.btnOption3.titleLabel?.numberOfLines = 0
        self.btnOption3.layer.borderColor = UIColor.white.cgColor
        self.btnOption3.layer.borderWidth = 1
        self.btnOption3.layer.cornerRadius = 6 //self.btnOption3.frame.height / 2
        self.btnOption3.backgroundColor = .clear
        
        self.btnOption4.titleLabel?.numberOfLines = 0
        self.btnOption4.layer.borderColor = UIColor.white.cgColor
        self.btnOption4.layer.borderWidth = 1
        self.btnOption4.layer.cornerRadius = 6 //self.btnOption4.frame.height / 2
        self.btnOption4.backgroundColor = .clear
        
        
    }
  
    func loadSaveExamQuestionAnswer(){
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let endTime = formatter.string(from: Date())
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(self.currentExamID)","questionId":"\(self.currentQuesId)","selectedAns":"\(self.selectedAnsText)","selectedAnsId":"\(self.selectAnsID)","startTime":"\(startTime)","endTime":"\(endTime)"] as Dictionary<String, String>
        print(params)
        
        MakeHttpPostRequest(url: saveUserExamQuestionAnswer , params: params, completion: {(success, response) -> Void in
            print(response, "<<<<<<-- SAVE ANSWER RESPONSE....")
            
            
            DispatchQueue.main.async {
                
                if self.isLastQuestion == true {
                    
                   // self.callEndTestAPI()
                    
                    self.viewQues.isHidden = true;
                    self.isExamLoaded = false
                    self.currentQuesIndex = 0
                    self.player.play()
                    
                }else{
                    
                    self.currentQuesIndex = self.currentQuesIndex + 1
                    self.loadQuest()
                }
                
                
            }
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    
    func callEndTestAPI(examId : String) {
        
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let endTime = formatter.string(from: Date())
        
        
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(examId)", "endTime": "\(endTime)","calendarId":"\(self.calenderId)"] as Dictionary<String, String>
        print(params, "<<<<-- end test api")
       
        MakeHttpPostRequest(url: endExamAPI, params: params, completion: {(success, response) -> Void in
            print(response)
            
           /* DispatchQueue.main.async {
                
                self.viewQues.isHidden = true;
                self.isExamLoaded = false
                self.currentQuesIndex = 0
                self.player.play()
            } */
          
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    /** Load Same Day Assessment **/
    
    func showExamPopup(){
        
        
        
       
        
    if self.arrayTopic[self.currentPosition].examStatus != "Completed"{
        
        
        currentCourseId = self.courseId
        
        isLoadExamFromVideo = "1"
        isLoadExamId = self.arrayTopic[self.currentPosition].examId
        isLoadCalendarId = self.arrayTopic[self.currentPosition].calenderId
        isLoadExamName = self.arrayTopic[self.currentPosition].examName
        
        self.closedPlayer()
            
        }else{
            
            self.closedPlayer()

        }
        
    }
    
    /** Exam Assessment **/
    
    func loadExamAssessment(calendarId: String, examID : String, examName : String){
        
        let clientID = UserDefaults.standard.integer(forKey: "clientid")
        let userid = UserDefaults.standard.string(forKey: "userid")
        
        var currentQuestionID: Int =  -1
        let params = ["access_token":"\(accessToken)","userId":"\(userid!)","clienId":"\(clientID)","examId":"\(examID)","calendarId":"\(calenderId)"] as Dictionary<String, String>
        
        print(params)
        
        MakeHttpPostRequest(url: examDetails, params: params, completion: {(success, response) -> Void in
            
            
            let questionsList = response.object(forKey: "questionList") as? NSArray ?? []
            self.arrayBehaviouralQuestion = [Question]()
            for (index, question) in questionsList.enumerated() {
                self.arrayBehaviouralQuestion.append(Question(question as! NSDictionary))
                if self.arrayBehaviouralQuestion[index].answerSubmitted == 0 && currentQuestionID == -1 {
                    currentQuestionID = index
                }
            }
            
            DispatchQueue.main.async {
                
                if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "quizb") as? QuizBahaviouralViewController {
                    
                    currentCourseId = self.courseId
                    
                    vcNewSectionStarted.arrayBehaviouralQuestion = self.arrayBehaviouralQuestion
                    vcNewSectionStarted.currentExamID = Int(examID)!
                    vcNewSectionStarted.currentQuestion = currentQuestionID
                    vcNewSectionStarted.examName = examName
                    vcNewSectionStarted.fromType = "content"
                   let aObjNavi = UINavigationController(rootViewController: vcNewSectionStarted)
                    aObjNavi.navigationBar.barTintColor = UIColor.blue
                    self.present(vcNewSectionStarted, animated: true, completion: nil)
                    
                }
                
            }
            
            
        }, errorHandler: {(message) -> Void in
            let alert = GetAlertWithOKAction(message: message)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    
    func getGreenColor() -> UIColor {
        
        return self.hexStringToUIColor(hex: "#008000")
    }
    
    func getRedColor() -> UIColor {
        
        return self.hexStringToUIColor(hex: "#B22222")
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

extension Float {
    var clean : String{
      return  self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
