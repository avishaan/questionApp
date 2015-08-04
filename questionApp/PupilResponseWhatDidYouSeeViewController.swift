//
//  PupilResponseWhatDidYouSeeViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/29/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class PupilResponseWhatDidYouSeeViewController: UIViewController {
	
	var parent = Parent()
	var profiles = TestProfiles()
	var test = Test()

  override func viewDidLoad() {
    super.viewDidLoad()
    
		// Ensure current information for parent by reloading.
		parent = Parent()
		
		// Ensure current information for test profiles by reloading.
		profiles.initProfilesFromPersistentStore()
		
		// Get the test information.
		test = profiles.getTest(parent.getCurrentProfileName(), testName: Test.TestNames.pupilResponse)
  }
	
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		if segue.identifier == "PupilResponseGoodOutcomeSegueID" {
			
			// Record the successful symmetry test result and save it to the persistent store on disk.
			test.addTestResult(testResult: true)
			profiles.save()
			
		} else if segue.identifier == "PupilResponseBadOutcomeSegueID" || segue.identifier == "PupilResponseBadOutcomeSegueID2" || segue.identifier == "PupilResponseBadOutcomeSegueID3" {
			
			// Record the failed symmetry test result and save it to the persistent store on disk.
			test.addTestResult(testResult: false)
			profiles.save()
			
			// Pass the test results history to the destination VC.
			let controller = segue.destinationViewController as! PupilResponseBadOutcomeViewController
			controller.test = self.test
		}
	}
	
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
	
}
