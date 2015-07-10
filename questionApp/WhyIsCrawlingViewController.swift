//
//  WhyIsCrawlingViewController.swift
//  questionApp
//
//  Created by john bateman on 7/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsCrawlingViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backButton: BNBackButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // set up attributes for both part of object permanence description label
        let string = "Crawling is one indicator of baby's Gross Motor Development level. Results from this test can reveal areas in his growth that can be improved."
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        println("string length = \(count(string))")
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 35))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(35, 30))
        attributedString.addAttributes(standardAttributes, range: NSMakeRange(65, 77))
        
        descriptionLabel.attributedText = attributedString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBackTap(sender: BNBackButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
