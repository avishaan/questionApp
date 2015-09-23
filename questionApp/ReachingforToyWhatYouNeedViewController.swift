//
//  ReachingforToyWhatYouNeedViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/23/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class ReachingforToyWhatYouNeedViewController: UIViewController {
  @IBOutlet weak var testPreparationLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // analytics
    Tracker.createEvent(.ReachingForToy, .Load, .WhatIsNeeded)
    applyTextAttributesToLabel()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func onNextStepButtonTap(sender: BNButtonNext) {
    let dontShowIsBabyReadyVC = NSUserDefaults.standardUserDefaults().boolForKey("dontShowIsBabyReady")
    if dontShowIsBabyReadyVC == true {
      
      performSegueWithIdentifier("ReachingForToyTimeToTestSegueID", sender: self)
    } else {
      
      performSegueWithIdentifier("ReachingForToyIsBabyReadySegueID", sender: self)
    }
  }
  
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func applyTextAttributesToLabel() {
    
    let string = "All you’ll need is a comfortable spot for baby to sit, plus a favorite small toy. Hang it on a string to be sure baby isn’t just reaching for your hand."
    var attributedString = NSMutableAttributedString(string: string)
    
    let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]

    attributedString.addAttributes(boldAttributes, range: NSMakeRange(80, 21))
    
    testPreparationLabel.attributedText = attributedString
  }

}
