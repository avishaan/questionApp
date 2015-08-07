//
//  ActivityReminderViewController.swift
//  questionApp
//
//  Created by john bateman on 7/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

// The following structs contain strings that can be presented to the user in a reminder...

struct TestNamesPresentable {
    static var pupilResponse = "pupil response"
    static var fallingToy = "falling toy"
    static var letsCrawl = "let's crawl"
    static var pointFollowing = "point following"
    static var hearing = "hearing"
    static var crossingEyes = "crossing eyes"
    static var attentionAtDistance = "attention at distance"
    static var symmetry = "symmetry"
    static var pincer = "pincer"
    static var partiallyCoveredToy = "partially covered toy"
    static var selfrecognition = "self recognition"
    static var socialsmiling = "social smiling"
    static var facialMimic = "facial mimic"
    static var unassistedSitting = "unassisted sitting"
    // TODO: if new tests are added to the app, add them here.
}

struct TestReminderInterval { // TODO: review
    static var pupilResponseInterval = "4-6"
    static var letsCrawlInterval = "6-8"
    static var fallingToyInterval = "2-4"
    static var pointFollowingInterval = "4-6"
    static var crossingEyesInterval = "4-6"
    static var hearingInterval = "4-6"
}

struct EmailConstants {
    static var recipient = ""
    static var subject = "babynoggin Test Reminder"
    static var body = "babynoggin reminds you to try the test again in 2-4 weeks."
    static var emailBodyFormatted = "babynoggin reminds you to try the %@ test again in 2-4 weeks."
    static var composerErrorTitle = "Unable to send the email"
    static var composerErrorMessage = "The device is not configured to send email. Please check that an e-mail account is configured in settings and retry."
    static var button = "OK"
    static var testReminder = "test reminder"
}

struct MessageConstants {
    static var recipient = ""
    static var subject = "babynoggin Test Reminder"
    static var body = "babynoggin reminds you to try the test again in 2-4 weeks."
    static var messageBodyFormatted = "babynoggin reminds you to try the %@ test again in 2-4 weeks."
    static var composerErrorTitle = "Unable to send the message"
    static var composerErrorMessage = "The device is not configured to send text messages. Please check settings and retry."
    static var button = "OK"
    static var testReminder = "test reminder"
}

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

class ActivityReminderViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    /* The object that invokes this controller should set testName to a TestNamesPresentable member to identify the test. (See the TestNamesPresentable struct at the top of this file.) This testName will be used in the Reminder presented to the user. */
    var testName: String? = nil
    
    /* The object that invokes this controller should set testReminderInterval to a TestReminderInterval member to identify the appropriate amount of time to wait before re-administering the test. (See the TestReminderInterval struct at the top of this file.) This testReminderInterval will be used in the Reminder presented to the user. */

    var testReminderInterval: String? = nil
    
    
    @IBOutlet weak var textMessageButton: BNButton!
    @IBOutlet weak var emailButton: BNButton!
    @IBOutlet weak var notificationButton: BNButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize all button graphics to the unchecked state
        let deselectedImage = UIImage(named: "unselectedRadioButton") as UIImage!
        emailButton.setImage(deselectedImage, forState: .Normal)
        textMessageButton.setImage(deselectedImage, forState: .Normal)
        notificationButton.setImage(deselectedImage, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // TODO: consider moving MFMessageComposeViewController and MFMailComposeViewController code to their own classes to lighten the view controller.
    
    // Mark: text message
    
    @IBAction func onTextMessageButtonTap(sender: AnyObject) {
        
        //updateButtonImage(sender) // enable if radio button behavior is desired and remove emailButton.setImage(selectedImage, forState: .Normal)
        
        if MFMessageComposeViewController.canSendText() {
            if let messageComposeViewController = setupMessageComposeController() {
                self.presentViewController(messageComposeViewController, animated: true, completion: nil)
                textMessageButton.setImage(UIImage(named: "selectedRadioButton") as UIImage!, forState: .Normal)
            } else {
                presentMessageErrorAlert()
            }
        } else {
            presentMessageErrorAlert()
        }
    }

    func setupMessageComposeController() -> MFMessageComposeViewController? {
        // configure composer
        let messageComposeViewController:MFMessageComposeViewController? = MFMessageComposeViewController()
        if let messageComposeViewController = messageComposeViewController {
            messageComposeViewController.messageComposeDelegate = self
            
            // configure message recipient
            let parent = Parent()
            // Note: Parent currently does not hold a mobile number, so nothing to configure here yet.
            // messageComposeViewController.recipients = parent.
            
            // configure message subject and body
            if let testName = self.testName {
                // subject
                if MFMessageComposeViewController.canSendSubject() {
                    messageComposeViewController.subject = testName + " " + MessageConstants.testReminder
                }
                // body
                var bodyString = String(format: MessageConstants.messageBodyFormatted, testName)
                messageComposeViewController.body = bodyString
            } else {
                // subject
                if MFMessageComposeViewController.canSendSubject() {
                    messageComposeViewController.subject = MessageConstants.subject
                }
                // body
                messageComposeViewController.body = MessageConstants.body
            }
        }
        
        return messageComposeViewController
    }

    func presentMessageErrorAlert() {
        let alert = UIAlertView(title: MessageConstants.composerErrorTitle, message: MessageConstants.composerErrorMessage, delegate: self, cancelButtonTitle: MessageConstants.button)
        alert.show()
    }
    
    // MFMessageComposeViewControllerDelegate. Called when the message is completed. Dismiss the message controller.
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    
    // MARK: e-mail
    
    @IBAction func onEmailButtonTap(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            if let mailComposeViewController = setupMailComposeController() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
                emailButton.setImage(UIImage(named: "selectedRadioButton") as UIImage!, forState: .Normal)
            } else {
                presentMailErrorAlert()
            }
        } else {
            presentMailErrorAlert()
        }
        //updateButtonImage(sender)
    }
    
    func setupMailComposeController() -> MFMailComposeViewController? {
        // configure composer
        let mailComposeViewController:MFMailComposeViewController? = MFMailComposeViewController()
        if let mailComposeViewController = mailComposeViewController {
            mailComposeViewController.mailComposeDelegate = self
            
            // configure message recipient
            let parent = Parent()
            if let email = parent.email {
                mailComposeViewController.setToRecipients([email])
            } else {
                mailComposeViewController.setToRecipients([EmailConstants.recipient])
            }
            
            // configure message subject and body
            if let testName = self.testName {
                mailComposeViewController.setSubject(testName + " " + EmailConstants.testReminder)
                var bodyString = String(format: EmailConstants.emailBodyFormatted, testName)
                mailComposeViewController.setMessageBody(bodyString, isHTML: false)
            } else {
                mailComposeViewController.setSubject(EmailConstants.subject)
                mailComposeViewController.setMessageBody(EmailConstants.body, isHTML: false)
            }
        }
        
        return mailComposeViewController
    }
    
    func presentMailErrorAlert() {
        let alert = UIAlertView(title: EmailConstants.composerErrorTitle, message: EmailConstants.composerErrorMessage, delegate: self, cancelButtonTitle: EmailConstants.button)
        alert.show()
    }
    
    // MFMailComposeViewControllerDelegate Method. Called when the email is completed. Dismiss the mail controller.
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: local notification
    
    @IBAction func onInAppNotificationTap(sender: AnyObject) {
        var localNotification = UILocalNotification()
        
        //updateButtonImage(sender)
        
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
        let registerUserNotificationSettings = UIApplication.instancesRespondToSelector("registerUserNotificationSettings:")
        if registerUserNotificationSettings {
            var types: UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: types, categories: nil))
        }
        
        // schedule the notification
        localNotification.fireDate = NSDate(timeIntervalSinceNow: NotificationConstants.interval)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        // TODO: add code to handle notification if app is running
        
        presentConfirmationAlert()
        
        notificationButton.setImage(UIImage(named: "selectedRadioButton") as UIImage!, forState: .Normal)
    }

    func presentConfirmationAlert() {
        var messageString: String = ""
        if let testName = testName {
            messageString = String(format: NotificationConstants.confirmedMessage, testName)
        } else {
            messageString = String(format: NotificationConstants.confirmedMessage, "")
        }
        let alert = UIAlertView(title: NotificationConstants.confirmedTitle, message: messageString, delegate: self, cancelButtonTitle: NotificationConstants.button)
        alert.show()
    }

    // Helper function: Sets state of radio button images. Implements radio button behavior for the graphic on the ActivityReminder buttons.
    func updateButtonImage(selectedButton: AnyObject) {
        let button = selectedButton as? UIButton
        let selectedImage = UIImage(named: "selectedRadioButton") as UIImage!
        let deselectedImage = UIImage(named: "unselectedRadioButton") as UIImage!
        
        if button == emailButton {
            emailButton.setImage(selectedImage, forState: .Normal)
            textMessageButton.setImage(deselectedImage, forState: .Normal)
            notificationButton.setImage(deselectedImage, forState: .Normal)
        } else if button == textMessageButton {
            emailButton.setImage(deselectedImage, forState: .Normal)
            textMessageButton.setImage(selectedImage, forState: .Normal)
            notificationButton.setImage(deselectedImage, forState: .Normal)
        } else if button == notificationButton {
            emailButton.setImage(deselectedImage, forState: .Normal)
            textMessageButton.setImage(deselectedImage, forState: .Normal)
            notificationButton.setImage(selectedImage, forState: .Normal)
        } else {
            println("unknown button")
        }
    }
}
