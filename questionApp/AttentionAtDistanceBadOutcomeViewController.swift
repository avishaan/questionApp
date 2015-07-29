//
//  AttentionAtDistanceBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/15/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class AttentionAtDistanceBadOutcomeViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AADToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = TestNamesPresentable.attentionAtDistance
        }
    }
    
    @IBAction func onHomeButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
        self.presentViewController(controller, animated: true, completion: nil);
        
    }
    
    // Helper function formats text attributes for multiple substrings in label.
    func applyTextAttributesToLabel() {
        
        let string = "Not to worry! Not all babies develop at the same rate. Try and be sure baby is rested, fed, and alert."
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        
        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, 54))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(55, 46)) //115
        
        infoLabel.attributedText = attributedString
    }
}
