//
//  PlasticJarGoodOutcomeViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class PlasticJarGoodOutcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If a reminder notification had previously been scheduled, remove it now that the test has been passed.
        BNLocalNotification.removeLocalNotification(Test.TestNamesPresentable.plasticJar)
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
