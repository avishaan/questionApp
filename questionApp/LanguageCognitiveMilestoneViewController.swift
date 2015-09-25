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
      facebookShares = BNFacebook.userShareCountFromFront()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    // hide tests based on current facebook share acount
    if facebookShares < 1 {
      partiallyCoveredButton.facebookDisabled()
      pointFollowButton.facebookDisabled()
    }
    if facebookShares < 2 {
    }
    if facebookShares < 3 {
      receptiveLanguage.facebookDisabled()
    }
    if facebookShares < 4 {
      completelyCoveredButton.facebookDisabled()
    }
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
        var storyboard = UIStoryboard (name: "AttentionAtDistance", bundle: nil)
        var controller: WhyIsAttentionAtDistanceViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsAttentionAtDistanceStoryboardID") as! WhyIsAttentionAtDistanceViewController
        self.presentViewController(controller, animated: true, completion: nil);

    }
    @IBAction func partiallyCoveredToyButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "PartiallyCoveredToy", bundle: nil)
        var controller: WhyIsPartiallyCoveredToyViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPartiallyCoveredToyStoryboardID") as! WhyIsPartiallyCoveredToyViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
    @IBAction func completelyCoveredToyButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "CompletelyCoveredToy", bundle: nil)
        var controller: WhyIsCompletelyCoveredToyViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCompletelyCoveredToyStoryboardID") as! WhyIsCompletelyCoveredToyViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
  @IBAction func onReceptiveLanguageTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "ReceptiveLanguage", bundle: nil)
    var controller: WhyIsReceptiveLanguageViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsReceptiveLanguageStoryboardID") as! WhyIsReceptiveLanguageViewController
    self.presentViewController(controller, animated: true, completion: nil);
  }
  @IBAction func onPointFollowTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "PointFollowing", bundle: nil)
    var controller: WhyIsPointFollowingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPointFollowingStoryboardID") as! WhyIsPointFollowingViewController
    self.presentViewController(controller, animated: true, completion: nil);

  }
    @IBAction func jointAttentionButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "JointAttention", bundle: nil)
        var controller: WhyIsJointAttentionViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsJointAttentionStoryboardID") as! WhyIsJointAttentionViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
}
