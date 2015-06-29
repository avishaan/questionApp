//
//  IntroVideoViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class IntroVideoViewController: UIViewController {
  
  @IBOutlet weak var player: UIView!
  @IBOutlet weak var previewButton: UIButton!
  
  var playerVC:AVPlayerViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "introVideoSegue" {
      // set the playerVC as out destination
      playerVC = segue.destinationViewController as!
      AVPlayerViewController
      let path = NSBundle.mainBundle().pathForResource("IntroVideo", ofType: "mov")
      let url = NSURL.fileURLWithPath(path!)
      // let url = NSURL(string: "crawl.mp4") // for remote locations
      
      // hide player controls
      playerVC.showsPlaybackControls = false
      playerVC.hidesBottomBarWhenPushed = true
      playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill
      
      playerVC.player = AVPlayer(URL: url)
      // we start off paused, then we will play once the button is hit
      playerVC.player.pause()
    }
    
  }
  @IBAction func onPreviewButtonTap(sender: AnyObject) {
    // we know the sender is a button, cast accordingly
    var button = sender as! UIButton
    // hide this button
    button.hidden = true
    // play the video
    playerVC.player.play()
    
  }
  
  
}
