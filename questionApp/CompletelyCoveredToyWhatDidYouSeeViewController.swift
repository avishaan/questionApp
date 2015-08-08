//
//  CompletelyCoveredToyWhatDidYouSeeViewController.swift
//  questionApp
//
//  Created by daniel hsu on 8/7/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class CompletelyCoveredToyWhatDidYouSeeViewController: UIViewController {

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
        test = profiles.getTest(parent.getCurrentProfileName(), testName: Test.TestNames.partiallyCoveredToy)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "CompletelyCoveredToyGoodOutcomeSegueID" {
            
            // Record the successful symmetry test result and save it to the persistent store on disk.
            test.addTestResult(testResult: true)
            profiles.save()
            
        } else if segue.identifier == "CompletelyCoveredToyBadOutcomeSegueID" || segue.identifier == "CompletelyCoveredToyBadOutcomeSegueID2" {
            
            // Record the failed symmetry test result and save it to the persistent store on disk.
            test.addTestResult(testResult: false)
            profiles.save()
            
            // Pass the test results history to the destination VC.
            let controller = segue.destinationViewController as! CompletelyCoveredToyBadOutcomeViewController
            controller.test = self.test
        }
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
