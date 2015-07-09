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
    static var body = "babynoggin reminds you to try the Falling Toy test again in 2-4 weeks."
    static var emailBodyFormatted = "babynoggin reminds you to try the %@ test again in 2-4 weeks."
    static var composerErrorTitle = "Unable to send the email"
    static var composerErrorMessage = "The device is not configured to send email. Please check that an e-mail account is configured in settings and retry."
}

struct MessageConstants {
    static var recipient = ""
    static var subject = "Falling Toy Test Reminder"
    static var body = "babynoggin reminds you to try the Falling Toy test again in 2-4 weeks."
    static var messageBodyFormatted = "babynoggin reminds you to try the %@ test again in 2-4 weeks."
    static var composerErrorTitle = "Unable to send the message"
    static var composerErrorMessage = "The device is not configured to send text messages. Please check settings and retry."
}

class ActivityReminderViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    // The object that invokes this controller should set testName to something similar to "Falling Toy" to identify the test. It will be used in the subject and body of the reminder email.
    var testName: String? = nil
    
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
    }


}
