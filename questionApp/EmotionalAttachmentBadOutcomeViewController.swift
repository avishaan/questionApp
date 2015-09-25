//
//  EmotionalAttachmentBadOutcomeViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/21/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class EmotionalAttachmentBadOutcomeViewController: UIViewController {

  @IBOutlet weak var rangeChartView: BNTestRangeChartView!
  @IBOutlet weak var rangeChartLabel: UILabel!
  
  /** A Test containing the updated test history. This property should be set by the source view controller. */
  var test: Test?
  
  @IBOutlet weak var boldLabel: UILabel!
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  
  var parent = Parent()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // analytics
    Tracker.createEvent(.EmotionalAttachment, .Load, .Bad)
    
    // Do any additional setup after loading the view.
    rangeChartView.config(startMonth: 0, endMonth: 20, successAgeInMonths: 13, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
    
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
  
  // NOTE: Replaced ActivityReminderViewController with automatic notification.
  //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  //
  //        if segue.identifier == "FacialMimicToActivityReminderSegue" {
  //            let controller = segue.destinationViewController as! ActivityReminderViewController
  //
  //            // set the test name on the ActivityReminder VC
  //            controller.testName = TestNamesPresentable.facialMimic
  //        }
  //    }
  
  @IBAction func onHomeButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "Main", bundle: nil)
    var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
    self.presentViewController(controller, animated: true, completion: nil);
    
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
      infoLabel.text = "Not to worry! Not all babies develop at the same rate."
        boldLabel.text = "Try again and be sure baby is rested, fed, and alert."
    } else if failed == 2 {
      // update questionLabel
      questionLabel.text = "Did baby resist comforting?"
      
      // update infoLabel
      infoLabel.text = "Being responsive to baby's needs can increase emotional security. For example, soothe your crying baby."

      boldLabel.text = "Practice responsive care to baby’s emotions while not overwhelming your baby."
    } else if failed >= 3 {
      // update questionLabel
      questionLabel.text = "Did baby resist comforting?"
      
      // update infoLabel
      infoLabel.text = "Practicing responsive care to your baby's emotional needs is the best way to help baby develop a healthy sense of security."
      boldLabel.text = "Your baby’s temperament may also change with age."
     
    } else {
      // update questionLabel
      questionLabel.text = "Did baby resist comforting?"
      
      // update infoLabel
      infoLabel.text = "Not to worry! Not all babies develop at the same rate."
      boldLabel.text = "Try again and be sure baby is rested, fed, and alert."

    }
  }
  
  /*!
  @brief Schedule a local notification to remind the user to run the test again.
  @discussion The local notification is scheduled if it does not currently exist.
  */
  func scheduleReminder() {
    
    if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.emotionalAttachment) == false {
      
      // configure the local notification
      let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.emotionalAttachment, secondsBeforeDisplayingReminder: Test.NotificationInterval.emotionalAttachment)
      
      // schedule the local notification
      localNotification.scheduleNotification()
    }
  }

}
