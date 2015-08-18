//
//  HearingWhatWillYouNeedViewController.swift
//  questionApp
//
//  Created by john bateman on 7/15/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class HearingWhatWillYouNeedViewController: UIViewController {

    @IBOutlet weak var testPreparationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.Hearing, .Load, .WhatIsNeeded)
        //applyTextAttributesToLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNextStepButtonTap(sender: AnyObject) {
        let dontShowIsBabyReadyVC = NSUserDefaults.standardUserDefaults().boolForKey("dontShowIsBabyReady")
        if dontShowIsBabyReadyVC == true {
            performSegueWithIdentifier("hearingTimeToTestSegueID", sender: self)
        } else {
            performSegueWithIdentifier("hearingIsBabyReadySegueID", sender: self)
        }
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Helper function formats text attributes for multiple substrings in label.
//    func applyTextAttributesToLabel() {
//        
//        let string = "For this test, you may clap your hands, whistle, or simply call your baby's name."
//        
//        var attributedString = NSMutableAttributedString(string: string)
//        
//        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
//        let firstAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
//        let secondAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
//        
//        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, 13))
//        attributedString.addAttributes(firstAttributes, range: NSMakeRange(14, 25))
//        attributedString.addAttributes(secondAttributes, range: NSMakeRange(40, 44))
//        
//        testPreparationLabel.attributedText = attributedString
//    }
}
