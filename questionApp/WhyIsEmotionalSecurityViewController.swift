//
//  WhyIsEmotionalSecurityViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/21/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsEmotionalSecurityViewController: UIViewController {

  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // analytics
    Tracker.createEvent(.EmotionalAttachment, .Load, .Why)
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
    
    let string = "Baby will recognize familiar faces of caregivers and may show negative reactions to strangers by the end of first year."
//    
//    var attributedString = NSMutableAttributedString(string: string)
//    
//    let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
//    let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
//    
//    // attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 73))
//    attributedString.addAttributes(boldAttributes, range: NSMakeRange(25, 18))
//    attributedString.addAttributes(boldAttributes, range: NSMakeRange(165, 18))
//    
//    descriptionLabel.attributedText = attributedString
  }
  

}
