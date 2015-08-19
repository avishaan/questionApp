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
    
    attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 41))
    attributedString.addAttributes(boldAttributes, range: NSMakeRange(41, 19))
    attributedString.addAttributes(standardAttributes, range: NSMakeRange(60, 116))
    
    descriptionLabel.attributedText = attributedString
  }

}
