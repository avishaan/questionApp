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

/* A custom NSNotification that indicates that a test reminder has been scheduled. */
let testReminderScheduledNotificationKey =  "com.qidza.testReminderScheduledNotificationKey"

/* A custom NSNotification that indicates that a test reminder has been removed. */
let testReminderRemovedNotificationKey =  "com.qidza.testReminderRemovedNotificationKey"

class BNLocalNotification {

  struct NotificationConstants {
    static var subject = "babynoggin Test Reminder"
    static var body = "It's time to retry the test."
    static var reminderBodyFormatted = "It's time to retry the %@ test if your baby has not yet passed."
    static var composerErrorTitle = "Error"
    static var composerErrorMessage = "Unable to schedule the reminder."
    static var defaultInterval: Double = 5 // TODO-RELEASE: Currently set to 5 seconds to support testing. Must change to the following 2 week interval for beta release: 14 * 24 * 60 * 60 = 1209600
    static var confirmedTitle = "All set!"
    static var confirmedMessage = "A notification has been scheduled when it is time to try the %@ test again in 2 weeks"
    static var button = "OK"
  }
  
  static let LocalNotificationInfoDictionaryTestNameKey = "NotificationTestName"
  
  /* Set testName to a TestNamesPresentable member to identify the test. (See Test.TestNamesPresentable) This testName will be used in the Reminder presented to the user.
  */
  var testName: String? = nil
  
  /* Set elapsedSecondsBeforePresentingReminder to identify the number of seconds from now that should elapse before the reminder is presented to the user.
  */
  var elapsedSecondsBeforePresentingReminder: Double = NotificationConstants.defaultInterval // 2 weeks in seconds by default
  
  /*
  @brief This designated initializer initializes a BNLocalNotification instance with a test name and schedule interval.
  @param (in) nameOfTest - identifies the test.
  @param (in) secondsBeforeDisplayingReminder - Number of seconds to wait before displaying the notification to the user.
  */
  init(nameOfTest: String, secondsBeforeDisplayingReminder: Double) {
    testName = nameOfTest
    elapsedSecondsBeforePresentingReminder = secondsBeforeDisplayingReminder
  }
  
