//
//  SymmetryBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/16/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SymmetryBadOutcomeViewController: UIViewController {

    /** A history of previous test outcomes. This property should be set by the source view controller. */
    var histories = TestHistories()
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = "Not to worry! All babies develop at the different rates. Try again tomorrow."
        applyTextAttributesToLabel(string, indexAtStartOfBold:57, countOfBoldCharacters:19)
        
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
        if segue.identifier == "symmetryToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            
            // set the test name on the ActivityReminder VC
            controller.testName = TestNames.symmetry
        }
    }
    
    @IBAction func onHomeButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
        self.presentViewController(controller, animated: true, completion: nil);
        
    }
    
    // Helper function formats text attributes for multiple substrings in label.
    func applyTextAttributesToLabel(string: String, indexAtStartOfBold index: Int, countOfBoldCharacters count: Int) {
        
        //let string = "Not to worry! All babies develop at the different rates. Try again tomorrow."
        
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
        let failed = histories.failedTestsCount(testName: TestHistories.TestNames.symmetry)
        
        if failed <= 1 {
            // update infoLabel
            let string = "Not to worry! All babies develop at the different rates. Try again tomorrow."
            applyTextAttributesToLabel(string, indexAtStartOfBold:57, countOfBoldCharacters:19)
        } else if failed == 2 {
            // update questionLabel
            questionLabel.text = "Still not symmetrical?"
            
            // update infoLabel
            let string = "Your baby may not have the motor skills to extend her arms or legs yet. Try again next month."
            applyTextAttributesToLabel(string, indexAtStartOfBold:72, countOfBoldCharacters:21)
            
        } else if failed == 3 {
            // update questionLabel
            questionLabel.text = "Still not symmetrical?"
            
            // update infoLabel
            let string = "Since your baby is under 12 months, she still has time to develop those muscles. If you're concerned, check with your pediatrician."
            applyTextAttributesToLabel(string, indexAtStartOfBold:81, countOfBoldCharacters:50)
        } else if failed >= 4 {
            // update questionLabel
            questionLabel.text = "Still not symmetrical?"
            
            // update infoLabel
            let string = "Are baby's limbs consistently weaker on one side? If yes, please check with your pediatrician during your next well-child visit."
            applyTextAttributesToLabel(string, indexAtStartOfBold:50, countOfBoldCharacters:78)
        } else {
            // update questionLabel
            questionLabel.text = "Not symmetrical?"
            
            // update infoLabel
            let string = "Not to worry! All babies develop at the different rates. Try again tomorrow."
            applyTextAttributesToLabel(string, indexAtStartOfBold:57, countOfBoldCharacters:19)
        }
    }
}
