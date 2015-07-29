//
//  SelfRecognitionWhatDidYouSeeViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 7/24/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SelfRecognitionWhatDidYouSeeViewController: UIViewController {

    var histories = TestHistories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        histories.initHistoriesFromPersistentStore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "selfRecognitionGoodOutcomeSegueID" {
            
            // Record the successful self recognition test result and save it to the persistent store on disk.
            histories.addTestResult(testName: Test.TestNames.symmetry, testResult: true)
            histories.save()
        
        } else if segue.identifier == "selfRecognitionBadOutcomeSegueID" {
            
            // Record the failed self recognition test result and save it to the persistent store on disk.
            histories.addTestResult(testName: Test.TestNames.symmetry, testResult: false)
            histories.save()
            
            // Pass the test results history to the destination VC.
            let controller = segue.destinationViewController as! SelfRecognitionBadOutcomeViewController
            controller.histories = histories
        }
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
