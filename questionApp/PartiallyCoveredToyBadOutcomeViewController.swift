//
//  SocialSmilingBadOutcomeViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 7/28/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SocialSmilingBadOutcomeViewController: UIViewController {
  
    /** A Test containing the updated test history. This property should be set by the source view controller. */
  var test:Test?
  
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if segue.identifier == "socialSmilingToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = TestNamesPresentable.socialsmiling
        }
    }
    
    @IBAction func onHomeButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
        self.presentViewController(controller, animated: true, completion: nil);
        
    }
    
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
        let failed = test?.failedTestsCount()
        
        if failed <= 1 {
            // update infoLabel
            let string = "Not to worry. Lucas is a bit too young for this skill. Try again in 2 weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:22)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Not social smiling?"
            
            // update infoLabel
            let string = "Try this: get baby's attention by making a sound. You may also show baby a toy while talking and smiling. Does baby smile? If not, try again in 2 weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:122, countOfBoldCharacters:29)
            
        } else if failed == 3 {
            // update questionLabel
            questionLabel.text = "Not social smiling?"
            
            // update infoLabel
            let string = "Perform this test a few more times to be sure the outcome is consistent. If so, record this test to show your pediatrician."
            applyTextAttributesToLabel(string, indexAtStartOfBold:72, countOfBoldCharacters:48)
        } else {
            // update questionLabel
            questionLabel.text = "Not social smiling?"
            
            // update infoLabel
            let string = "Not to worry. Lucas is a bit too young for this skill. Try again in 2 weeks."
            applyTextAttributesToLabel(string, indexAtStartOfBold:54, countOfBoldCharacters:22)
        }
    }
}
