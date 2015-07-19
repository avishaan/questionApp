//
//  SymmetryWhatDidYouSeeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/16/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SymmetryWhatDidYouSeeViewController: UIViewController {

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
        
        if segue.identifier == "symmetryGoodOutcomeSegueID" {
            
            // Record the successful symmetry test result and save it to the persistent store on disk.
            histories.addTestResult(testName: TestHistories.TestNames.symmetry, testResult: true)
            histories.save()
        
        } else if segue.identifier == "symmetryBadOutcomeSegueID" {
            
            // Record the failed symmetry test result and save it to the persistent store on disk.
            histories.addTestResult(testName: TestHistories.TestNames.symmetry, testResult: false)
            histories.save()
            
            // Pass the test results history to the destination VC.
            let controller = segue.destinationViewController as! SymmetryBadOutcomeViewController
            controller.histories = histories
        }
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
