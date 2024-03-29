//
//  RollingBacktoFrontTestOverviewViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/20/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class RollingBacktoFrontTestOverviewViewController: UIViewController {

  @IBOutlet weak var previewButton: UIButton!
  var playerVC:AVPlayerViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // analytics
    Tracker.createEvent(.RollingBackToFront, .Load, .Overview)
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    enableVideoReplay()
  }
  
  override func viewWillDisappear(animated: Bool) {
    NSNotificationCenter.defaultCenter().removeObserver(self)
    super.viewWillDisappear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "pointFollowingEmbeddedVideoSegue" {
      // set the playerVC as the destination
      playerVC = segue.destinationViewController as! AVPlayerViewController
      let path = NSBundle.mainBundle().pathForResource("rolling back to front", ofType: "mp4")
      let url = NSURL.fileURLWithPath(path!)
      // let url = NSURL(string: "crawl.mp4") // for remote locations
      
      // hide player controls
      playerVC.showsPlaybackControls = false
      playerVC.hidesBottomBarWhenPushed = true
      playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill
      
      playerVC.player = AVPlayer(URL: url)
      // we start off paused, then we will play once the button is hit
      //playerVC.player?.pause()
      
      // listen for video end notification
      NSNotificationCenter.defaultCenter().addObserver(self,
        selector: "enableVideoReplay",
        name: AVPlayerItemDidPlayToEndTimeNotification,
        object: playerVC.player?.currentItem)
    }
    else if segue.identifier == "rollingBackto FrontWhatWillYouNeedSegueID" {
      playerVC.player?.pause()
    }
  }
  
  func enableVideoReplay() {
    playerVC.player?.seekToTime(kCMTimeZero)
    // show button
    previewButton.hidden = false
  }
  
  @IBAction func onPreviewButtonTap(button: UIButton) {
    // hide button
    button.hidden = true
    // play the video
    playerVC.player?.play()
  }
  
  @IBAction func onBackTap(sender: BNBackButton) {
    playerVC.player?.pause()
    self.dismissViewControllerAnimated(true, completion: nil)
  }

}
