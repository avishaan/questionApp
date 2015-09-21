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
    
    static private let facebookKeys: String = "facebookKeys"
  // key name to track if user has shared to facebook
  static private let hasSharedFacebook = "hasSharedFacebookKey"
    
    static private func sha256(value : String) -> String {
        let data = value.dataUsingEncoding(NSUTF8StringEncoding)!
        var hash = [UInt8](count: Int(CC_SHA256_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA256(data.bytes, CC_LONG(data.length), &hash)
        let hexBytes = map(hash) { String(format: "%02hhx", $0) }
        return "".join(hexBytes)
    }
    
    static private func trueShaForName(name : String) -> String {
        let truthValue = name + "true"
        let sha = sha256(truthValue)
        return sha
    }

    static private func userSharedTestWithName(name: String) {
        // since NSUserDefaults is accessible by the user,
        // let's just apply a simple SHA-based safeguard to prevent users
        // modifying the value directly
        var keys = NSUserDefaults.standardUserDefaults().dictionaryForKey(facebookKeys) as? [String:String]
        if (keys == nil) {
            keys = [:]
        }
        let sha = trueShaForName(name)
        keys?[name] = sha
        NSUserDefaults.standardUserDefaults().setObject(keys, forKey: facebookKeys)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
  
  // if user shared any test, save
  static private func userSharedTest() {
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: hasSharedFacebook)
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  // see if user has shared any test
  static func hasUserSharedTest() -> Bool {
    if NSUserDefaults.standardUserDefaults().boolForKey(hasSharedFacebook) {
      return true
    }
    return false
  }
    
    /*
    Test to see if a user has shared the supplied test via Facebook.
    */
    static func hasUserSharedTestWithName(name: String) -> Bool {
        var keys = NSUserDefaults.standardUserDefaults().dictionaryForKey(facebookKeys) as? [String:String]
        if let value: String = keys?[name] {
            let sha = trueShaForName(name)
            if value == sha {
                return true
            }
        }
        return false
    }
  
    static func showShareErrorMessage() {
      let messageString = "Please share your results on Facebook in order to unlock this test!"
      let alert = UIAlertView(title: nil, message: messageString, delegate: nil, cancelButtonTitle: "Ok")
      alert.show()
    }
    
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
          
            composeController.completionHandler = { result in
              if (result == SLComposeViewControllerResult.Done) {
                self.userSharedTestWithName(testName)
                self.userSharedTest()
              }
            }
            
            // display the social view controller
            parentViewController.presentViewController(composeController, animated:true, completion:nil)
        }
        else {
            let messageString = "No Facebook account was found on this device. You can login to Facebook using the Facebook app, or select Facebook in the device Settings application, then try Share again."
            let alert = UIAlertView(title: "Facebook Account Required", message: messageString, delegate: parentViewController, cancelButtonTitle: "Ok")
            alert.show()
        }
    }
}