//
//  PupilResponseWhatWillYouNeedViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/28/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class PupilResponseWhatWillYouNeedViewController: UIViewController {
  
  @IBOutlet weak var testPreparationLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // set up attributes for both part of pupil response description label
    let string = "You can use the light on your phone (if the baby will keep his hands off it!) or a pen light. Not too bright though."
    var attributedString = NSMutableAttributedString(string: string)
    
    let baseAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    let firstAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
    let secondAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    
    attributedString.addAttributes(baseAttributes, range: NSMakeRange(1, 16))
    attributedString.addAttributes(firstAttributes, range: NSMakeRange(16, 19))
    attributedString.addAttributes(secondAttributes, range: NSMakeRange(36, 80))
    
    testPreparationLabel.attributedText = attributedString
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
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}
