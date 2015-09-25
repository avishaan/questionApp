//
//  WhyIsObjectPermanenceViewController.swift
//  questionApp
//
//  Created by john bateman on 7/7/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsObjectPermanenceViewController: UIViewController {

    @IBOutlet weak var objectPermanenceDescriptionLabel: UILabel!
    @IBOutlet weak var backButton: BNBackButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.AttentionAtDistance, .Load, .Why)

        // set up attributes for both part of object permanence description label
        let string = "Your baby’s grasp of Object Permanence can be tested with a falling toy. Object Permanence allows baby to form mental pictures and is critical in forming individual mental theories."
        var attributedString = NSMutableAttributedString(string: string)
        
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        let standardAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        
//        attributedString.addAttributes(standardAttributes, range: NSMakeRange(0, 20))
//        attributedString.addAttributes(boldAttributes, range: NSMakeRange(20, 18))
//        attributedString.addAttributes(standardAttributes, range: NSMakeRange(38, 124))
      
        objectPermanenceDescriptionLabel.attributedText = attributedString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onBackTap(sender: BNBackButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
