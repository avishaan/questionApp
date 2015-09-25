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
  static private let FacebookShareCountMain: String = "FacebookShareCountMain"
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
  static private func userSharedTest(testName: String?) {
    // only increment if we came from the front page
    if testName == nil {
      let count = NSUserDefaults.standardUserDefaults().integerForKey(FacebookShareCountMain)
      NSUserDefaults.standardUserDefaults().setInteger(count+1, forKey: FacebookShareCountMain)
    }
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  static func userShareCountFromFront() -> Int {
    let count = NSUserDefaults.standardUserDefaults().integerForKey(FacebookShareCountMain)
    return count
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
  
    /**
    TODO: We should define this mapping in one place for ease
    */
    static func getListOfUnlockedTests() -> [String] {
      let facebookShares = BNFacebook.userShareCountFromFront()
      let tests = NSMutableArray()
      if facebookShares == 1 {
        tests.addObject(Test.TestNamesPresentable.partiallyCoveredToy)
        tests.addObject(Test.TestNamesPresentable.pointFollowing)
      }
      else if facebookShares == 2 {
        tests.addObject(Test.TestNamesPresentable.symmetry)
        tests.addObject(Test.TestNamesPresentable.reachingWhileSitting)
        tests.addObject(Test.TestNamesPresentable.facialMimic)
      }
      else if facebookShares == 3 {
        tests.addObject(Test.TestNamesPresentable.receptiveLanguage)
        tests.addObject(Test.TestNamesPresentable.unassistedSitting)
        tests.addObject(Test.TestNamesPresentable.emotionalSecurity)
      }
      else if facebookShares == 4 {
        tests.addObject(Test.TestNamesPresentable.letsCrawl)
        tests.addObject(Test.TestNamesPresentable.rollingBackToFront)
        tests.addObject(Test.TestNamesPresentable.completelyCoveredToy)
      }

      return tests as NSArray as! [String]
    }
  
    /*
    @brief Show prepopulated UI that allows a user to enter edit and post it to facebook.
    @discussion Presents the social VC modally on top of the parentViewController.
    @param (in) parentViewController - The parent view controller. (cannot be nil)
    @param (in) testName - A Test.TestNamesPresentable value identifying the test. This string is presented to the end user. (cannot be nil)
    */
    static func postToFacebook(parentViewController: UIViewController, testName: String?) {

         if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            var composeController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            // set initial text
            var text = "My baby reached a new milestone today! More on"
            if let testName = testName {
              let parent = Parent()
              let babyName = parent.babyName
              text = "My baby \(babyName) passed \(testName) test today! More on"
            }
            composeController.setInitialText(text)
            
            // set image
            let logoImage = UIImage(named: "AppIcon40x40") as UIImage!
            composeController.addImage(logoImage!)
            
            // set url
            let nogginURL = NSURL(string: "http://appstore.com/BabyNoggin")
            composeController.addURL(nogginURL)
          
            composeController.completionHandler = { result in
              if (result == SLComposeViewControllerResult.Done) {
                self.userSharedTest(testName)
                if let testName = testName {
                  self.userSharedTestWithName(testName)
                }
                else {
                  // show the alert, if the user shared from the front page
                  var messageString = "Thank you for sharing!"
                  let tests = self.getListOfUnlockedTests()
                  if tests.count > 0 {
                    var testString = ""
                    var counter = 0;
                    for test in tests {
                      if (counter == (tests.count - 1)) {
                        testString += "and \(test)"
                      }
                      else {
                        testString += "\(test), "
                      }
                      counter++
                    }
                    messageString += " \(tests.count) new tests have been unlocked: \(testString)!"
                  }
                  let alert = UIAlertView(title: nil, message: messageString, delegate: parentViewController, cancelButtonTitle: "Ok")
                  alert.show()
                }
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