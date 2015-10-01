//
//  BNSharingManager.swift
//  questionApp
//
//  Created by Lekshmi on 9/26/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

class BNSharingManager {
  
  static private let sharedTestsKey = "sharedTestsKey"
  static private let sharedTestsCount = "sharedTestsCount"
  
  // MARK: - Save shared tests
  static func saveSharedTestWithName(name: String?) {

    if name != nil {
      // Save the test name in an array under a key if not nil
      var sharedTests = NSUserDefaults.standardUserDefaults().objectForKey(sharedTestsKey) as? [String]
      if sharedTests == nil {
        sharedTests = [String]()
      }
      sharedTests?.append(name!)
      NSUserDefaults.standardUserDefaults().setObject(sharedTests, forKey: sharedTestsKey)
      NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // Increment the counter for shared tests
    let count = NSUserDefaults.standardUserDefaults().integerForKey(sharedTestsCount)
    NSUserDefaults.standardUserDefaults().setInteger(count + 1, forKey: sharedTestsCount)
  }
  
  // MARK: - Retrieve shared tests
  static func getSharedTestNames() -> [String] {
    let sharedTests = NSUserDefaults.standardUserDefaults().objectForKey(sharedTestsKey) as? [String]
    if let sharedTests = sharedTests {
      return sharedTests
    }
    return []
  }
  
  static func hasUserSharedTestWithName(name: String) -> Bool {
    if getSharedTestNames().filter({ $0 == name}).count > 0 {
      return true
    } else {
      return false
    }
  }
  
  // Retrieve shared tests count
  static func getSharedTestCount() -> Int {
    return NSUserDefaults.standardUserDefaults().integerForKey(sharedTestsCount)
  }

  static func hasUserSharedTests() -> Bool {
    if getSharedTestCount() > 0 {
      return true
    } else {
      return false
    }
  }
  
  // MARK: - Helper functions
  static func presentShareSheet(parentViewController: UIViewController, testName: String?) {
    // Set data to display in share sheet
    let text = "My baby reached a new milestone today! More on "
    let logoImage = UIImage(named: "AppIcon40x40")
    let nogginURL = NSURL(string: "http://appstore.com/BabyNoggin")
    var objectsToShare:[AnyObject] = [text]
    if let logoImage = logoImage, nogginURL = nogginURL {
      objectsToShare.append(logoImage)
      objectsToShare.append(nogginURL)
    }
    
    // Create an Activity View controller
    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
    
    // Excluded Unnecessesary Activities
    activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList,UIActivityTypePostToTwitter,  UIActivityTypeCopyToPasteboard,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll,UIActivityTypePostToTencentWeibo, UIActivityTypeAssignToContact]
    
    // Setup a block to execute later
    activityVC.completionWithItemsHandler = { activityType, success, returnedItems, error in
      if success {
        self.saveSharedTestWithName(testName)
        self.presentUnlockNotification(parentViewController, testName: testName)
        if parentViewController.respondsToSelector(Selector("checkNumberOfShares")){
          parentViewController.performSelector(Selector("checkNumberOfShares"))
        }
      } else {
        print("Sharing failed")
        return
      }
    }
    
    // Presene the activity sheet
    parentViewController.presentViewController(activityVC, animated: true, completion: nil)
  }
  
  static func presentUnlockNotification(parentViewController: UIViewController, testName: String?) {
    // Show the alert
    var messageString = "Thank you for sharing!"
    let tests = getListOfUnlockedTests()
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
  
  static func getListOfUnlockedTests() -> [String] {
    let numberOfShares = getSharedTestCount()
    let tests = NSMutableArray()
    if numberOfShares == 1 {
      tests.addObject(Test.TestNamesPresentable.partiallyCoveredToy)
      tests.addObject(Test.TestNamesPresentable.pointFollowing)
    }
    else if numberOfShares == 2 {
      tests.addObject(Test.TestNamesPresentable.symmetry)
      tests.addObject(Test.TestNamesPresentable.reachingWhileSitting)
      tests.addObject(Test.TestNamesPresentable.facialMimic)
    }
    else if numberOfShares == 3 {
      tests.addObject(Test.TestNamesPresentable.receptiveLanguage)
      tests.addObject(Test.TestNamesPresentable.unassistedSitting)
      tests.addObject(Test.TestNamesPresentable.emotionalSecurity)
    }
    else if numberOfShares == 4 {
      tests.addObject(Test.TestNamesPresentable.letsCrawl)
      tests.addObject(Test.TestNamesPresentable.rollingBackToFront)
      tests.addObject(Test.TestNamesPresentable.completelyCoveredToy)
    }
    
    return tests as NSArray as! [String]
  }
  
  
}