//
//  SavedProfileViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SavedProfileViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    var attrLabel = [
      NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 19)!,
      NSForegroundColorAttributeName: kGrey
    ]
    var attrValue = [
      NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 19)!, NSForegroundColorAttributeName: kBlue]
    var myString = "Name: "
    var myString2 = "Molly Smith"
    var combinedString = myString + myString2
    var myMutableString = NSMutableAttributedString(string: combinedString, attributes: attrLabel)
    var range = combinedString.rangeOfString(myString2)
    //Add more attributes here
//    myMutableString.addAttributes(attrValue, range: combinedString.rangeOfString(myString2))
//    myMutableString.addAttributes(attrValue as AnyObject, range: range)
    myMutableString.addAttributes(attrValue, range: NSMakeRange(count(myString), count(myString2)))
//    myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: kOmnesFontMedium, size: 20)!, range: NSMakeRange(count(myString), count(myString2)))
//    myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(count(myString), count(myString2)))
//    myMutableString.addAttribute(attrValue, range: combinedString.rangeOfString(myString2))
    
    //Apply to the label
    emailLabel.attributedText = myMutableString
    
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
