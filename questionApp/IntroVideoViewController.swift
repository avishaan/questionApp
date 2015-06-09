//
//  IntroVideoViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import MediaPlayer

var moviePlayer : MPMoviePlayerController?

class IntroVideoViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    playVideo()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func playVideo() {
    
    // optional binding technique
    if let
      path = NSBundle.mainBundle().pathForResource("crawl", ofType:"mp4"),
      url = NSURL(fileURLWithPath: path),
      moviePlayer = MPMoviePlayerController(contentURL: url) {
        moviePlayer.view.frame = self.view.bounds
        moviePlayer.prepareToPlay()
        moviePlayer.scalingMode = .AspectFill
        self.view.addSubview(moviePlayer.view)
    } else {
      debugPrintln("Ops, something wrong when playing video.m4v")
    }
  }
  
  
}
