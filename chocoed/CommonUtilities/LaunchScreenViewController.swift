//
//  launchScreenViewController.swift
//  chocoed
//
//  Created by Tejal on 22/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class LaunchScreenViewController: UIViewController {
    var player: AVAudioPlayer?
    
    @IBOutlet weak var imageLogoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        playSound()
        let Gif = UIImage.gifImageWithName("new_anim")
        imageLogoView.image = Gif
        // Do any additional setup after loading the view.
        
        InstanceID.instanceID().instanceID { (result, error) in
            
            if let error = error{
                print("<<<<< Error in FCM >>>>>>",error)
            }else if let result = result {
                UserDefaults.standard.set(result.token, forKey: "fcm")
                print(result.token , "<<<<< FCM >>>>>>")
            }
        }
        
       
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resurces that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        imageLogoView.image = nil
        self.player?.pause()
        self.player = nil
    }

   
    
    func playSound() {
        let url = Bundle.main.url(forResource: "music", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }
}
