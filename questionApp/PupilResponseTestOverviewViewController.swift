//
//  PupilResponseTestOverviewViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/28/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PupilResponseTestOverviewViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
	
	// analytics
	Tracker.createEvent(.PupilResponse, .Load, .Overview)
    
    // Do any additional setup after loading the view.
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
  }
    
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}
