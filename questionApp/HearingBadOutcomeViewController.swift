//
//  HearingBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/15/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class HearingBadOutcomeViewController: UIViewController {
    
    @IBOutlet weak var rangeChartView: BNTestRangeChartView!
    @IBOutlet weak var rangeChartLabel: UILabel!
    
    var parent = Parent()

    /** A Test containing the updated test history. This property should be set by the source view controller. */
    var test: Test?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.Hearing, .Load, .Bad)
        
        // Do any additional setup after loading the view.
        rangeChartView.config(startMonth: 0, endMonth: 12, successAgeInMonths: 3, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
        
        // font can't be set directly in storyboard for attributed string, set the label font here
        // make label's set attr string to a mutable so we can add attributes on
        var attrString:NSMutableAttributedString = NSMutableAttributedString(attributedString: rangeChartLabel.attributedText)
        
        // add font attribute
        attrString.addAttribute(NSFontAttributeName, value: UIFont(name: kOmnesFontMedium, size: 15)!, range: NSMakeRange(0, attrString.length))
        rangeChartLabel.attributedText = attrString
        
        // Initialize text in the view based on the test history.
        initializeViewFromTestHistory()
        
        // Schedule a local notification to remind the user to rerun this test.
        scheduleReminder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "hearingToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = TestNamesPresentable.hearing
        }
    }
    
    @IBAction func onHomeButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
        self.presentViewController(controller, animated: true, completion: nil);
        
    }
    
//    // Helper function formats text attributes for multiple substrings in label.
//    func applyTextAttributesToLabel() {
//        
//        let string = "Don't worry! Not all babies develop at the same rate. Try a louder sound this time, or a high-pitched squeaky toy."
//        
//        var attributedString = NSMutableAttributedString(string: string)
//        
//        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
//        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
//        
//        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, 53))
//        attributedString.addAttributes(boldAttributes, range: NSMakeRange(54, 60))
//        
//        infoLabel.attributedText = attributedString
//    }
    
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
            let string = "Don't worry! Not all babies develop at the same rate.\nTry a louder sound this time, or a high-pitched  squeaky toy."
            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:61)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Didn't react to sounds?"
            
            // update infoLabel
            let string = "Don't worry! Sometimes baby will find your face more interesting than the sound.\nTry a different sound next to his ear."
            applyTextAttributesToLabel(string, indexAtStartOfBold:81, countOfBoldCharacters:38)
            
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "Didn't react to sounds?"
            
            // update infoLabel
            let string = "Don't worry! If baby smiled, turned, or looked toward the sound, it counts! If not, repeat and record test to show your pediatrician."
            applyTextAttributesToLabel(string, indexAtStartOfBold:76, countOfBoldCharacters:57)
        } else {
            // update questionLabel
            questionLabel.text = "Didn't react to sounds?"
            
            // update infoLabel
            let string = "Don't worry! Not all babies develop at the same rate.\nTry a louder sound this time, or a high-pitched  squeaky toy."
            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:61)
        }
    }

    /*!
    @brief Schedule a local notification to remind the user to run the test again.
    @discussion The local notification is scheduled if it does not currently exist.
    */
    func scheduleReminder() {
        
        if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.hearing) == false {
            
            // configure the local notification
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.hearing, secondsBeforeDisplayingReminder: Test.NotificationInterval.hearing)
            
            // schedule the local notification
            localNotification.scheduleNotification()
        }
    }
}
