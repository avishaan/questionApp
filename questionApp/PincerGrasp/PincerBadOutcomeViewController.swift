//
//  PincerBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/16/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class PincerBadOutcomeViewController: UIViewController {
  
  /** A Test containing the updated test history. This property should be set by the source view controller. */
  var test: Test!
  
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var boldInfoLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
		// Initialize text in the view based on the test history.
		initializeViewFromTestHistory()
		
		// Schedule a local notification, once, to remind the user to rerun this test.
		scheduleReminderOnce()
  }
	
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "pincerToActivityReminderSegue" {
      let controller = segue.destinationViewController as! ActivityReminderViewController
      
      // set the test name on the ActivityReminder VC
      controller.testName = TestNamesPresentable.pincer
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
    let failed = test?.failedTestsCount()
    
    if failed <= 1 {
      // update infoLabel
      let string = "Not to worry! Not all babies develop at the same rate."
      applyTextAttributesToLabel(string, indexAtStartOfBold:0, countOfBoldCharacters:0)
    } else if failed == 2 {
      // update questionLabel
      questionLabel.text = "Didn't pincer grasp?"
      // update infoLabel
      let string = "Sometimes practicing using a noisy toy or ice cubes will help baby develop the pincer grasp."
      applyTextAttributesToLabel(string, indexAtStartOfBold:0, countOfBoldCharacters:0)
      boldInfoLabel.text = "Try this, then perform the test again in 2 weeks."
      
    } else if failed == 3 {
      // update questionLabel
      questionLabel.text = "Didn't pincer grasp?"
      
      // update infoLabel
      let string = "Practice using cereal or other appropriate food items"
      applyTextAttributesToLabel(string, indexAtStartOfBold:0, countOfBoldCharacters:0)
      boldInfoLabel.text = "If baby is still unable to pincer grasp, repeat and record test to show your pediatrician."
    } else {
      // update questionLabel
      questionLabel.text = "Didn't pincer grasp?"
      
      // update infoLabel
      let string = "Not to worry! Not all babies develop at the same rate."
      applyTextAttributesToLabel(string, indexAtStartOfBold:0, countOfBoldCharacters:0)
      boldInfoLabel.text = "If baby is still unable to pincer grasp, repeat and record test to show your pediatrician."
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
		
		if failed == Test.LocalNotificationTrigger.pincer {
			let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.pincer, secondsBeforeDisplayingReminder: Test.NotificationInterval.pincer)
			localNotification.scheduleNotification(self)
		}
	}

}
