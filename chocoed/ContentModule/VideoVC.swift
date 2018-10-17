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
    
    var isStartFromFirst = false
    var isCalled = false
    var isEndPlaying = false
    
    var autoPlayCount = 0
    
    var closed = false
    var hidShowControls = true
    
    
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet var currentTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closed = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentData()
        
        print(currentSelectedLang)

        
        if self.currentPosition == 0 && self.arrayTopic[self.currentPosition].videoViewCount == 0  {
            autoPlayCount = 0
            isStartFromFirst = true
        }
        
        self.hideControls()
        
        let videoURL = self.arrayTopic[self.currentPosition].topicVideoUrl
       /* if currentSelectedLang != "English" {
         videoURL = videoURL.replacingOccurrences(of: ".mp4", with: "_\(currentSelectedLang).mp4")
        } */
        
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
        
        
    }
    
    
    
    func currentData(){
        calenderId = self.arrayTopic[self.currentPosition].calenderId
        topicId = self.arrayTopic[self.currentPosition].topicId
        self.lblTitle.text=self.arrayTopic[self.currentPosition].topicName
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
        
        
        if  self.arrayTopic[self.currentPosition].topicId == "0" {
            
            
            
            isEndPlaying = true
            
            if self.autoPlayCount >= 1 {
                
                self.closedPlayer()
                
            }else{
                
                self.showRewindOption();
            }
            
            
            
        }else{
            
            self.isCalled = false
            currentData();
            
            player.pause()
            player.currentItem?.removeObserver(self, forKeyPath: "duration")
            player = nil
            
            
            
            let videoURL = self.arrayTopic[self.currentPosition].topicVideoUrl
          /*  if currentSelectedLang != "English" {
                videoURL = videoURL.replacingOccurrences(of: ".mp4", with: "_\(currentSelectedLang).mp4")
            } */
            
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
        
        
        let videoURL = self.arrayTopic[self.currentPosition].topicVideoUrl
       /* if currentSelectedLang != "English" {
            videoURL = videoURL.replacingOccurrences(of: ".mp4", with: "_\(currentSelectedLang).mp4")
        } */
        
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
                        
                        
                        if self?.currentTimeLabel.text == self?.durationLabel.text{
                            
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
                
                
                
                if self.isStartFromFirst == true {
                
                        DispatchQueue.main.async {
                            self.playNext()
                    }
                    
                }else{
                    
                    // show rewind option
                    
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
            
            self.closedPlayer()
            
        } else {
            
            let alertView = UIAlertController(title: "Choice", message: "Great! You completed todays topics. Would you like to replay the topics in \(userAppLang2!) ", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Not Now", style: .default, handler: { (alert) in
                
                // closed player
                
                self.closedPlayer()
                
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
        
        player.pause()
        player.currentItem?.removeObserver(self, forKeyPath: "duration")
        player = nil
        self.closed = true
        self.dismiss(animated: true, completion: nil)
        
    }
 
}
