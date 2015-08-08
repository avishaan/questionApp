//
//  WhyIsCompletelyCoveredToyViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/7/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsCompletelyCoveredToyViewController: UIViewController {

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
        
        let string = "This is the final test of baby's grasp of Object Permanence. Object Permanence is the understanding that an object completely hidden from view still exists and can be retrieved."
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 41))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(41, 18))
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(60, 117))
        
        descriptionLabel.attributedText = attributedString
    }
    
}
