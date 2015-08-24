//
//  SymmetryBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/16/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SymmetryBadOutcomeViewController: UIViewController {
    
    @IBOutlet weak var rangeChartView: BNTestRangeChartView!
    @IBOutlet weak var rangeChartLabel: UILabel!

    /** A Test containing the updated test history. This property should be set by the source view controller. */
    var test: Test?

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    var parent = Parent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.Symmetry, .Load, .Bad)
        
        // Do any additional setup after loading the view.
        rangeChartView.config(startMonth: 0, endMonth: 12, successAgeInMonths: 4, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
        
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
        if segue.identifier == "symmetryToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = TestNamesPresentable.symmetry
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
            let string = "Not to worry! All babies develop at the different rates. Try again tomorrow."
            applyTextAttributesToLabel(string, indexAtStartOfBold:57, countOfBoldCharacters:19)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Still not symmetrical?"
            
            // update infoLabel
            let string = "Your baby may not have the motor skills to extend her arms or legs yet. Try again next month."
            applyTextAttributesToLabel(string, indexAtStartOfBold:72, countOfBoldCharacters:21)
            
        } else if failed == 3 {
            // update questionLabel
            questionLabel.text = "Still not symmetrical?"
            
            // update infoLabel
            let string = "Since your baby is under 12 months, she still has time to develop those muscles. If you're concerned, check with your pediatrician."
            applyTextAttributesToLabel(string, indexAtStartOfBold:81, countOfBoldCharacters:50)
        } else if failed >= 4 {
            // update questionLabel
            questionLabel.text = "Still not symmetrical?"
            
            // update infoLabel
            let string = "Are baby's limbs consistently weaker on one side? If yes, please check with your pediatrician during your next well-child visit."
            applyTextAttributesToLabel(string, indexAtStartOfBold:50, countOfBoldCharacters:78)
        } else {
            // update questionLabel
            questionLabel.text = "Not symmetrical?"
            
            // update infoLabel
            let string = "Not to worry! All babies develop at the different rates. Try again tomorrow."
            applyTextAttributesToLabel(string, indexAtStartOfBold:57, countOfBoldCharacters:19)
        }
    }
    
    /*!
    @brief Schedule a local notification to remind the user to run the test again.
    @discussion The local notification is scheduled if it does not currently exist.
    */
    func scheduleReminder() {
        
        if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.symmetry) == false {
            
            // configure the local notification
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.symmetry, secondsBeforeDisplayingReminder: Test.NotificationInterval.symmetry)
            
            // schedule the local notification
            localNotification.scheduleNotification()
        }
    }
}
