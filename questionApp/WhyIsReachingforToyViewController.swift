//
//  WhyIsReachingforToyViewController.swift
//  questionApp
//
//  Created by Lekshmi on 9/23/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsReachingforToyViewController: UIViewController {
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Tracker.createEvent(.ReachingForToy, .Load, .Why)
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
    
    let string = "By 7 months, your baby should actively reach for a dangling toy. This test guages baby’s hand-eye coordination, eyesight and cognitive development."
    
    var attributedString = NSMutableAttributedString(string: string)
    
    let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
   // let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    
   // attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 5))
    attributedString.addAttributes(boldAttributes, range: NSMakeRange(39, 26))
    descriptionLabel.attributedText = attributedString
  }

}
