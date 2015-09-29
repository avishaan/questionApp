//
//  PointFollowingBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/13/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class PointFollowingBadOutcomeViewController: UIViewController {

    @IBOutlet weak var rangeChartView: BNTestRangeChartView!
    @IBOutlet weak var rangeChartLabel: UILabel!
    
  @IBOutlet weak var boldLabel: UILabel!
    /** A Test containing the updated test history. This property should be set by the source view controller. */
    var test: Test?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    var parent = Parent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.PointFollowing, .Load, .Bad)
//
        // Do any additional setup after loading the view.
        rangeChartView.config(startMonth: 0, endMonth: 20, successAgeInMonths: 12, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
        
        // font can't be set directly in storyboard for attributed string, set the label font here
        // make label's set attr string to a mutable so we can add attributes on
        let attrString:NSMutableAttributedString = NSMutableAttributedString(attributedString: rangeChartLabel.attributedText!)
        
        // add font attribute
        attrString.addAttribute(NSFontAttributeName, value: UIFont(name: kOmnesFontMedium, size: 15)!, range: NSMakeRange(0, attrString.length))
        rangeChartLabel.attributedText = attrString
//
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
        if segue.identifier == "pointFollowingToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            controller.testName = TestNamesPresentable.pointFollowing
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
            infoLabel.text = "Not to worry. Not all babies develop at the same rate."
            boldLabel.text = "Try again and be sure baby is rested, fed, and alert."
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Didn't look?"
            
            // update infoLabel
            infoLabel.text = "Try a noisy object or have another person make some noise to attract baby's attention."
            boldLabel.text = "Try this, if baby still doesn't react, try the test again in 3 weeks."
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "Didn't look?"
            
            // update infoLabel
          infoLabel.text = "This is a complicated task! Baby needs to understand both language and gestures to succeed."
          boldLabel.text = "If baby continues to fail the test and is over age 1, please record the test and check with your pediatrician."
        } else {
            // update questionLabel
            questionLabel.text = "Didn't look?"
            
            // update infoLabel
          infoLabel.text = "Not to worry. Not all babies develop at the same rate."
            boldLabel.text = "Try again and be sure baby is rested, fed, and alert."

        }
    }

    /*!
    @brief Schedule a local notification to remind the user to run the test again.
    @discussion The local notification is scheduled if it does not currently exist.
    */
    func scheduleReminder() {
        
        if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.pointFollowing) == false {
            
            // configure the local notification
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.pointFollowing, secondsBeforeDisplayingReminder: Test.NotificationInterval.pointFollowing)
            
            // schedule the local notification
            localNotification.scheduleNotification()
        }
    }
}
