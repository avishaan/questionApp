//
//  WhyIsUnassistedSittingViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/5/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsUnassistedSittingViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.UnassistedSitting, .Load, .Why)
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
        
        let string = "Between 4 and 8 months, your baby should be able to sit up without your help by propping herself up with her arms. This is an important gross motor skills milestone."
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 7))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(7, 15))
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(22, 143))
        
        descriptionLabel.attributedText = attributedString
    }
    
}
