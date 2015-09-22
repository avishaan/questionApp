//
//  JointAttentionBadOutcomeViewController.swift
//  questionApp
//
//  Created by Michael Leung on 8/17/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class JointAttentionBadOutcomeViewController: UIViewController {
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
        
        // Schedule a local notification to remind the user to rerun this test.
        scheduleReminder()
        
        rangeChartView.config(startMonth: 0, endMonth: 40, successAgeInMonths: 30, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
        
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
        if segue.identifier == "JointAttentionToActivityReminderSegueID" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = TestNamesPresentable.plasticJar
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
            let string = "Not to worry. All babies develop at different rates. Try again in a month."
            applyTextAttributesToLabel(string, indexAtStartOfBold:53, countOfBoldCharacters:21)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Not Paying Attention?"
            
            // update infoLabel
            let string = "This is a slow-developing skill, so don’t be concerned. Keep “reading” with baby and pointing out images. Try the test again in a month."
            applyTextAttributesToLabel(string, indexAtStartOfBold:106, countOfBoldCharacters:30)
            
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "Not Paying Attention?"
            
            // update infoLabel
            let string = "A lack of joint attention skills past 30 months can be an early indicator for autism.Talk to your pediatrician at your next appointment."
            applyTextAttributesToLabel(string, indexAtStartOfBold:85, countOfBoldCharacters:51)
        } else {
            // update questionLabel
            questionLabel.text = "Not Paying Attention?"
            
            // update infoLabel
            let string = "Not to worry. All babies develop at different rates. Try again in a month."
            applyTextAttributesToLabel(string, indexAtStartOfBold:53, countOfBoldCharacters:21)
        }
    }
    
    /*!
    @brief Schedule a local notification to remind the user to run the test again.
    @discussion The local notification is scheduled if it does not currently exist.
    */
    func scheduleReminder() {
        
        if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.jointAttention) == false {
            
            // configure the local notification
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.jointAttention, secondsBeforeDisplayingReminder: Test.NotificationInterval.jointAttention)
            
            // schedule the local notification
            localNotification.scheduleNotification()
        }
    }
    
}