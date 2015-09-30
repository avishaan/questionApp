//
//  SelfRecognitionTestOverviewViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 7/24/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SelfRecognitionTestOverviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.SelfRecognition, .Load, .Overview)
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
    
    func enableVideoReplay() {
    }
  
    @IBAction func onBackTap(sender: BNBackButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
