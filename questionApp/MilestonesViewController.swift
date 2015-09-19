//
//  MilestonesViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/11/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class MilestonesViewController: UIViewController {
  
  @IBOutlet weak var babyImageView: UIImageView!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var babyNameLabel: UILabel!
  @IBOutlet weak var sensoryAndMotorPieChartView: BNMilestonePieChartView!
  @IBOutlet weak var languageAndCognitivePieChartView: BNMilestonePieChartView!
  @IBOutlet weak var socialAndEmotionalPieChartView: BNMilestonePieChartView!
  @IBOutlet weak var sensoryAndMotorLabel: UILabel!
  var parent = Parent()
  @IBOutlet weak var languageAndCognitiveLabel: UILabel!
  @IBOutlet weak var socialAndEmotionalLabel: UILabel!
	
  
  @IBOutlet weak var sensoryMotorBackground: UIButton!
  @IBOutlet weak var socialEmotionalBackground: UIButton!
  @IBOutlet weak var languageCognitiveBackground: UIButton!

	@IBOutlet weak var nextTestLabel: UILabel!
	let tapRecognizer = UITapGestureRecognizer()
	@IBOutlet weak var nextTestImageView: UIImageView!
	var reminderCount = 0
	@IBOutlet weak var retestsImageView: UIImageView!
	@IBOutlet weak var remindersCountLabel: UILabel!
	let tapRecognizerRetests = UITapGestureRecognizer()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    Tracker.createEvent(.Milestone, .Load)
    
    // Do any additional setup after loading the view.
    // setup image as a circle
    babyImageView.layer.cornerRadius = babyImageView.frame.size.width/2
    babyImageView.clipsToBounds = true
    babyImageView.layer.borderWidth = 4.0
    babyImageView.layer.borderColor = kBlue.CGColor
    
    babyImageView.image = parent.image
    
    // calculations for getting age in weeks
    
    if (parent.babyBirthday != nil){
      let secondsDifference = parent.babyBirthday?.timeIntervalSinceNow
      let weekDifference = abs(secondsDifference!/60/60/24/7)
      
      var weekFormatter = NSNumberFormatter()
      weekFormatter.maximumFractionDigits = 0
      let weeksFormattedString = weekFormatter.stringFromNumber(weekDifference)
      let ageAsString = weeksFormattedString! + " weeks"
      
      ageLabel.text = ageAsString
      
      
      
    }
    
    // update baby name
    babyNameLabel.text = parent.babyName
    
    // get the test status by category
    var profiles = TestProfiles()
    profiles.initProfilesFromPersistentStore()
    var testHistories = profiles.getTestHistories(profileName: Parent().getCurrentProfileName())
    let statusByCategory = testHistories?.statusByCategory()
    let sensoryAndMotor = statusByCategory?[Test.CategoryNames.sensoryAndMotor]
    let socialAndEmotional = statusByCategory?[Test.CategoryNames.socialAndEmotional]
    let languageAndCognitive = statusByCategory?[Test.CategoryNames.languageAndCognitive]
    
    // update pie charts for each category
    sensoryAndMotorPieChartView.config(["test","test","test","",""], values: [0.2,0.2,0.2,0.2,0.2])
    languageAndCognitivePieChartView.config(["test","test",""], values: [0.33,0.33,0.33])
    socialAndEmotionalPieChartView.config(["test","test","test",""], values: [0.25,0.25,0.25,0.25])
    applyTextAttributesToLabels()
    
    // adjust corner radius
    sensoryMotorBackground.clipsToBounds = true
    sensoryMotorBackground.layer.cornerRadius = 10
    socialEmotionalBackground.clipsToBounds = true
    socialEmotionalBackground.layer.cornerRadius = 10
    languageCognitiveBackground.clipsToBounds = true
    languageCognitiveBackground.layer.cornerRadius = 10
    
    // setup tap recognizer for the NextTest UIImageView control
		tapRecognizer.addTarget(self, action: "handleSingleTapOnNextTest")
		nextTestImageView.addGestureRecognizer(tapRecognizer)
		nextTestImageView.userInteractionEnabled = true
		
		// setup tap recognizer for the Retests UIImageView control
		tapRecognizerRetests.addTarget(self, action: "handleSingleTapOnRetests")
		retestsImageView.addGestureRecognizer(tapRecognizerRetests)
		retestsImageView.userInteractionEnabled = true
  }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		// Configure the Next Test elements
		configureNextTest()
		
		// Configure the Re-tests elements
		configureReminders()
    
    var profiles = TestProfiles()
    profiles.initProfilesFromPersistentStore()
    var testHistories = profiles.getTestHistories(profileName: Parent().getCurrentProfileName())
    
    // present feedback controller if it has not been shown before
    if !NSUserDefaults.standardUserDefaults().boolForKey(kHasFeedbackDialogShown) {
      println("has not shown feedbackVC yet")
      // check if there has been enough passed tests
      if let successful = testHistories?.numSuccessful {
        println("we have had \(successful) successful tests")
        // if there are enough passed test, show the feedback controller
        if successful >= 3 {
          println("show feedbackdialog")
          let feedBackStoryboard:UIStoryboard = UIStoryboard(name: "Feedback", bundle: nil)
          let feedBackDialogVC = feedBackStoryboard.instantiateViewControllerWithIdentifier("FeedbackDialogID") as! FeedbackViewController
          self.presentViewController(feedBackDialogVC, animated: true, completion: nil)
          
        }
      }
      // else there aren't enough, just proceed normally
    }
    
  }
	
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
	// Helper function formats text attributes for substrings in labels.
	func applyTextAttributesToLabels() {
			
		let blueAtrributes = [NSForegroundColorAttributeName: kBlue, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 13)!]
		
		// label 1
		var attributedString1 = NSMutableAttributedString(string: sensoryAndMotorLabel.text!)
		attributedString1.addAttributes(blueAtrributes, range: NSMakeRange(0, 15))
		sensoryAndMotorLabel.attributedText = attributedString1
		
		// label 2
		var attributedString2 = NSMutableAttributedString(string: languageAndCognitiveLabel.text!)
		attributedString2.addAttributes(blueAtrributes, range: NSMakeRange(0, 22))
		languageAndCognitiveLabel.attributedText = attributedString2
		
		// label 3
		var attributedString3 = NSMutableAttributedString(string: socialAndEmotionalLabel.text!)
		attributedString3.addAttributes(blueAtrributes, range: NSMakeRange(0, 35))
		socialAndEmotionalLabel.attributedText = attributedString3
	}

	/* 
	@brief Get the Next test to run for the current profile.
	@dicsussion Configures the nextTestLabel property.
	*/
	func configureNextTest() {
		
		// get histories for the current profile
		var parent = Parent()
		var profiles = TestProfiles()
		profiles.initProfilesFromPersistentStore()
		var histories = profiles.getTestHistories(profileName: parent.getCurrentProfileName())
		
		// configure the next test properties
		if let histories = histories {
			if let test = histories.getNextTest() {
				nextTestLabel.text = test.history.testName
			} else {
				nextTestLabel.text = "All tests passed!"
			}
		}
	}
	
	/* Handle taps on the NextTest control. */
	func handleSingleTapOnNextTest() {
		if let nextTestName = nextTestLabel.text {
			BNLocalNotification.presentTestViewController(nextTestName)
		}
	}
	
	/*
	@brief Determines how many tests have reminders scheduled.
	@dicsussion Configures the remindersCountLabel property.
	*/
	func configureReminders() {
		
		// get histories for the current profile
		var parent = Parent()
		var profiles = TestProfiles()
		profiles.initProfilesFromPersistentStore()
		var histories = profiles.getTestHistories(profileName: parent.getCurrentProfileName())

		// count the number of tests that have reminders
		if let histories = histories {
			reminderCount = histories.countTestsWithReminders()
			remindersCountLabel.text = String(format:"%d reminders", reminderCount)
			
			histories.testgetTestsWithReminders()
		}
	}
	
	/* Handle taps on the Retests control. */
	func handleSingleTapOnRetests() {

		// get histories for the current profile
		var parent = Parent()
		var profiles = TestProfiles()
		profiles.initProfilesFromPersistentStore()
		var histories = profiles.getTestHistories(profileName: parent.getCurrentProfileName())

		// get a list of tests with reminders currently scheduled.
		if let histories = histories {
			let tests = histories.getTestsWithReminders()
			
			// TODO: display a view containing tests.
		}
	}
}
