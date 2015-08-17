//
//  FallingToyGoodOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class FallingToyGoodOutcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // If a reminder notification had previously been scheduled, remove it now that the test has been passed.
        BNLocalNotification.removeLocalNotification(Test.TestNamesPresentable.fallingToy)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onFacebookButtonTap(sender: AnyObject) {
        // Present post to facebook screen.
        BNFacebook.postToFacebook(self, testName: Test.TestNamesPresentable.fallingToy)
    }
}
