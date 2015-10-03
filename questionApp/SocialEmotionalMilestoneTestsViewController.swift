//
//  SocialEmotionalMilestoneTestsViewController.swift
//  questionApp
//
//  Created by john bateman on 7/13/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SocialEmotionalMilestoneTestsViewController: UIViewController {
	
	@IBOutlet weak var backgroundView: UIImageView!
	@IBOutlet weak var emotionalSecurityButton: BNButton!
	@IBOutlet weak var facialMimicButton: BNButton!
	@IBOutlet weak var emotionalAttachmentButton: BNButton!
	var facebookShares = 0
	var numberOfShares = 0
  override func viewDidLoad() {
    super.viewDidLoad()
      // analytics
      Tracker.createEvent(.SocialEmotionalMilestone, .Load)
		// see how many times we shared from front page
		//var facebookShares = BNFacebook.userShareCountFromFront()
		 numberOfShares = BNSharingManager.getSharedTestCount()
		if let cropped = getCroppedBackgroundImage(backgroundView.image) {
			backgroundView.image = cropped
		}
  }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		//update the view based on number of shares
		checkNumberOfShares()
//		// hide tests based on current facebook share acount
//		if facebookShares < 1 {
//		}
//		if facebookShares < 2 {
//			facialMimicButton.facebookDisabled()
//		}
//		if facebookShares < 3 {
//			emotionalSecurityButton.facebookDisabled()
//		}
//		if facebookShares < 4 {
//		}
	}
	
	
	
	//check and update the view based on number of shares
	
	func checkNumberOfShares() {
		numberOfShares = BNSharingManager.getSharedTestCount()
		if numberOfShares > 1 {
		}
		if numberOfShares >= 2 {
			facialMimicButton.changeButtonTitle(Test.TestNamesPresentable.facialMimic)
		}
		if numberOfShares >= 3 {
			emotionalSecurityButton.changeButtonTitle(Test.TestNamesPresentable.emotionalSecurity)
		}
		if numberOfShares >= 4 {
			
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
  
  @IBAction func onMilestonesBarButtonItem(sender: UIBarButtonItem) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
    
	@IBAction func onEmotionalSecurityTap(sender: AnyObject) {
		let storyboard = UIStoryboard (name: "EmotionalSecurity", bundle: nil)
		let controller: WhyIsEmotionalSecurityViewController  = storyboard.instantiateViewControllerWithIdentifier("WhyIsEmotionalSecurityStoryboardID") as! WhyIsEmotionalSecurityViewController
		if emotionalSecurityButton.titleLabel?.text != "share to unlock test"{
			self.presentViewController(controller, animated: true, completion: nil)
		}else {
			showShareAlert()
		}

	}
	@IBAction func onEmotionalAttachmentTap(sender: AnyObject) {
		let storyboard = UIStoryboard (name: "EmotionalAttachmentStoryboard", bundle: nil)
		let controller: WhyIsEmotionalAttachmentViewController  = storyboard.instantiateViewControllerWithIdentifier("WhyIsEmotionalAttachmentStoryboardID") as! WhyIsEmotionalAttachmentViewController
		self.presentViewController(controller, animated: true, completion: nil);
	}
  @IBAction func onSelfRecognitionButtonTap(sender: AnyObject) {
    let storyboard = UIStoryboard (name: "SelfRecognition", bundle: nil)
    let controller: WhyIsSelfRecognitionController = storyboard.instantiateViewControllerWithIdentifier("WhyIsSelfRecognitionStoryboardID") as! WhyIsSelfRecognitionController
    self.presentViewController(controller, animated: true, completion: nil);
  }
    
	@IBAction func onSocialSmilingButtonTap(sender: AnyObject) {
		let storyboard = UIStoryboard (name: "SocialSmiling", bundle: nil)
		let controller: WhyIsSocialSmilingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsSocialSmilingStoryboardID") as! WhyIsSocialSmilingViewController
		self.presentViewController(controller, animated: true, completion: nil);
	}
	
	@IBAction func onFacialMimicButtonTap(sender: AnyObject) {
		let storyboard = UIStoryboard (name: "FacialMimic", bundle: nil)
		let controller: WhyIsFacialMimicViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsFacialMimicStoryboardID") as! WhyIsFacialMimicViewController
		if facialMimicButton.titleLabel?.text != "share to unlock test"{
			self.presentViewController(controller, animated: true, completion: nil)
		}else {
			showShareAlert()
		}
	}
	
	@IBAction func onBackTap(sender: BNBackButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}
