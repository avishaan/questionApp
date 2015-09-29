//
//  SelfRecognitionBadOutcomeViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 7/24/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SelfRecognitionBadOutcomeViewController: UIViewController {
    @IBOutlet weak var rangeChartView: BNTestRangeChartView!
    @IBOutlet weak var rangeChartLabel: UILabel!
    
    /** A history of previous test outcomes. This property should be set by the source view controller. */
    var test:Test?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    var parent = Parent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.SelfRecognition, .Load, .Bad)
        
        // Do any additional setup after loading the view.
        rangeChartView.config(startMonth: 0, endMonth: 16, successAgeInMonths: 12, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
        
        // font can't be set directly in storyboard for attributed string, set the label font here
        // make label's set attr string to a mutable so we can add attributes on
        let attrString:NSMutableAttributedString = NSMutableAttributedString(attributedString: rangeChartLabel.attributedText!)
        
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
        if segue.identifier == "selfRecognitionToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = TestNamesPresentable.selfrecognition
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
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, index > 0 ? index - 1 : index))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(index, count))
        
        infoLabel.attributedText = attributedString
    }
    
    /*!
        @brief Initialize the text in the view based on the number of failed tests.
        @param testName (in) Name of the test. Must be of Test.TestNames.
    */
    func initializeViewFromTestHistory() {
        var failed = 0
        if let failedCount = test?.failedTestsCount() {
            failed = failedCount
        }
      
        if failed <= 1 {
            // update infoLabel
            let string = "Not to worry. Not all babies develop at the same rate.\nTry again and be sure baby is rested, fed, and alert."
//            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:21)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "No grasp?"
            
            // update infoLabel
          let string = "Sometimes practicing using a noisy toy, cereal, or ice cubes will help baby develop the pincer grasp.\nTry this, then perform the test again in 2 weeks."
//            applyTextAttributesToLabel(string, indexAtStartOfBold:134, countOfBoldCharacters:99)
          
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "No grasp?"
            
            // update infoLabel
          let string = "Perform this test a few more times to be sure the outcome is consistent. Remember to use small objects.\nIf problem persists and your baby is older than 12 months, record this test to show your pediatrician at your next visit."
//            applyTextAttributesToLabel(string, indexAtStartOfBold:81, countOfBoldCharacters:50)
        } else {
            // update questionLabel
            questionLabel.text = "No grasp?"
            
            // update infoLabel
            let string = "Not to worry. Baby is a bit too young for this skill.\nTry again in a month."
            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:21)
        }
    }
    
    /*!
    @brief Schedule a local notification to remind the user to run the test again.
    @discussion The local notification is scheduled if it does not currently exist.
    */
    func scheduleReminder() {
        
        if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.selfRecognition) == false {
            
            // configure the local notification
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.selfRecognition, secondsBeforeDisplayingReminder: Test.NotificationInterval.selfRecognition)
            
            // schedule the local notification
            localNotification.scheduleNotification()
        }
    }
}
