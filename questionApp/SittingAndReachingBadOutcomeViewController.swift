//
//  SittingAndReachingBadOutcomeViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/9/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SittingAndReachingBadOutcomeViewController: UIViewController {
  
    /** A Test containing the updated test history. This property should be set by the source view controller. */
    var test : Test?
    var parent = Parent()
  
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rangeChartView: BNTestRangeChartView!
    @IBOutlet weak var rangeChartLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize text in the view based on the test history.
        initializeViewFromTestHistory()
        
        // Schedule a local notification, once, to remind the user to rerun this test.
        scheduleReminderOnce()
        
        rangeChartView.config(startMonth: 0, endMonth: 12, successAgeInMonths: 6, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
        
        // font can't be set directly in storyboard for attributed string, set the label font here
        // make label's set attr string to a mutable so we can add attributes on
        var attrString:NSMutableAttributedString = NSMutableAttributedString(attributedString: rangeChartLabel.attributedText)
        
        // add font attribute
        attrString.addAttribute(NSFontAttributeName, value: UIFont(name: kOmnesFontSemiBold, size: 13)!, range: NSMakeRange(0, attrString.length))
        rangeChartLabel.attributedText = attrString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unassistedSittingToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = Test.TestNamesPresentable.sittingAndReaching
        }
    }
    
    @IBAction func onHomeButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
        self.presentViewController(controller, animated: true, completion: nil);
        
    }
    
    // Helper function formats text attributes for multiple substrings in label.
    func applyTextAttributesToLabel(string: String, indexAtStartOfBold index: Int, countOfBoldCharacters count: Int) {
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        
        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, index > 0 ? index - 1 : index))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(index, count))
        
        infoLabel.attributedText = attributedString
    }
    
    /*!
    @brief Initialize the text in the view based on the number of failed tests.
    */
    func initializeViewFromTestHistory() {
        var failed = 0
        if let failedCount = test?.failedTestsCount() {
            failed = failedCount
        }
        
        if failed <= 1 {
            // update infoLabel
            let string = "Not to worry. All babies develop at different rates. Try again in two weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:52, countOfBoldCharacters:24)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Not sitting & reaching?"
            
            // update infoLabel
            let string = "Try a smaller toy, and try placing it closer to baby to make it easier to reach. Try the test again in a month."
            applyTextAttributesToLabel(string, indexAtStartOfBold:80, countOfBoldCharacters:31)
            
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "Not sitting & reaching?"
            
            // update infoLabel
            let string = "If your baby goes past 20 months without being able to sit & reach, this may indicate neuromuscular problems. Talk to your pediatrician at your next appointment."
            applyTextAttributesToLabel(string, indexAtStartOfBold:109, countOfBoldCharacters:52)
        } else {
            // update questionLabel
            questionLabel.text = "Not sitting & reaching?"
            
            // update infoLabel
            let string = "Not to worry. All babies develop at different rates. Try again in two weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:52, countOfBoldCharacters:24)
        }
    }
    
    /*!
    @brief Schedule a local notification to remind the user to run the test again.
    @discussion The local notification is scheduled once, based on the number of failed tests. The number of previous failed tests that triggers the notification for each specific test is stored in the Test.LocalNotificationTrigger struct.
    */
    func scheduleReminderOnce() {
        var failed = 0
        if let failedCount = test?.failedTestsCount() {
            failed = failedCount
        }
        
        if failed == Test.LocalNotificationTrigger.sittingAndReaching {
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.sittingAndReaching, secondsBeforeDisplayingReminder: Test.NotificationInterval.sittingAndReaching)
            localNotification.scheduleNotification(self)
        }
    }
}
