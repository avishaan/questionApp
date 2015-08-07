//
//  FacialMimicWhatDidYouSeeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/29/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class FacialMimicWhatDidYouSeeViewController: UIViewController {

    var parent = Parent()
    var profiles = TestProfiles()
    var test = Test()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printDebugInfo("viewDidLoad")
//        println("viewDidLoad() start - failed test count: \(test.history.countOfFailedTests), total test count: \(test.history.countOfCompletedTests)")
//        println("Profile TestHistories for \(parent.getCurrentProfileName()): \(profiles.getTestHistories(profileName: parent.getCurrentProfileName()))" )
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //println("viewWillAppear() start - failed test count: \(test.history.countOfFailedTests), total test count: \(test.history.countOfCompletedTests)")
        printDebugInfo("viewWillAppear start")
        
        // Ensure current information for parent by reloading.
        parent = Parent()
        
        // Ensure current information for test profiles by reloading.
        profiles.initProfilesFromPersistentStore()
        
        printDebugInfo("viewDidAppear middle")
        
        // Get the test information.
        //println("profile name: \(parent.getCurrentProfileName())")
        test = profiles.getTest(parent.getCurrentProfileName(), testName: Test.TestNames.FacialMimic)
        printDebugInfo("viewDidAppear end")
        //println("viewWillAppear() end - failed test count: \(test.history.countOfFailedTests), total test count: \(test.history.countOfCompletedTests)")
        //println("Profile TestHistories for \(parent.getCurrentProfileName()): \(profiles.getTestHistories(profileName: parent.getCurrentProfileName()))" )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "FacialMimicGoodOutcomeSegueID" {
            
            // Record the successful symmetry test result and save it to the persistent store on disk.
            test.addTestResult(testResult: true)
            profiles.save()
            
        } else if segue.identifier == "FacialMimicBadOutcomeSegueID" {
            
            //println("prepareForSegue() start - failed test count: \(test.history.countOfFailedTests), total test count: \(test.history.countOfCompletedTests)")
            
            printDebugInfo("prepareForSegue start")
            
            // Record the failed symmetry test result and save it to the persistent store on disk.
            test.addTestResult(testResult: false)
            profiles.save()
            
            let emptyString = ""
            //println("prepareForSegue() mid - failed test count: \(test.history.countOfFailedTests), total test count: \(test.history.countOfCompletedTests), profiles: \(profiles.testProfiles[emptyString]?.failedTestsCount(testName: Test.TestNames.FacialMimic))")
            printDebugInfo("prepareForSegue middle")
            
            // Pass the test results history to the destination VC.
            let controller = segue.destinationViewController as! FacialMimicBadOutcomeViewController
            controller.test = self.test
            
            //println("prepareForSegue() end - failed test count: \(test.history.countOfFailedTests), total test count: \(test.history.countOfCompletedTests)")
            printDebugInfo("prepareForSegue end")
        }
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func printDebugInfo(codeLocation : String) {
        println("code location: \(codeLocation)")
        println("profile name: \(parent.getCurrentProfileName())")
        println("failed test count: \(test.history.countOfFailedTests), total test count: \(test.history.countOfCompletedTests)")
        println("profile: \(profiles.getTestHistories(profileName: profiles.makeProfileName(parentName: parent.fullName!, babyName: parent.babyName!)))")
        //println("Profile TestHistories for \(parent.getCurrentProfileName()): \(profiles.getTestHistories(profileName: parent.getCurrentProfileName()))" )

    }

}
