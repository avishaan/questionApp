//
//  LanguageCognitiveIntroViewController.swift
//  questionApp
//
//  Created by john bateman on 7/7/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LanguageCognitiveIntroViewController: UIViewController {

    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var player: UIView!
    
    var playerVC:AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LanguageCognitiveTutorialVideoSegue" {
            // set the playerVC as the destination
            playerVC = segue.destinationViewController as! AVPlayerViewController
            let path = NSBundle.mainBundle().pathForResource("FallingToy", ofType: "mp4")
            let url = NSURL.fileURLWithPath(path!)
            // let url = NSURL(string: "crawl.mp4") // for remote locations
            
            // hide player controls
            playerVC.showsPlaybackControls = false
            playerVC.hidesBottomBarWhenPushed = true
            playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            playerVC.player = AVPlayer(URL: url)
            // we start off paused, then we will play once the button is hit
            playerVC.player?.pause()
            
            // listen for video end notification
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "enableVideoReplay",
                name: AVPlayerItemDidPlayToEndTimeNotification,
                object: playerVC.player?.currentItem)
        }
    }
    
    func enableVideoReplay() {
        playerVC.player?.seekToTime(kCMTimeZero)
        // show button
        previewButton.hidden = false
    }
    
    @IBAction func onPreviewButtonTap(button: UIButton) {
        // hide this button
        button.hidden = true
        
        // play the video
        playerVC.player?.play()
    }
}
