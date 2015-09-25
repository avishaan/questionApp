//
//  ReceptiveLanguageWhatWillYouNeedViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/22/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class ReceptiveLanguageWhatWillYouNeedViewController: UIViewController {
  @IBOutlet weak var testPreparationLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // analytics
    Tracker.createEvent(.ReceptiveLanguage, .Load, .WhatIsNeeded)
    //applyTextAttributesToLabel()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func onNextStepButtonTap(sender: BNButtonNext) {
    let dontShowIsBabyReadyVC = NSUserDefaults.standardUserDefaults().boolForKey("dontShowIsBabyReady")
    if dontShowIsBabyReadyVC == true {
      
      performSegueWithIdentifier("ReceptiveLanguageTimeToTestSegueID", sender: self)
    } else {
      
      performSegueWithIdentifier("ReceptiveLanguageIsBabyReadySegueID", sender: self)
    }
  }
  
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func applyTextAttributesToLabel() {
    
    let string = "You’ll need your baby, a comfortable crawling surface. You can also have snacks as a lure."
    var attributedString = NSMutableAttributedString(string: string)
    
    let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
    let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    
    attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 14))
    attributedString.addAttributes(boldAttributes, range: NSMakeRange(13, 12))
    //attributedString.addAttributes(standardAttributes, range: NSMakeRange(26, 24))
    
    testPreparationLabel.attributedText = attributedString
  }

}
