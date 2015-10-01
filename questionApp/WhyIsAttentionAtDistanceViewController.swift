//
//  WhyIsAttentionAtDistanceViewController.swift
//  questionApp
//
//  Created by john bateman on 7/15/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsAttentionAtDistanceViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.AttentionAtDistance, .Load, .Why)
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
        
        let string = "Your baby should be able to remain focused on an object 3-4' away by 6 months of age. Its an indicator of attention, vision, and cogintitive abilities."
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 54))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(55, 11))
  
        
        descriptionLabel.attributedText = attributedString
    }
}
