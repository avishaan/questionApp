//
//  WhyIsVisualTrackingViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/22/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsVisualTrackingViewController: UIViewController {

  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // analytics
    Tracker.createEvent(.RollingBackToFront, .Load, .Why)
    applyTextAttributesToLabel()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  // Helper function formats text attributes for multiple substrings in label.
  func applyTextAttributesToLabel() {
    
    let string = "Rolling is indication of gross motor development. If there's developmental delays, therapy early on can help baby get back on track."
    
    var attributedString = NSMutableAttributedString(string: string)
    
    let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
    let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    
    attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 60))
    attributedString.addAttributes(boldAttributes, range: NSMakeRange(61, 20))
    //    attributedString.addAttributes(standardAttributes, range: NSMakeRange(71, 75))
    
    descriptionLabel.attributedText = attributedString
  }

}
