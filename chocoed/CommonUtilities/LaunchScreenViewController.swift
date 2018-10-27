//
//  launchScreenViewController.swift
//  chocoed
//
//  Created by Tejal on 22/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import AVFoundation

class LaunchScreenViewController: UIViewController {
    var player: AVAudioPlayer?
    
    @IBOutlet weak var imageLogoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
        let Gif = UIImage.gifImageWithName("logo_1")
        imageLogoView.image = Gif
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    
    func playSound() {
        let url = Bundle.main.url(forResource: "chocoed_music", withExtension: "mp3")!
        
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