  func scheduleNotification(sender: AnyObject) {
    
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
    
    // ask user for permission to display notifications
    acquireNotificationPermission()

    // Specify the test in the userInfo property so the app knows which test to display when it is launched.
    if let testName = testName {
      let infoDictionary = [BNLocalNotification.LocalNotificationInfoDictionaryTestNameKey : testName]
      localNotification.userInfo = infoDictionary
    }
    
    // schedule the notification
    localNotification.fireDate = NSDate(timeIntervalSinceNow: 20 /*TODO-RELEASE: switch to this --> elapsedSecondsBeforePresentingReminder*/)
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    
    //presentConfirmationAlert()
    
    // Send a notification indicating that a reminder has been scheduled.
    if let testName = testName {
      postTestReminderScheduledNotification(testName)
    }
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
  
  /*
  @brief Display the first view controller of the test identified in the notification.
  @discussion It can legitimately be argued that a more pure separation of view and model would be to simply post an NSNotification here and leave it to any view controller having registered an observer for that NSNotification to take action upon receipt of the NSNotificatoin (by prompting the user or displaying the new view controller associated with the reminder local notification). However, I chose to walk the VC stack and present the view controller in this class function so that it was not necessary to register an NSNotification observer in a couple hunred view controllers. This looks like the correct tradeoff to me at this time.
  @param (in) localNotification - The local notification selected by the end user. It contains a userInfo dictionary identifying the test to launch.
  */
  static func handleLocalNotification(localNotification: UILocalNotification) {
    
    let testName = localNotification.userInfo![BNLocalNotification.LocalNotificationInfoDictionaryTestNameKey] as! String
    let testID = 0
    var storyboardID: String? = nil
    var controller : UIViewController? = nil
    
    switch testName {
      
    case Test.TestNamesPresentable.pupilResponse:  // Pupil Response
      storyboardID = "WhyIsPupilResponseStoryboardID"
      var storyboard = UIStoryboard (name: "Main", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsPupilResponseViewController
      
    case Test.TestNamesPresentable.fallingToy: // Falling Toy
      storyboardID = "WhyIsObjectPermanenceStoryboardID"
      var storyboard = UIStoryboard (name: "Main", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsObjectPermanenceViewController
    
    case Test.TestNamesPresentable.letsCrawl: // Let's Crawl
      storyboardID = "WhyIsCrawlingViewControllerStoryboardID"
      var storyboard = UIStoryboard (name: "Main", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsCrawlingViewController
    
    case Test.TestNamesPresentable.pointFollowing: // Point Following
      storyboardID = "WhyIsPointFollowingStoryboardID"
      var storyboard = UIStoryboard (name: "PointFollowing", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsPointFollowingViewController
    
    case Test.TestNamesPresentable.hearing: // Hearing
      storyboardID = "WhyIsHearingStoryboardID"
      var storyboard = UIStoryboard (name: "Hearing", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsHearingViewController
    
    case Test.TestNamesPresentable.crossingEyes: // Crossing Eyes
      storyboardID = "WhyIsCrossingEyesStoryboardID"
      var storyboard = UIStoryboard (name: "CrossingEyes", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsCrossingEyesViewController
    
    case Test.TestNamesPresentable.attentionAtDistance: // Attention at Distance
      storyboardID = "WhyIsAttentionAtDistanceStoryboardID"
      var storyboard = UIStoryboard (name: "AttentionAtDistance", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsAttentionAtDistanceViewController
    
    case Test.TestNamesPresentable.symmetry: // Symmetry
      storyboardID = "WhyIsSymmetryStoryboardID"
      var storyboard = UIStoryboard (name: "Symmetry", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsSymmetryViewController
    
    case Test.TestNamesPresentable.pincer: // Pincer
      storyboardID = "WhyIsPincerStoryboardID"
      var storyboard = UIStoryboard (name: "Pincer", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsPincerViewController
    
    case Test.TestNamesPresentable.partiallyCoveredToy: // Partially Covered Toy
      storyboardID = "WhyIsPartiallyCoveredToyStoryboardID"
      var storyboard = UIStoryboard (name: "PartiallyCoveredToy", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsPartiallyCoveredToyViewController
    
    case Test.TestNamesPresentable.selfRecognition: // Self Recognition
      storyboardID = "WhyIsSelfRecognitionStoryboardID"
      var storyboard = UIStoryboard (name: "SelfRecognition", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsSelfRecognitionController
    
    case Test.TestNamesPresentable.socialSmiling: // Social Smiling
      storyboardID = "WhyIsSocialSmilingStoryboardID"
      var storyboard = UIStoryboard (name: "SocialSmiling", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsSocialSmilingViewController
    
    case Test.TestNamesPresentable.facialMimic: // Facial Mimic
      storyboardID = "WhyIsFacialMimicStoryboardID"
      var storyboard = UIStoryboard (name: "FacialMimic", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsFacialMimicViewController
      
    case Test.TestNamesPresentable.unassistedSitting: // Unassisted Sitting
      storyboardID = "WhyIsUnassistedSittingStoryboardID"
      var storyboard = UIStoryboard (name: "UnassistedSitting", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsUnassistedSittingViewController
      
    case Test.TestNamesPresentable.sittingAndReaching: // Sitting And Reaching
      storyboardID = "WhyIsSittingAndReachingStoryboardID"
      var storyboard = UIStoryboard (name: "SittingAndReaching", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsSittingAndReachingViewController

    case Test.TestNamesPresentable.plasticJar: // Plastic Jar
      storyboardID = "WhyIsPlasticJarStoryboardID"
      var storyboard = UIStoryboard (name: "PlasticJar", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsPlasticJarViewController
      
    case Test.TestNamesPresentable.completelyCoveredToy: // Plastic Jar
      storyboardID = "WhyIsCompletelyCoveredToyStoryboardID"
      var storyboard = UIStoryboard (name: "CompletelyCoveredToy", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! WhyIsCompletelyCoveredToyViewController
      
    default: // Bring up the Milestones view controller in the default case
      storyboardID = "MilestonesVCStoryboardID"
      var storyboard = UIStoryboard (name: "Main", bundle: nil)
      controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID!) as! MilestonesViewController
    }
    
    // Present the Why... view controller for the test associated with the local notification on top of the current topmost VC.
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    if let controller = controller {
      if var topmostViewController = UIApplication.sharedApplication().keyWindow?.rootViewController {
        // walk VC stack to find topmost VC
        while let presentedViewController = topmostViewController.presentedViewController {
          topmostViewController = presentedViewController
        }
        // present new VC
        dispatch_async(dispatch_get_main_queue()) {
          topmostViewController.presentViewController(controller, animated: true, completion: nil);
        }
      }
    }
    
    // decrement the app's badge icon count
    UIApplication.sharedApplication().applicationIconBadgeNumber -= 1
    
    // remove the local notification
    UIApplication.sharedApplication().cancelLocalNotification(localNotification)
    
    // Send a notification indicating that a reminder has been removed.
    BNLocalNotification.postTestReminderRemovedNotification(testName)
  }
  
  /*!
  @brief Remove a local notification if the test was passed in the interim.
  @discussion If the local notification was previously scheduled, this function will remove it by searching all local notifications for the proper userInfo key containing the test's name.
  @param (in) testName - The name of the test whose local notification is to be deleted. Use a Test.TestNamesPresentable value. (cannot be nil)
  */
  static func removeLocalNotification(testName: String) {
    
    var theApp:UIApplication = UIApplication.sharedApplication()
    
    // Iterate through all local notifications to find one containing testName in the userInfo and delete it.
    for locNotif in theApp.scheduledLocalNotifications {
      var notification = locNotif as! UILocalNotification
      let notificationUserInfo = notification.userInfo! as! [String:AnyObject]
      let notificationTestName = notificationUserInfo[BNLocalNotification.LocalNotificationInfoDictionaryTestNameKey]! as! String
      if notificationTestName == testName {
                // TODO: add profile name to the userInfo and only delete if same profile name
                //        in other words, the first child fails repeatedly, while the 2nd fails then passes. Only delete the notification belonging to the second child.
        
        // match! Cancel this local notification.
        theApp.cancelLocalNotification(notification)
        
        // Send a notification indicating that a reminder has been removed.
        BNLocalNotification.postTestReminderRemovedNotification(testName)
        break
      }
    }
  }
  
  /*
  @brief post an NSNotification indicating that a test reminder has been scheduled.
  @discussion The test name is sent in the notification's userInfo.
  @param (in) testName - The name of the test for which the reminder has been scheduled. A Test.TestNamesPresentable value. (cannot be nil)
  */
  func postTestReminderScheduledNotification(testName: String) {
    var dataDict = [String : String] ()
    dataDict["testName"] = testName
    NSNotificationCenter.defaultCenter().postNotificationName(testReminderScheduledNotificationKey, object: self, userInfo: dataDict)
  }
  
  /*
  @brief post an NSNotification indicating that a test reminder has been removed.
  @discussion The test name is sent in the notification's userInfo.
  @param (in) testName - The name of the test for which the reminder has been removed. A Test.TestNamesPresentable value. (cannot be nil)
  */
  static func postTestReminderRemovedNotification(testName: String) {
    var dataDict = [String : String] ()
    dataDict["testName"] = testName
    NSNotificationCenter.defaultCenter().postNotificationName(testReminderRemovedNotificationKey, object: self, userInfo: dataDict)
  }
}