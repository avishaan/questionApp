//
//  LetsCrawlWhatWillYouNeedViewController.swift
//  questionApp
//
//  Created by john bateman on 7/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class LetsCrawlWhatWillYouNeedViewController: UIViewController {

    @IBOutlet weak var testPreparationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.Crawl, .Load, .WhatIsNeeded)

        applyTextAttributesToLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onNextStepButtonTap(sender: AnyObject) {
        let dontShowIsBabyReadyVC = NSUserDefaults.standardUserDefaults().boolForKey("dontShowIsBabyReady")
        if dontShowIsBabyReadyVC == true {
            performSegueWithIdentifier("letsCrawlTimeToTestSegueID", sender: self)
        } else {
            performSegueWithIdentifier("letsCrawlIsBabyReadySegueID", sender: self)
        }
    }
    
    // Helper function formats text attributes for multiple substrings in label.
    func applyTextAttributesToLabel() {
        
        let string = "All you'll need is a soft floor both you and your baby can sit and crawl on."
        var attributedString = NSMutableAttributedString(string: string)
        
        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        let firstAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let secondAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, 21))
        attributedString.addAttributes(firstAttributes, range: NSMakeRange(21, 10))
        attributedString.addAttributes(secondAttributes, range: NSMakeRange(31, 45))
        
        testPreparationLabel.attributedText = attributedString
    }

}
