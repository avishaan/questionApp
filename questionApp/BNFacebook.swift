//
//  BNFacebook.swift
//  questionApp
//
//  Created by john bateman on 8/14/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation
import Social

class BNFacebook {
    
    /*
    @brief Show prepopulated UI that allows a user to enter edit and post it to facebook.
    @discussion Presents the social VC modally on top of the parentViewController.
    @param (in) parentViewController - The parent view controller. (cannot be nil)
    @param (in) testName - A Test.TestNamesPresentable value identifying the test. This string is presented to the end user. (cannot be nil)
    */
    static func postToFacebook(parentViewController: UIViewController, testName: String) {

         if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            var composeController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            // set initial text
            var text = String(format:"My baby just passed the %@ test!", testName)
            composeController.setInitialText(text)
            
            // set image
            let logoImage = UIImage(named: "AppIcon40x40") as UIImage!
            composeController.addImage(logoImage!)
            
            // set url
            let nogginURL = NSURL(string: "http://www.babynoggin.com")
            composeController.addURL(nogginURL)
            
            // display the social view controller
            parentViewController.presentViewController(composeController, animated:true, completion:nil)
        }
        else {
            let messageString = "No Facebook account was found on this device. Please login using the Facebook app or the device Settings application."
            let alert = UIAlertView(title: "No Facebook Account", message: messageString, delegate: parentViewController, cancelButtonTitle: "Ok")
        }
    }
}