//
//  WhyIsPlasticJarViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsPlasticJarViewController: UIViewController {

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
        
        let string = "This activity tests your baby’s ability to ask for things and respond to requests from others. This is another form of Joint Attention."
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 42))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(42, 15))
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(57, 61))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(118, 17))
        
        descriptionLabel.attributedText = attributedString
    }
    
}
