//
//  CrossingEyesBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/14/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class CrossingEyesBadOutcomeViewController: UIViewController {

    /** A Test containing the updated test history. This property should be set by the source view controller. */
    var test: Test?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO - remove ... applyTextAttributesToLabel()
        initializeViewFromTestHistory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "crossingEyesToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = TestNamesPresentable.crossingEyes
        }
    }
    
    @IBAction func onHomeButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
        self.presentViewController(controller, animated: true, completion: nil);
        
    }
    
    // Helper function formats text attributes for multiple substrings in label.
//    func applyTextAttributesToLabel() {
//        
//        let string = "Not to worry. Sometimes practicing using a squeaky toy will help. Try this, then perform the test again in 2 weeks."
//        
//        var attributedString = NSMutableAttributedString(string: string)
//        
//        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
//        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
//        
//        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, 65))
//        attributedString.addAttributes(boldAttributes, range: NSMakeRange(66, 49))
//        
//        infoLabel.attributedText = attributedString
//    }
    
    // Helper function formats text attributes for multiple substrings in label.
    func applyTextAttributesToLabel(string: String, indexAtStartOfBold index: Int, countOfBoldCharacters count: Int) {
        
        var attributedString = NSMutableAttributedString(string: string)
        
        let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
        let boldAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
        
        attributedString.addAttributes(baseAttributes, range: NSMakeRange(0, index > 0 ? index - 1 : index))
        attributedString.addAttributes(boldAttributes, range: NSMakeRange(index, count))
        
        infoLabel.attributedText = attributedString
    }
    
    /*!
    @brief Initialize the text in the view based on the number of failed tests.
    */
    func initializeViewFromTestHistory() {
        var failed = 0
        if let failedCount = test?.failedTestsCount() {
            failed = failedCount
        }
        
        if failed <= 1 {
            // update infoLabel
            let string = "Not to worry! Not all babies develop at the same rate.\nTry again and be sure baby is rested, fed, and alert."
            applyTextAttributesToLabel(string, indexAtStartOfBold:55, countOfBoldCharacters:53)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Didn't cross his eyes?"
            
            // update infoLabel
            let string = "Not to worry! Sometimes practicing using a squeaky toy will help. Try this, then perform the test again in 2 weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:66, countOfBoldCharacters:49)
            
        } else if failed >= 3 {
            // update questionLabel
            questionLabel.text = "Didn't cross his eyes?"
            
            // update infoLabel
            let string = "Do the test a few more times to be sure the outcome is consistent. If so, record this test to show your pediatrician."
            applyTextAttributesToLabel(string, indexAtStartOfBold:67, countOfBoldCharacters:50)
        } else {
            // update questionLabel
            questionLabel.text = "Didn't cross his eyes?"
            
            // update infoLabel
            let string = "Not to worry! Not all babies develop at the same rate.\nTry again and be sure baby is rested, fed, and alert."
            applyTextAttributesToLabel(string, indexAtStartOfBold:55, countOfBoldCharacters:53)
        }
    }

}
