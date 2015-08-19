//
//  FallingToyBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class FallingToyBadOutcomeViewController: UIViewController {

    /** A Test containing the updated test history. This property should be set by the source view controller. */
    var test: Test?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.AttentionAtDistance, .Load, .Bad)

        // Initialize text in the view based on the test history.
        initializeViewFromTestHistory()
        
        // Schedule a local notification, once, to remind the user to rerun this test.
        scheduleReminderOnce()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fallingToyToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            controller.testName = TestNamesPresentable.fallingToy
        }
    }

    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
            let string = "Not to worry. Baby is a bit too young for this skill.\nTry again in 2-4 weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:23)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Didn't look?"
            
            // update infoLabel
            let string = "Not to worry. Babies develop at different rates.\nTry again in 2 weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:49, countOfBoldCharacters:21)
            
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "Didn't look?"
            
            // update infoLabel
            let string = "Not to worry. Babies develop at different rates. Try dropping a hard toy that will make a sound on impact and see if baby looks down!"
            applyTextAttributesToLabel(string, indexAtStartOfBold:49, countOfBoldCharacters:84)
        } else {
            // update questionLabel
            questionLabel.text = "Didn't look?"
            
            // update infoLabel
            let string = "Not to worry. Baby is a bit too young for this skill.\nTry again in 2-4 weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:23)
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
        
        if failed >= Test.LocalNotificationTrigger.fallingToy {
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.fallingToy, secondsBeforeDisplayingReminder: Test.NotificationInterval.fallingToy)
            localNotification.scheduleNotification()
        }
    }
}
