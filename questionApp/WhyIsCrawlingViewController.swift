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
      // analytics
      Tracker.createEvent(.Crawl, .Load, .Why)
        applyTextAttributesToLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBackTap(sender: BNBackButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Helper function formats text attributes for multiple substrings in label.
    func applyTextAttributesToLabel() {
        
        let string = "Crawling is an important gross motor milestone that leads to walking and even running later."
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
//        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 35))
//        attributedString.addAttributes(boldAttributes, range: NSMakeRange(35, 30))
//        attributedString.addAttributes(standardAttributes, range: NSMakeRange(65, 77))
      
        descriptionLabel.attributedText = attributedString
    }

}
