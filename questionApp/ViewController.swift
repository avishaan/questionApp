//
//  ViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

var moviePlayer:MPMoviePlayerController!

class ViewController: UIViewController {

  @IBOutlet weak var subView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let path = NSBundle.mainBundle().pathForResource("crawl", ofType:"mp4")
    let url = NSURL.fileURLWithPath(path!)
    moviePlayer = MPMoviePlayerController(contentURL: url)
    if let player = moviePlayer {
      player.view.frame = CGRectMake(0, 0, 500, 500)
//      player.view.frame = subView.frame
//      player.view.autoresizesSubviews = false
      player.view.autoresizingMask = UIViewAutoresizing()
      player.prepareToPlay()
      player.scalingMode = .AspectFit
      self.subView.addSubview(player.view)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

}

