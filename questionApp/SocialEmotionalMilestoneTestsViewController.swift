//
//  SocialEmotionalMilestoneTestsViewController.swift
//  questionApp
//
//  Created by john bateman on 7/13/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SocialEmotionalMilestoneTestsViewController: UIViewController {
	
	@IBOutlet weak var facialMimicButton: BNButton!
	@IBOutlet weak var pointFollowButton: BNButton!
	var facebookShares = 0
  override func viewDidLoad() {
    super.viewDidLoad()
      // analytics
      Tracker.createEvent(.SocialEmotionalMilestone, .Load)
		// see how many times we shared from front page
		var facebookShares = BNFacebook.userShareCountFromFront()

		
    // Do any additional setup after loading the view.
  }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		// hide tests based on current facebook share acount
		if facebookShares < 1 {
			pointFollowButton.facebookDisabled()
		}
		if facebookShares < 2 {
			facialMimicButton.facebookDisabled()
		}
		if facebookShares < 3 {
		}
		if facebookShares < 4 {
		}
	}
	
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onMilestonesBarButtonItem(sender: UIBarButtonItem) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
    
  @IBAction func onSelfRecognitionButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "SelfRecognition", bundle: nil)
    var controller: WhyIsSelfRecognitionController = storyboard.instantiateViewControllerWithIdentifier("WhyIsSelfRecognitionStoryboardID") as! WhyIsSelfRecognitionController
    self.presentViewController(controller, animated: true, completion: nil);
  }
    
  @IBAction func onPointFollowingButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "PointFollowing", bundle: nil)
    var controller: WhyIsPointFollowingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPointFollowingStoryboardID") as! WhyIsPointFollowingViewController
    self.presentViewController(controller, animated: true, completion: nil);
  }

  @IBAction func onSocialSmilingButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "SocialSmiling", bundle: nil)
    var controller: WhyIsSocialSmilingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsSocialSmilingStoryboardID") as! WhyIsSocialSmilingViewController
    self.presentViewController(controller, animated: true, completion: nil);
  }

    @IBAction func onFacialMimicButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "FacialMimic", bundle: nil)
        var controller: WhyIsFacialMimicViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsFacialMimicStoryboardID") as! WhyIsFacialMimicViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
}
