//
//  LanguageCognitiveMilestoneViewController.swift
//  questionApp
//
//  Created by john bateman on 7/7/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class LanguageCognitiveMilestoneViewController: UIViewController {

  var facebookShares = 0
  var numberOfShares = 0
  @IBOutlet weak var backgroundView: UIImageView!
  @IBOutlet weak var receptiveLanguage: BNButton!
  @IBOutlet weak var pointFollowButton: BNButton!
  @IBOutlet weak var jointAttentionButton: BNButton!
  @IBOutlet weak var completelyCoveredButton: BNButton!
  @IBOutlet weak var partiallyCoveredButton: BNButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.LanguageCognitiveMilestone, .Load)

        // Do any additional setup after loading the view.
     // facebookShares = BNFacebook.userShareCountFromFront()
      // to get number of shares made
      numberOfShares = BNSharingManager.getSharedTestCount()
      if let cropped = getCroppedBackgroundImage(backgroundView.image) {
        backgroundView.image = cropped
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    checkNumberOfShares()
    // hide tests based on current facebook share acount
//    if facebookShares < 1 {
//      partiallyCoveredButton.facebookDisabled()
//      pointFollowButton.facebookDisabled()
//    }
//    if facebookShares < 2 {
//    }
//    if facebookShares < 3 {
//      receptiveLanguage.facebookDisabled()
//    }
//    if facebookShares < 4 {
//      completelyCoveredButton.facebookDisabled()
//    }
  }

  
  
  //check and update the view based on number of shares
  
  func checkNumberOfShares() {
    numberOfShares = BNSharingManager.getSharedTestCount()
    if numberOfShares >= 1 {
      pointFollowButton.changeButtonTitle(Test.TestNamesPresentable.pointFollowing)
      partiallyCoveredButton.changeButtonTitle(Test.TestNamesPresentable.partiallyCoveredToy)
    }
    if numberOfShares >= 2 {
    }
    if numberOfShares >= 3 {
      receptiveLanguage.changeButtonTitle(Test.TestNamesPresentable.receptiveLanguage)
    }
    if numberOfShares >= 4 {
      completelyCoveredButton.changeButtonTitle(Test.TestNamesPresentable.completelyCoveredToy)
      
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


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "milestonesSegueID" {
            // Dismiss this view controller before modally presenting the milestones VC.
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func onMilestonesBarButtonItem(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func attentionAtADistanceButtonTap(sender: AnyObject) {
        let storyboard = UIStoryboard (name: "AttentionAtDistance", bundle: nil)
        let controller: WhyIsAttentionAtDistanceViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsAttentionAtDistanceStoryboardID") as! WhyIsAttentionAtDistanceViewController
        self.presentViewController(controller, animated: true, completion: nil);

    }
    @IBAction func partiallyCoveredToyButtonTap(sender: AnyObject) {
      let storyboard = UIStoryboard (name: "PartiallyCoveredToy", bundle: nil)
      let controller: WhyIsPartiallyCoveredToyViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPartiallyCoveredToyStoryboardID") as! WhyIsPartiallyCoveredToyViewController
      if partiallyCoveredButton.titleLabel?.text != "share to unlock test"{
        self.presentViewController(controller, animated: true, completion: nil)
      }else {
        showShareAlert()
      }
  }
  
    @IBAction func completelyCoveredToyButtonTap(sender: AnyObject) {
      let storyboard = UIStoryboard (name: "CompletelyCoveredToy", bundle: nil)
      let controller: WhyIsCompletelyCoveredToyViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCompletelyCoveredToyStoryboardID") as! WhyIsCompletelyCoveredToyViewController
      if completelyCoveredButton.titleLabel?.text != "share to unlock test"{
        self.presentViewController(controller, animated: true, completion: nil)
      }else {
        showShareAlert()
      }
    }
  
  @IBAction func onReceptiveLanguageTap(sender: AnyObject) {
    let storyboard = UIStoryboard (name: "ReceptiveLanguage", bundle: nil)
    let controller: WhyISReceptiveLanguageViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsReceptiveLanguageStoryboardID") as! WhyISReceptiveLanguageViewController
    if receptiveLanguage.titleLabel?.text != "share to unlock test"{
      self.presentViewController(controller, animated: true, completion: nil)
    }else {
      showShareAlert()
    }
  }
  @IBAction func onPointFollowTap(sender: AnyObject) {
    let storyboard = UIStoryboard (name: "PointFollowing", bundle: nil)
    let controller: WhyIsPointFollowingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPointFollowingStoryboardID") as! WhyIsPointFollowingViewController
    if pointFollowButton.titleLabel?.text != "share to unlock test"{
      self.presentViewController(controller, animated: true, completion: nil)
    }else {
      showShareAlert()
    }

  }
    @IBAction func jointAttentionButtonTap(sender: AnyObject) {
        let storyboard = UIStoryboard (name: "JointAttention", bundle: nil)
        let controller: WhyIsJointAttentionViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsJointAttentionStoryboardID") as! WhyIsJointAttentionViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
  
  @IBAction func onBackTap(sender: BNBackButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}
