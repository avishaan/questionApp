//
//  AttentionAtDistanceBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/15/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class AttentionAtDistanceBadOutcomeViewController: UIViewController {
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
      Tracker.createEvent(.AttentionAtDistance, .Load, .Bad)
        // Do any additional setup after loading the view.
        rangeChartView.config(startMonth: 0, endMonth: 12, successAgeInMonths: 6, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
        
        // font can't be set directly in storyboard for attributed string, set the label font here
        // make label's set attr string to a mutable so we can add attributes on
        var attrString:NSMutableAttributedString = NSMutableAttributedString(attributedString: rangeChartLabel.attributedText)
        
        // add font attribute
        attrString.addAttribute(NSFontAttributeName, value: UIFont(name: kOmnesFontMedium, size: 15)!, range: NSMakeRange(0, attrString.length))
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
        if segue.identifier == "AADToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = TestNamesPresentable.attentionAtDistance
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
//        let string = "Not to worry! Not all babies develop at the same rate. Try and be sure baby is rested, fed, and alert."
//        
//        var attributedString = NSMutableAttributedString(string: string)
//        
//        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
//        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
//        
//        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, 54))
//        attributedString.addAttributes(boldAttributes, range: NSMakeRange(55, 46)) //115
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
        let string = "Not to worry! Not all babies develop at the same rate.\nTry again and be sure baby is rested, fed, and alert."
      
            applyTextAttributesToLabel(string, indexAtStartOfBold:55, countOfBoldCharacters:53)
      } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Didn't hold attention?"
            
            // update infoLabel
          let string = "Practice by using a flighlight or a squeeky toy to better capture baby's attention.Try this, then perform the test again in a week."
            applyTextAttributesToLabel(string, indexAtStartOfBold:82, countOfBoldCharacters:48)
            
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "Didn't hold attention?"
            
            // update infoLabel
          let string = "Getting baby's attention from the start is the key. If baby looked at you as you back away, it still counts!If you are still concerned, please record the test to show your pediatrician at your next well-child visit. Try again in a week."
            applyTextAttributesToLabel(string, indexAtStartOfBold:108, countOfBoldCharacters:127)
        } else {
            // update questionLabel
            questionLabel.text = "Didn't 7old attention?"
            
            // update infoLabel
            let string = "Not to worry! Not all babies develop at the same rate.\nTry again and be sure baby is rested, fed, and alert."
            applyTextAttributesToLabel(string, indexAtStartOfBold:55, countOfBoldCharacters:53)
        }
    }
    
    /*!
    @brief Schedule a local notification to remind the user to run the test again.
    @discussion The local notification is scheduled if it does not currently exist.
    */
    func scheduleReminder() {
        
        if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.attentionAtDistance) == false {
            
            // configure the local notification
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.attentionAtDistance, secondsBeforeDisplayingReminder: Test.NotificationInterval.attentionAtDistance)
            
            // schedule the local notification
            localNotification.scheduleNotification()
        }
    }
}
