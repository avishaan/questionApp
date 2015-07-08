//
//  FallingToyWhatWillYouNeedViewController.swift
//  questionApp
//
//  Created by john bateman on 7/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class FallingToyWhatWillYouNeedViewController: UIViewController {

    @IBOutlet weak var testPreparationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up attributes for both part of pupil response description label
        let string = "You'll need a small, soft, colorful toy. No hard toys - they make a sound on impact and may influence your results."
        println("string length = \(count(string))")
        var attributedString = NSMutableAttributedString(string: string)
        
        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        let firstAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let secondAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, 41))
        attributedString.addAttributes(firstAttributes, range: NSMakeRange(41, 12))
        attributedString.addAttributes(secondAttributes, range: NSMakeRange(53, 62))
        
        testPreparationLabel.attributedText = attributedString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
