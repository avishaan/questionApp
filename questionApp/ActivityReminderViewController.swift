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

struct EmailConstants {
    static var recipient = ""
    static var subject = "Falling Toy Test Reminder"
    static var body = "babynoggin reminds you to try the falling toy test again in 2-4 weeks."
    static var emailBodyFormatted = "babynoggin reminds you to try the %@ test again in 2-4 weeks."
    static var composerErrorTitle = "Unable to send the email"
    static var composerErrorMessage = "The device is not configured to send email. Please check that an e-mail account is configured in settings and retry."
}

struct MessageConstants {
    static var recipient = ""
    static var subject = "Falling Toy Test Reminder"
    static var body = "babynoggin reminds you to try the falling toy test again in 2-4 weeks."
    static var messageBodyFormatted = "babynoggin reminds you to try the %@ test again in 2-4 weeks."
    static var composerErrorTitle = "Unable to send the message"
    static var composerErrorMessage = "The device is not configured to send text messages. Please check settings and retry."
}

struct ReminderConstants {
    static var subject = "babynoggin Test Reminder"
    static var body = "It's time to retry the falling toy test."
    static var reminderBodyFormatted = "It's time to retry the %@ test."
    static var composerErrorTitle = "Error"
    static var composerErrorMessage = "Unable to schedule the reminder."
    static var interval: Double = 5 // TODO: change to the following 2 week interval for beta release: 14 * 24 * 60 * 60 = 1209600
    static var confirmedTitle = "All set!"
    static var confirmedMessage = "A notification has been scheduled when it is time to try this test again in 2 weeks"
}

class ActivityReminderViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    // The object that invokes this controller should set testName to something similar to "Falling Toy" to identify the test. It will be used in the subject and body of the reminder email.
    var testName: String? = nil
    // TODO: setup testName from falling toy test flow
    
    
    @IBOutlet weak var textMessageButton: BNButton!
    @IBOutlet weak var emailButton: BNButton!
    @IBOutlet weak var notificationButton: BNButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        updateButtonImage(sender)
        
        if MFMessageComposeViewController.canSendText() {
            if let messageComposeViewController = setupMessageComposeController() {
                self.presentViewController(messageComposeViewController, animated: true, completion: nil)
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
                    messageComposeViewController.subject = testName + " test reminder"
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
        let alert = UIAlertView(title: MessageConstants.composerErrorTitle, message: MessageConstants.composerErrorMessage, delegate: self, cancelButtonTitle: "OK")
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
            } else {
                presentMailErrorAlert()
            }
        } else {
            presentMailErrorAlert()
        }
        updateButtonImage(sender)
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
                mailComposeViewController.setSubject(testName + " test reminder")
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
        let alert = UIAlertView(title: EmailConstants.composerErrorTitle, message: EmailConstants.composerErrorMessage, delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
    // MFMailComposeViewControllerDelegate Method. Called when the email is completed. Dismiss the mail controller.
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: local notification
    
    @IBAction func onInAppNotificationTap(sender: AnyObject) {
        var localNotification = UILocalNotification()
        
        updateButtonImage(sender)
        
        // configure the title
        localNotification.alertTitle = "babynoggin Test Reminder"
        
        // configure body
        if let testName = self.testName {
            var bodyString = String(format: ReminderConstants.reminderBodyFormatted, testName)
            localNotification.alertBody = bodyString
        } else {
            localNotification.alertBody = ReminderConstants.body
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
        localNotification.fireDate = NSDate(timeIntervalSinceNow: ReminderConstants.interval)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        // TODO: add code to handle notification if app is running
        
        presentConfirmationAlert()
    }

    func presentConfirmationAlert() {
        let alert = UIAlertView(title: ReminderConstants.confirmedTitle, message: ReminderConstants.confirmedMessage, delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }

    // Helper function: Sets state of radio button images.
    func updateButtonImage(selectedButton: AnyObject) {
        let button = selectedButton as? UIButton
        let selectedImage = UIImage(named: "selectedRadioButton") as UIImage!
        let deselectedImage = UIImage(named: "unselectedRadioButton")  as UIImage!
        
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
