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

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
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
    
    destination.player = AVPlayer(URL: url)
  }


}

