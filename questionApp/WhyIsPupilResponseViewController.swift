//
//  WhyIsPupilResponseViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/28/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class WhyIsPupilResponseViewController: UIViewController {
  
  @IBOutlet weak var pupilResponseDescriptionLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // set up attributes for both part of pupil response description label
    let string = "Your baby's pupils should expand and contract in varying light levels. Lack of pupil response can indicate issues with the eyes or nerves connecting eyes to brain."
    var attributedString = NSMutableAttributedString(string: string)
    
    let firstAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
    let secondAttributes = [NSForegroundColorAttributeName: kGrey, NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 22)!]
    
    attributedString.addAttributes(firstAttributes, range: NSMakeRange(0, 70))
    attributedString.addAttributes(secondAttributes, range: NSMakeRange(70, 93))
    
    pupilResponseDescriptionLabel.attributedText = attributedString
    
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
  
}
