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
    Tracker.createEvent(.VisualTracking, .Load, .Why)
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
    
    let string = "Between birth and 4 months, baby should develop the ability to track a moving object by moving just eyes rather than entire head. This is known as lateral tracking."
    
    var attributedString = NSMutableAttributedString(string: string)
    
    let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
    let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    
    attributedString.addAttributes(boldAttributes, range: NSMakeRange(7, 20))
    attributedString.addAttributes(boldAttributes, range: NSMakeRange(147, 16))
    //    attributedString.addAttributes(standardAttributes, range: NSMakeRange(71, 75))
    
    descriptionLabel.attributedText = attributedString
  }

}
