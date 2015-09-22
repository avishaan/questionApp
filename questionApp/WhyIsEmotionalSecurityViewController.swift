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
    Tracker.createEvent(.EmotionalSecurity, .Load, .Why)
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
    
    var attributedString = NSMutableAttributedString(string: string)
    
    let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
  
    attributedString.addAttributes(boldAttributes, range: NSMakeRange(20, 28))
   // attributedString.addAttributes(boldAttributes, range: NSMakeRange(70, 18))
    
    descriptionLabel.attributedText = attributedString
  }
  

}
