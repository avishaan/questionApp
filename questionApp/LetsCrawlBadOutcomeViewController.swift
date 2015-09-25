//
//  LetsCrawlBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class LetsCrawlBadOutcomeViewController: UIViewController {
    
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
      Tracker.createEvent(.Crawl, .Load, .Bad)
        
        // Do any additional setup after loading the view.
        rangeChartView.config(startMonth: 0, endMonth: 20, successAgeInMonths: 11, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "letsCrawlToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            controller.testName = TestNamesPresentable.letsCrawl
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
            let string = "Not to worry. Not all babies develop at the same rate. Try again and be sure baby is rested, fed, and alert."
//            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:23)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Not crawling?"
            
            // update infoLabel
            let string = "Babies are great at copying you. Get down on all fours and show your baby how it's done!\nTry this and if baby still didn't crawl, try again in 3 weeks."
//            applyTextAttributesToLabel(string, indexAtStartOfBold:49, countOfBoldCharacters:21)
          
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "Not crawling?"
            
            // update infoLabel
            let string = "Differences in weight can influence when baby crawls.\nLet's try it again in 10 days."
            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:30)
        } else {
            // update questionLabel
            questionLabel.text = "Not crawling?"
            
            // update infoLabel
            let string = "Not to worry. Baby is a bit too young for this skill.\nTry again in 6-8 weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:23)
        }
    }
    
    /*!
    @brief Schedule a local notification to remind the user to run the test again.
    @discussion The local notification is scheduled if it does not currently exist.
    */
    func scheduleReminder() {
        
        if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.letsCrawl) == false {
            
            // configure the local notification
            let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.letsCrawl, secondsBeforeDisplayingReminder: Test.NotificationInterval.letsCrawl)
            
            // schedule the local notification
            localNotification.scheduleNotification()
        }
    }
}
