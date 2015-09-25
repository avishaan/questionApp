//
//  JointAttentionWhatYouWillNeedViewController.swift
//  questionApp
//
//  Created by Michael Leung on 8/17/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class JointAttentionWhatWillYouNeedViewController: UIViewController {
    
    @IBOutlet weak var testPreparationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTextAttributesToLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onNextStepButtonTap(sender: BNButtonNext) {
        let dontShowIsBabyReadyVC = NSUserDefaults.standardUserDefaults().boolForKey("dontShowIsBabyReady")
        if dontShowIsBabyReadyVC == true {
            
            performSegueWithIdentifier("JointAttentionTimeToTestSegueID", sender: self)
        } else {
            
            performSegueWithIdentifier("JointAttentionIsBabyReadySegueID", sender: self)
        }
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func applyTextAttributesToLabel() {
        
        let string = "Get your phone and sit comfortably with baby."
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
//        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 14))
//        attributedString.addAttributes(boldAttributes, range: NSMakeRange(13, 12))
//        attributedString.addAttributes(standardAttributes, range: NSMakeRange(26, 24))
      
        testPreparationLabel.attributedText = attributedString
    }
    
    
}