//
//  PlasticJarGoodOutcomeViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class PlasticJarGoodOutcomeViewController: UIViewController {

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
        test = profiles.getTest(parent.getCurrentProfileName(), testName: Test.TestNames.plasticJar)
        // If a reminder notification had previously been scheduled, remove it now that the test has been passed.
        BNLocalNotification.removeLocalNotification(Test.TestNamesPresentable.plasticJar)
      println("user has passed this test \(test.passedTests)")
      
        if test.passedTests > 0 {
            var storyboard = UIStoryboard (name: "Feedback", bundle: nil)
            var controller: FeedbackViewController = storyboard.instantiateViewControllerWithIdentifier("FeedbackStoryboardID") as! FeedbackViewController
            presentViewController(controller, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onHomeButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }

    @IBAction func onFacebookButtonTap(sender: AnyObject) {
        // Present post to facebook screen.
        BNFacebook.postToFacebook(self, testName: Test.TestNamesPresentable.plasticJar)
    }
}
