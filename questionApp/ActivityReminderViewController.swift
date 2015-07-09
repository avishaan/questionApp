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
    static var composerErrorTitle = "Unable to send email"
    static var composerErrorMessage = "The device is not configured to send email. Please check that an e-mail account is configured in settings and retry."
}

class ActivityReminderViewController: UIViewController, MFMailComposeViewControllerDelegate {

    // The object that invokes this controller should set testName to something similar to "Falling Toy" to identify the test. It will be used in the subject and body of the reminder email.
    var testName: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testName = "falling toy"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTextMessageButtonTap(sender: AnyObject) {
    }
    
    
    @IBAction func onInAppNotificationTap(sender: AnyObject) {
    }

    // MARK: e-mail
    
    @IBAction func onEmailButtonTap(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            if let mailComposeController = setupMailComposeController() {
                self.presentViewController(mailComposeController, animated: true, completion: nil)
            } else {
                presentMailErrorAlert()
            }
        } else {
            presentMailErrorAlert()
        }
    }
    
    func setupMailComposeController() -> MFMailComposeViewController? {
        // configure composer
        let mailComposeController:MFMailComposeViewController? = MFMailComposeViewController()
        if let mailComposeController = mailComposeController {
            mailComposeController.mailComposeDelegate = self
            
            // configure message recipient
            let parent = Parent()
            if let email = parent.email {
                mailComposeController.setToRecipients([email])
            } else {
                mailComposeController.setToRecipients([EmailConstants.recipient])
            }
            
            // configure message subject and body
            if let testName = self.testName {
                mailComposeController.setSubject(testName + " test reminder")
                var bodyString = String(format: EmailConstants.emailBodyFormatted, testName)
                mailComposeController.setMessageBody(bodyString, isHTML: false)
            } else {
                mailComposeController.setSubject(EmailConstants.subject)
                mailComposeController.setMessageBody(EmailConstants.body, isHTML: false)
            }
        }
        
        return mailComposeController
    }
    
    func presentMailErrorAlert() {
        let alert = UIAlertView(title: EmailConstants.composerErrorTitle, message: EmailConstants.composerErrorMessage, delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}
