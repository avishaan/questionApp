//
//  PlasticJarWhatWillYouNeedViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class PlasticJarWhatWillYouNeedViewController: UIViewController {

    @IBOutlet weak var testPreparationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTextAttributesToLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onNextStepButtonTap(sender: AnyObject) {
        let dontShowIsBabyReadyVC = NSUserDefaults.standardUserDefaults().boolForKey("dontShowIsBabyReady")
        if dontShowIsBabyReadyVC == true {
            performSegueWithIdentifier("plasticJarTimeToTestSegueID", sender: self)
        } else {
            performSegueWithIdentifier("plasticJarIsBabyReadySegueID", sender: self)
        }
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // Helper function formats text attributes for multiple substrings in label.
    func applyTextAttributesToLabel() {
        
        let string = "For this test, you’ll need a large plastic jar with a lid and two wind-up toys that will fit inside. "

        var attributedString = NSMutableAttributedString(string: string)
        
        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        let firstAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let secondAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, 65))
        attributedString.addAttributes(firstAttributes, range: NSMakeRange(65, 13))
        attributedString.addAttributes(secondAttributes, range:NSMakeRange(78, 23))
        
        testPreparationLabel.attributedText = attributedString
    }
}
