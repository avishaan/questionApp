//
//  PupilResponseGoodOutcomeViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/29/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class PupilResponseGoodOutcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		// If a reminder notification had previously been scheduled, remove it now that the test has been passed.
		BNLocalNotification.removeLocalNotification(Test.TestNamesPresentable.pupilResponse)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

	@IBAction func onFacebookButtonTap(sender: AnyObject) {
		// Present post to facebook screen.
		BNFacebook.postToFacebook(self, testName: Test.TestNamesPresentable.pupilResponse)
	}
}
