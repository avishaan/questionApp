//
//  WhyIsReachingWhileSittingViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/9/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsReachingWhileSittingViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.SittingReaching, .Load, .Why)
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
        
        let string = "Between 5 and 10 months, your baby should be able to sit without propping herself up with her arms and reach for a toy or other object. This is an important milestone on the way to standing and walking."
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 7))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(7, 16))
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(23, 158))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(180, 22))

        
        descriptionLabel.attributedText = attributedString
    }
    
}
