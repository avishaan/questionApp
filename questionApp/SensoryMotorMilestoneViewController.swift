//
//  SensoryMotorMilestoneViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/27/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SensoryMotorMilestoneViewController: UIViewController {
  
  @IBOutlet weak var sittingUnassistedButton: BNButton!
  @IBOutlet weak var crawlButton: BNButton!
  @IBOutlet weak var symmetryButton: BNButton!
  @IBOutlet weak var sittingWhileReachingButton: BNButton!
  @IBOutlet var requirementCollection: [BNButton]!
  var testsAreEnabled = false
  var hasSharedFacebook:Bool = false
  var facebookShares = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
      // analytics
      Tracker.createEvent(.SensoryMotorMilestone, .Load)
  
    // check if any tests have been shared on Facebook
    hasSharedFacebook = BNFacebook.hasUserSharedTest()
    println("shared with FB \(hasSharedFacebook)")
    // see how many times we shared from front page
    facebookShares = BNFacebook.userShareCountFromFront()
    println("shared with FB # times \(facebookShares)")
    
    
  }
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    // hide tests based on current facebook share acount
    if facebookShares < 1 {
      //rolling back to front
    }
    if facebookShares < 2 {
      //symmetry
      self.symmetryButton.facebookDisabled()
      //sitting while reaching
      self.sittingWhileReachingButton.facebookDisabled()
    }
    if facebookShares <= 3 {
      // sitting unassited
      self.sittingUnassistedButton.facebookDisabled()
    }
    if facebookShares <= 4 {
      //crawl
      self.crawlButton.facebookDisabled()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onCrossingEyesButtonTap(sender: AnyObject) {
      var storyboard = UIStoryboard (name: "CrossingEyes", bundle: nil)
      var controller: WhyIsCrossingEyesViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCrossingEyesStoryboardID") as! WhyIsCrossingEyesViewController
      self.presentViewController(controller, animated: true, completion: nil);
  }
  
  @IBAction func onHearingButtonTap(sender: AnyObject) {
      var storyboard = UIStoryboard (name: "Hearing", bundle: nil)
      var controller: WhyIsHearingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsHearingStoryboardID") as! WhyIsHearingViewController
      self.presentViewController(controller, animated: true, completion: nil);
  }
  
  @IBAction func onCrawlButtonTap(sender: AnyObject) {
      var storyboard = UIStoryboard (name: "Main", bundle: nil)
      var controller: WhyIsCrawlingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCrawlingViewControllerStoryboardID") as! WhyIsCrawlingViewController
      self.presentViewController(controller, animated: true, completion: nil);
  }
  
  @IBAction func onSymmetryButtonTap(sender: AnyObject) {
      var storyboard = UIStoryboard (name: "Symmetry", bundle: nil)
      var controller: WhyIsSymmetryViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsSymmetryStoryboardID") as! WhyIsSymmetryViewController
      self.presentViewController(controller, animated: true, completion: nil);
  }
    
  @IBAction func onPincerButtonTap(sender: AnyObject) {
      var storyboard = UIStoryboard (name: "Pincer", bundle: nil)
      var controller: WhyIsPincerViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPincerStoryboardID") as! WhyIsPincerViewController
      self.presentViewController(controller, animated: true, completion: nil);
  }
    
  @IBAction func onUnassistedSittingButtonTap(sender: AnyObject) {
      var storyboard = UIStoryboard (name: "UnassistedSitting", bundle: nil)
      var controller: WhyIsUnassistedSittingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsUnassistedSittingStoryboardID") as! WhyIsUnassistedSittingViewController
      self.presentViewController(controller, animated: true, completion: nil);
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
