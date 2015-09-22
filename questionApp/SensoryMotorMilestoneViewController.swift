//
//  SensoryMotorMilestoneViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/27/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SensoryMotorMilestoneViewController: UIViewController {
  
  @IBOutlet var requirementCollection: [BNButton]!
  var testsAreEnabled = false
  var hasSharedFacebook:Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
      // analytics
      Tracker.createEvent(.SensoryMotorMilestone, .Load)
  
    // check if any tests have been shared on Facebook
  hasSharedFacebook = BNFacebook.hasUserSharedTest()
    println("shared with FB \(hasSharedFacebook)")
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onCrossingEyesButtonTap(sender: AnyObject) {
    if (hasSharedFacebook) {
      var storyboard = UIStoryboard (name: "CrossingEyes", bundle: nil)
      var controller: WhyIsCrossingEyesViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCrossingEyesStoryboardID") as! WhyIsCrossingEyesViewController
      self.presentViewController(controller, animated: true, completion: nil);
    }
  }
  
  @IBAction func onHearingButtonTap(sender: AnyObject) {
    if (hasSharedFacebook) {
      var storyboard = UIStoryboard (name: "Hearing", bundle: nil)
      var controller: WhyIsHearingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsHearingStoryboardID") as! WhyIsHearingViewController
      self.presentViewController(controller, animated: true, completion: nil);
    }
  }
  
  @IBAction func onCrawlButtonTap(sender: AnyObject) {
    if (hasSharedFacebook) {
      var storyboard = UIStoryboard (name: "Main", bundle: nil)
      var controller: WhyIsCrawlingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCrawlingViewControllerStoryboardID") as! WhyIsCrawlingViewController
      self.presentViewController(controller, animated: true, completion: nil);
    }
  }
  
  @IBAction func onSymmetryButtonTap(sender: AnyObject) {
    if (hasSharedFacebook) {
      var storyboard = UIStoryboard (name: "Symmetry", bundle: nil)
      var controller: WhyIsSymmetryViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsSymmetryStoryboardID") as! WhyIsSymmetryViewController
      self.presentViewController(controller, animated: true, completion: nil);
    }
  }
    
  @IBAction func onPincerButtonTap(sender: AnyObject) {
    if (hasSharedFacebook) {
      var storyboard = UIStoryboard (name: "Pincer", bundle: nil)
      var controller: WhyIsPincerViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPincerStoryboardID") as! WhyIsPincerViewController
      self.presentViewController(controller, animated: true, completion: nil);
    }
  }
    
  @IBAction func onUnassistedSittingButtonTap(sender: AnyObject) {
    if (hasSharedFacebook) {
      var storyboard = UIStoryboard (name: "UnassistedSitting", bundle: nil)
      var controller: WhyIsUnassistedSittingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsUnassistedSittingStoryboardID") as! WhyIsUnassistedSittingViewController
      self.presentViewController(controller, animated: true, completion: nil);
    }
  }
  
  @IBAction func onReachingWhileSittingButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "ReachingWhileSitting", bundle: nil)
    var controller: WhyIsReachingWhileSittingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsReachingWhileSittingStoryboardID") as! WhyIsReachingWhileSittingViewController
    self.presentViewController(controller, animated: true, completion: nil);
  }
  
  @IBAction func onRollingBackToFrontButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "RollingBackToFrontStoryboard", bundle: nil)
    var controller: WhyIsRollingBackToFrontViewController = storyboard.instantiateViewControllerWithIdentifier("RollingBackToFrontStoryboardID") as! WhyIsRollingBackToFrontViewController
    self.presentViewController(controller, animated: true, completion: nil);
  }
}
