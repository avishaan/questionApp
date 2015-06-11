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
  @IBOutlet weak var babyNameLabel: UILabel!
  @IBOutlet weak var babyDOBLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setLabel(nameLabel, keyText: "Name: ", valueText: "Molly Smith")
    setLabel(emailLabel, keyText: "Email: ", valueText: "mollys@gmail.com")
    setLabel(babyNameLabel, keyText: "Baby's name: ", valueText: "Lucas")
    setLabel(babyDOBLabel, keyText: "Baby's birthdate: ", valueText: "08/11/2014")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setLabel(label:UILabel, keyText:String, valueText:String){
    // label is the uiLabel, keyText is first part of text, valueText is second part
    var attrKey = [
      NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 19)!,
      NSForegroundColorAttributeName: kGrey
    ]
    var attrValue = [
      NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 19)!, NSForegroundColorAttributeName: kBlue]
    // full label text
    var fullText = keyText + valueText
    var fullTextMutableString = NSMutableAttributedString(string: fullText, attributes: attrKey)
    
    // don't use range of string incase someone repeats a string
    fullTextMutableString.addAttributes(attrValue, range: NSMakeRange(count(keyText), count(valueText)))
    //Apply to the label
    label.attributedText = fullTextMutableString
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
