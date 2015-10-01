//
//  ReceptiveLanguageTestOverviewViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/22/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ReceptiveLanguageTestOverviewViewController: UIViewController {
  @IBOutlet weak var previewButton: UIButton!
  var playerVC:AVPlayerViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // image is not the same resolution as other thumbnails
//    previewButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
//    previewButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
//    previewButton.imageView?.contentMode = .ScaleToFill
    
    // analytics
    Tracker.createEvent(.ReceptiveLanguage, .Load, .Overview)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
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
    if segue.identifier == "ReceptiveLanguageEmbeddedVideoSegue" {

    }
    else if segue.identifier == "ReceptiveLanguageWhatWillYouNeedSegueID" {

    }
  }
  

  @IBAction func onBackTap(sender: BNBackButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

}
