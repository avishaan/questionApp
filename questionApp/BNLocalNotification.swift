/*!
@header BNLocalNotification.swift

@brief This file contains the BNLocalNotification class which schedules local notifications.
@discussion The class should be initialized with a test name and the number of seconds before the notification is displayed to the user.

Created on 8/5/15

@author John Bateman

@copyright 2015 Qidza, Inc.
*/

import UIKit
import Foundation

class BNLocalNotification {

  struct NotificationConstants {
    static var subject = "babynoggin Test Reminder"
    static var body = "It's time to retry the test."
    static var reminderBodyFormatted = "It's time to retry the %@ test."
    static var composerErrorTitle = "Error"
    static var composerErrorMessage = "Unable to schedule the reminder."
    static var interval: Double = 5 // TODO: Currently set to 5 seconds to support testing. Must change to the following 2 week interval for beta release: 14 * 24 * 60 * 60 = 1209600
    static var confirmedTitle = "All set!"
    static var confirmedMessage = "A notification has been scheduled when it is time to try the %@ test again in 2 weeks"
    static var button = "OK"
  }
  
  /* Set testName to a TestNamesPresentable member to identify the test. (See the TestNamesPresentable struct at the top of this file.) This testName will be used in the Reminder presented to the user.
  */
  var testName: String? = nil
  
  /* Set elapsedSecondsBeforePresentingReminder to identify the number of seconds from now that should elapse before the reminder is presented to the user.
  */
  var elapsedSecondsBeforePresentingReminder: Double = NotificationConstants.interval // 2 weeks in seconds by default (production release)
  
  
  /*
  @brief This designated initializer initializes a BNLocalNotification instance with a test name and schedule interval.
  @param (in) nameOfTest - identifies the test.
  @param (in) secondsBeforeDisplayingReminder - Number of seconds to wait before displaying the notification to the user.
  */
  init(nameOfTest: String, secondsBeforeDisplayingReminder: Double) {
    testName = nameOfTest
    elapsedSecondsBeforePresentingReminder = secondsBeforeDisplayingReminder
  }
  
  @IBAction func scheduleNotification(sender: AnyObject) {
    
    var localNotification = UILocalNotification()
    
    // configure the title
    localNotification.alertTitle = NotificationConstants.subject
    
    // configure body
    if let testName = self.testName {
      var bodyString = String(format: NotificationConstants.reminderBodyFormatted, testName)
      localNotification.alertBody = bodyString
    } else {
      localNotification.alertBody = NotificationConstants.body
    }
    
    // add a badge
    localNotification.applicationIconBadgeNumber = 1
    
    // TODO: specify the test in the userInfo property so the app knows which test to display when it is launched.
    
    // ask user for permission to display notifications
    acquireNotificationPermission()

    // schedule the notification
    localNotification.fireDate = NSDate(timeIntervalSinceNow: NotificationConstants.interval)
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    
    //presentConfirmationAlert()
  }
  
  /*
  @brief Ask the user for permission to register local notifications on this device.
  @discussion Registers UI, Sound, and Badge permissions for the notifications.
  */
  func acquireNotificationPermission() {
    
    let registerUserNotificationSettings = UIApplication.instancesRespondToSelector("registerUserNotificationSettings:")
    
    if registerUserNotificationSettings {
      var types: UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge
      
      UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: types, categories: nil))
    }
  }
  
  /*
  @brief Show an Alert Message to the user explaining that the notification has been scheduled.
  */
  func presentConfirmationAlert() {
    
    // configure the message
    var messageString: String = ""
    if let testName = testName {
      messageString = String(format: NotificationConstants.confirmedMessage, testName)
    } else {
      messageString = String(format: NotificationConstants.confirmedMessage, "")
    }
    let alert = UIAlertView(title: NotificationConstants.confirmedTitle, message: messageString, delegate: self, cancelButtonTitle: NotificationConstants.button)
    
    // display the alert on the main thread
    dispatch_async(dispatch_get_main_queue()) {
      alert.show()
    }
  }
  
  // TODO: add code to handle notification if app is running. call from AppDelegate when user clicks on notification.
  /*
  @brief Display the first view controller of the test identified in the notification.
  @param Identifies the test to launch.
  */
/* TODO - define function parameter and finish the funchtion.
  func handleNotificationSelection(/* TODO: userInfo : TBDType */) {
    
    // TODO: extract test from userInfo property and launch that test
    let testID = 0
    
    var storyboard = UIStoryboard (name: "Main", bundle: nil)
    var controller : UIViewController? = nil
    
    switch testID {
    case :  // Pupil Response
      storyboardID : String = "WhyIsPupilResponseStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsPupilResponseViewcontroller
    case : // Falling Toy
      storyboardID : String = "WhyIsObjectPermanenceStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsObjectPermanenceViewController
    case : // Let's Crawl
      storyboardID : String = "WhyIsCrawlingViewControllerStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsCrawlingViewController
    case : // Point Following
      storyboardID : String = "WhyIsPointFollowingStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsPointFollowingViewController
    case : // Hearing
      storyboardID : String = "WhyIsHearingStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsHearingViewController
    case : // Crossing Eyes
      storyboardID : String = "WhyIsCrossingEyesStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsCrossingEyesViewController
    case : // Attention at Distance
      storyboardID : String = "WhyIsAttentionAtDistanceStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsAttentionAtDistanceViewController
    case : // Symmetry
      storyboardID : String = "WhyIsSymmetryStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsSymmetryViewController
    case : // Pincer
      storyboardID : String = "WhyIsPincerStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsPincerViewController
    case : // Partially Covered Toy
      storyboardID : String = "WhyIsPartiallyCoveredToyStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsPartiallyCoveredToyViewController
    case : // Self Recognition
      storyboardID : String = "WhyIsSelfRecognitionStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsSelfRecognitionViewController
    case : // Social Smiling
      storyboardID : String = "WhyIsSocialSmilingStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsSocialSmilingViewController
    case : // Facial Mimic
      storyboardID : String = "WhyIsFacialMimicStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsFacialMimicViewController
    default :
      storyboardID : String = "WhyIsPupilResponseStoryboardID"
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! WhyIsPupilResponseViewcontroller
    }
    
    dispatch_async(dispatch_get_main_queue()) {
      self.presentViewController(controller, animated: true, completion: nil);
    }
  }
*/
}