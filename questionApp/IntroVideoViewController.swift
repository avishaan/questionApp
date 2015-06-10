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
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let destination = segue.destinationViewController as!
				AVPlayerViewController
     let path = NSBundle.mainBundle().pathForResource("crawl", ofType: "mp4")
     let url = NSURL.fileURLWithPath(path!)
    // let url = NSURL(string: "crawl.mp4")
    destination.showsPlaybackControls = false
    destination.hidesBottomBarWhenPushed = true
    destination.videoGravity = AVLayerVideoGravityResizeAspectFill
    
    destination.player = AVPlayer(URL: url)
    // we start off paused, then we will play once the button is hit
    destination.player.pause()
  }
  
  
}
