//
//  PartiallyCoveredToyTestOverviewViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 7/30/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PartiallyCoveredToyTestOverviewViewController: UIViewController {

    @IBOutlet weak var previewButton: UIButton!
    var playerVC:AVPlayerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.PartiallyCovered, .Load, .Overview)

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
        if segue.identifier == "pointFollowingEmbeddedVideoSegue" {
   
        }
        else if segue.identifier == "partiallyCoveredToyWhatWillYouNeedSegueID" {
        }
    }

    @IBAction func onBackTap(sender: BNBackButton) {
      self.dismissViewControllerAnimated(true, completion: nil)
    }
}
