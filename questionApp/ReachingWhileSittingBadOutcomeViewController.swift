//
//  ReachingWhileSittingBadOutcomeViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/9/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class ReachingWhileSittingBadOutcomeViewController: UIViewController {
  
    /** A Test containing the updated test history. This property should be set by the source view controller. */
    var test : Test?
    var parent = Parent()
  
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rangeChartView: BNTestRangeChartView!
    @IBOutlet weak var rangeChartLabel: UILabel!
    
  @IBOutlet weak var boldLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      // analytics
      Tracker.createEvent(.SittingReaching, .Load, .Bad)
        
        // Initialize text in the view based on the test history.
        initializeViewFromTestHistory()
        
        // Schedule a local notification to remind the user to rerun this test.
        scheduleReminder()
        
        rangeChartView.config(startMonth: 0, endMonth: 12, successAgeInMonths: 9, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
        
        // font can't be set directly in storyboard for attributed string, set the label font here
        // make label's set attr string to a mutable so we can add attributes on
        let attrString:NSMutableAttributedString = NSMutableAttributedString(attributedString: rangeChartLabel.attributedText!)
        
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

// NOTE: Replaced ActivityReminderViewController with automatic notification.
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "unassistedSittingToActivityReminderSegue" {
//            let controller = segue.destinationViewController as! ActivityReminderViewController
//            
//            // set the test name on the ActivityReminder VC
//            controller.testName = Test.TestNamesPresentable.reachingWhileSitting
//        }
//    }
    
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
            boldLabel.text = " Try again and be sure baby is rested, fed, and alert."
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Not sitting & reaching?"
            
            // update infoLabel
          infoLabel.text = "Try a smaller toy and try placing it closer to baby to make it easier to reach."
            boldLabel.text = "Try the test again in a month."
            
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "Not sitting & reaching?"
            
            // update infoLabel
          infoLabel.text = "Perform this test a few more times to be sure the outcome is consistent. Remember practice and encouragement can go a long way!"
            boldLabel.text = "If problem persists and your baby is older than 20 months,record this test to show your pediatrician at your next visit."
        } else {
            // update questionLabel
            questionLabel.text = "Not sitting & reaching?"
            
            // update infoLabel
          infoLabel.text = "Not to worry. Not all babies develop at the same rate."
          boldLabel.text = " Try again and be sure baby is rested, fed, and alert."
        }
    }
    
    /*!
    @brief Schedule a local notification to remind the user to run the test again.
    @discussion The local notification is scheduled if it does not currently exist.
    */
    func scheduleReminder() {
        
        if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.reachingWhileSitting) == false {
            
            // configure the local notification
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.reachingWhileSitting, secondsBeforeDisplayingReminder: Test.NotificationInterval.reachingWhileSitting)
            
            // schedule the local notification
            localNotification.scheduleNotification()
        }
    }
}
