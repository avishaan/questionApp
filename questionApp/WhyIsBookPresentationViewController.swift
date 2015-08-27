//
//  WhyIsBookPresentationViewController.swift
//  questionApp
//
//  Created by Brown Magic on 8/18/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsBookPresentationViewController: UIViewController {

  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    
    let string = "This is a test of baby’s Joint Attention abilities. Joint Attention refers to baby’s understanding of pointing, following your gaze, and verbal prompts. All are important steps toward skills needed for reading."
    
    var attributedString = NSMutableAttributedString(string: string)
    
    let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
    let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    
    attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 25))
    attributedString.addAttributes(boldAttributes, range: NSMakeRange(25, 15))
    attributedString.addAttributes(standardAttributes, range: NSMakeRange(40, 136))
    attributedString.addAttributes(boldAttributes, range: NSMakeRange(176, 34))
    
    descriptionLabel.attributedText = attributedString
  }

}
