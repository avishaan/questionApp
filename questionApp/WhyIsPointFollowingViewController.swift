//
//  WhyIsPointFollowingViewController.swift
//  questionApp
//
//  Created by john bateman on 7/13/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsPointFollowingViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.PointFollowing, .Load, .Why)
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
        
        let string = "Your baby's ability to follow a pointing finger depends on his understanding of social cues. Joint Attention is crucial for language development and social interaction."
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 78))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(79, 12))
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(91, 31))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(123, 21))
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(144, 24))
        
        descriptionLabel.attributedText = attributedString
    }
    
}
