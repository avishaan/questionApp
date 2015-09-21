//
//  RollingBacktoFrontTestIsBabyReadyViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/20/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class RollingBacktoFrontTestIsBabyReadyViewController: UIViewController {

  @IBOutlet weak var bulletedLabel1: UILabel!
  @IBOutlet weak var bulletedLabel2: UILabel!
  @IBOutlet weak var bulletedLabel3: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // analytics
    Tracker.createEvent(.SittingReaching, .Load, .IsReady)
    
    applyTextAttributesToLabel()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func onNextStepButtonTap(sender: AnyObject) {
    performSegueWithIdentifier("rollingBackto FrontIsBabyReadyToTimeToTestSegueID", sender: self)
  }
  
  @IBAction func onDontShowAgainButtonTap(sender: AnyObject) {
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "dontShowIsBabyReady")
    performSegueWithIdentifier("rollingBackto FrontIsBabyReadyToTimeToTestSegueID", sender: self)
  }
  
  // Helper function formats text attributes for substrings in labels.
  func applyTextAttributesToLabel() {
    
    let orangeAtrributes = [NSForegroundColorAttributeName: kOrange, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
    let greyAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    
    // The first character of each label should be orange, the rest grey.
    
    // label 1
    var attributedString1 = NSMutableAttributedString(string: bulletedLabel1.text!)
    attributedString1.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
    attributedString1.addAttributes(greyAttributes, range: NSMakeRange(2, 18))
    bulletedLabel1.attributedText = attributedString1
    
    // label 2
    var attributedString2 = NSMutableAttributedString(string: bulletedLabel2.text!)
    attributedString2.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
    attributedString2.addAttributes(greyAttributes, range: NSMakeRange(2, 15))
    bulletedLabel2.attributedText = attributedString2
    
    // label 3
    var attributedString3 = NSMutableAttributedString(string: bulletedLabel3.text!)
    attributedString3.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
    attributedString3.addAttributes(greyAttributes, range: NSMakeRange(2, 17))
    bulletedLabel3.attributedText = attributedString3
  }

}
