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
@IBOutlet weak var rollingBackFrontButton: BNButton!
  @IBOutlet weak var sittingWhileReachingButton: BNButton!
  @IBOutlet var requirementCollection: [BNButton]!
  var testsAreEnabled = false
  var hasSharedFacebook:Bool = false
  var facebookShares = 0
  var numberOfShares = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
      // analytics
      Tracker.createEvent(.SensoryMotorMilestone, .Load)
  
//    // check if any tests have been shared on Facebook
//    hasSharedFacebook = BNFacebook.hasUserSharedTest()
//    print("shared with FB \(hasSharedFacebook)")
//    // see how many times we shared from front page
//    facebookShares = BNFacebook.userShareCountFromFront()
//    print("shared with FB # times \(facebookShares)")
   // let unlockedTests = BNSharingManager.getListOfUnlockedTests()
    //  if unlockedTests.filter({ $0 == TestNamesPresentable}).count > 0
    
    
    // to get number of shares made
    numberOfShares = BNSharingManager.getSharedTestCount()
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    //update the view based on number of shares
    checkNumberOfShares()
    // hide tests based on current facebook share acount
//    if facebookShares < 1 {
//      //rolling back to front
//    }
//    if facebookShares < 2 {
//      //symmetry
//      self.symmetryButton.facebookDisabled()
//      //sitting while reaching
//      self.sittingWhileReachingButton.facebookDisabled()
//    }
//    if facebookShares < 3 {
//      // sitting unassited
//      self.sittingUnassistedButton.facebookDisabled()
//    }
//    if facebookShares < 4 {
//      //crawl
//      self.crawlButton.facebookDisabled()
//      rollingBackFrontButton.facebookDisabled()
//
//    }

    
  }
  
  // //check and update the view based on number of shares

  func checkNumberOfShares() {
    numberOfShares = BNSharingManager.getSharedTestCount()
    if numberOfShares > 1 {
      //rolling back to front
    }
    if numberOfShares >= 2 {
      self.symmetryButton.changeButtonTitle(Test.TestNamesPresentable.symmetry)
      self.sittingWhileReachingButton.changeButtonTitle(Test.TestNamesPresentable.reachingWhileSitting)
    }
    if numberOfShares >= 3 {
      self.sittingUnassistedButton.changeButtonTitle(Test.TestNamesPresentable.unassistedSitting)
    }
    if numberOfShares >= 4 {
      self.crawlButton.changeButtonTitle(Test.TestNamesPresentable.letsCrawl)
      self.rollingBackFrontButton.changeButtonTitle(Test.TestNamesPresentable.rollingBackToFront)
      }
   
  }
  
  //To show the popup when user clicks on share to unlock button
  
   func showShareAlert() {
    let alertView = UIAlertController(title: "Share to unlock tests", message: "Do you want to share the test?", preferredStyle: .Alert)
    alertView.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (alertAction) -> Void in
      BNSharingManager.presentShareSheet(self, testName: nil)
    }))
    alertView.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
    presentViewController(alertView, animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onCrossingEyesButtonTap(sender: AnyObject) {
    
     let storyboard = UIStoryboard (name: "CrossingEyes", bundle: nil)
      let controller: WhyIsCrossingEyesViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCrossingEyesStoryboardID") as! WhyIsCrossingEyesViewController
      self.presentViewController(controller, animated: true, completion: nil);
  }
  
  @IBAction func onHearingButtonTap(sender: AnyObject) {
      let storyboard = UIStoryboard (name: "Hearing", bundle: nil)
      let controller: WhyIsHearingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsHearingStoryboardID") as! WhyIsHearingViewController
      self.presentViewController(controller, animated: true, completion: nil);
  }
  
  @IBAction func onCrawlButtonTap(sender: AnyObject) {
      let storyboard = UIStoryboard (name: "Main", bundle: nil)
      let controller: WhyIsCrawlingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCrawlingViewControllerStoryboardID") as! WhyIsCrawlingViewController
      if self.crawlButton.titleLabel?.text != "share to unlock test"{
        self.presentViewController(controller, animated: true, completion: nil)
      }else {
        showShareAlert()
      }

  }
  
  @IBAction func onSymmetryButtonTap(sender: AnyObject) {
      let storyboard = UIStoryboard (name: "Symmetry", bundle: nil)
      let controller: WhyIsSymmetryViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsSymmetryStoryboardID") as! WhyIsSymmetryViewController
      if self.symmetryButton.titleLabel?.text != "share to unlock test"{
        self.presentViewController(controller, animated: true, completion: nil)
      }else {
        showShareAlert()
       
    }
  }
    
  @IBAction func onPincerButtonTap(sender: AnyObject) {
      let storyboard = UIStoryboard (name: "Pincer", bundle: nil)
      let controller: WhyIsPincerViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPincerStoryboardID") as! WhyIsPincerViewController
      self.presentViewController(controller, animated: true, completion: nil);
  }
    
  @IBAction func onUnassistedSittingButtonTap(sender: AnyObject) {
      let storyboard = UIStoryboard (name: "UnassistedSitting", bundle: nil)
      let  controller: WhyIsUnassistedSittingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsUnassistedSittingStoryboardID") as! WhyIsUnassistedSittingViewController
      if self.sittingUnassistedButton.titleLabel?.text != "share to unlock test"{
        self.presentViewController(controller, animated: true, completion: nil)
      } else {
      showShareAlert()
      }
    
  }
  @IBAction func onRollBackToFrontTap(sender: AnyObject) {
    let storyboard = UIStoryboard (name: "RollingBackToFrontStoryboard", bundle: nil)
    let controller: WhyIsRollingBackToFrontViewController = storyboard.instantiateViewControllerWithIdentifier("RollingBackToFrontStoryboardID") as! WhyIsRollingBackToFrontViewController
    self.presentViewController(controller, animated: true, completion: nil);

  }
  
  @IBAction func onReachingForToyTap(sender: AnyObject) {
    let  storyboard = UIStoryboard (name: "ReachingforToy", bundle: nil)
    let  controller: WhyIsReachingforToyViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsReachingforToyStoryboardID") as! WhyIsReachingforToyViewController
    self.presentViewController(controller, animated: true, completion: nil);

  }
  @IBAction func onVisualTrackingTap(sender: AnyObject) {
    let storyboard = UIStoryboard (name: "VisualTracking", bundle: nil)
    let controller: WhyIsVisualTrackingViewController = storyboard.instantiateViewControllerWithIdentifier("VisualTrackingStoryboardID") as! WhyIsVisualTrackingViewController
    self.presentViewController(controller, animated: true, completion: nil);
    
  }
  @IBAction func onReachingWhileSittingButtonTap(sender: AnyObject) {
    let storyboard = UIStoryboard (name: "ReachingWhileSitting", bundle: nil)
    let controller: WhyIsReachingWhileSittingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsReachingWhileSittingStoryboardID") as! WhyIsReachingWhileSittingViewController
    if self.sittingWhileReachingButton.titleLabel?.text != "share to unlock test"{
      self.presentViewController(controller, animated: true, completion: nil)
    }else {
      showShareAlert()
    }
  }
  
  @IBAction func onRollingBackToFrontButtonTap(sender: AnyObject) {
    let storyboard = UIStoryboard (name: "RollingBackToFrontStoryboard", bundle: nil)
    let
    controller: WhyIsRollingBackToFrontViewController = storyboard.instantiateViewControllerWithIdentifier("RollingBackToFrontStoryboardID") as! WhyIsRollingBackToFrontViewController
    if self.rollingBackFrontButton.titleLabel?.text != "share to unlock test"{
        self.presentViewController(controller, animated: true, completion: nil)
    }else {
      showShareAlert()
      
    }
  }
}
