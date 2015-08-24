//
//  PupilResponseBadOutcomeViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/29/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import Charts

class PupilResponseBadOutcomeViewController: UIViewController {
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
		Tracker.createEvent(.PupilResponse, .Load, .Bad)
    
    // Do any additional setup after loading the view.
    rangeChartView.config(startMonth: 0, endMonth: 12, successAgeInMonths: 0.2, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
    
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

// NOTE: replaced with remind me notification.
//	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//		
//		if segue.identifier == "PupilResponseToActivityReminderSegue" {
//			let controller = segue.destinationViewController as! ActivityReminderViewController
//			
//			// set the test name on the ActivityReminder VC
//			controller.testName = TestNamesPresentable.pupilResponse
//		}
//	}
	
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
			let string = "Not to worry! This can be a challenging test. If your baby has dark eyes, it may take a few tests to see the pupils constrict."
			applyTextAttributesToLabel(string, indexAtStartOfBold:46, countOfBoldCharacters:80)
		} else if failed == 2 {
			// update questionLabel
			questionLabel.text = "Pupils didn't constrict?"
			
			// update infoLabel
			let string = "Not to worry! This can be a challenging test. Try again tomorrow in a darkened room to make the pupil contraction more obvious."
			applyTextAttributesToLabel(string, indexAtStartOfBold:46, countOfBoldCharacters:81)
			
		} else if failed >= 3 {
			// update questionLabel
			questionLabel.text = "Pupils didn't constrict?"
			
			// update infoLabel
			let string = "Was baby looking at the light and sitting in a dark room? If still no pupil response, repeat and record this test to show your pediatrician."
			applyTextAttributesToLabel(string, indexAtStartOfBold:58, countOfBoldCharacters:82)
		} else {
			// update questionLabel
			questionLabel.text = "Pupils didn't constrict?"
			
			// update infoLabel
			let string = "Not to worry! This can be a challenging test. If your baby has dark eyes, it may take a few tests to see the pupils constrict."
			applyTextAttributesToLabel(string, indexAtStartOfBold:46, countOfBoldCharacters:80)
		}
	}
	
	/*!
	@brief Schedule a local notification to remind the user to run the test again.
	@discussion The local notification is scheduled if it does not currently exist.
	*/
	func scheduleReminder() {
		
		if BNLocalNotification.doesLocalNotificationExist(Test.TestNamesPresentable.pupilResponse) == false {
			
			// configure the local notification
			let localNotification = BNLocalNotification(nameOfTest: Test.TestNamesPresentable.pupilResponse, secondsBeforeDisplayingReminder: Test.NotificationInterval.pupilResponse)
			
			// schedule the local notification
			localNotification.scheduleNotification()
		}
	}
}
