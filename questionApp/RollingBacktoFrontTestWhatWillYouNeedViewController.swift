//
//  RollingBacktoFrontTestWhatWillYouNeedViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/20/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class RollingBacktoFrontTestWhatWillYouNeedViewController: UIViewController {

  @IBOutlet weak var testPreparationLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // analytics
    Tracker.createEvent(.RollingBackToFront, .Load, .WhatIsNeeded)
    applyTextAttributesToLabel()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onNextStepButtonTap(sender: AnyObject) {
    let dontShowIsBabyReadyVC = NSUserDefaults.standardUserDefaults().boolForKey("dontShowIsBabyReady")
    if dontShowIsBabyReadyVC == true {
      performSegueWithIdentifier("rollingBacktoFrontTimeToTestSegueID", sender: self)
    } else {
      performSegueWithIdentifier("rollingBacktoFrontIsBabyReadySegueID", sender: self)
    }
  }
  
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  // Helper function formats text attributes for multiple substrings in label.
  func applyTextAttributesToLabel() {
    
    let string = "All you’ll need is a firm surface on which baby can comfortably lie."
    
    var attributedString = NSMutableAttributedString(string: string)
    
    let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    let firstAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
    let secondAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    
    attributedString.addAttributes(firstAttributes, range: NSMakeRange(20, 14))
    
    testPreparationLabel.attributedText = attributedString
  }

}
