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
  @IBOutlet weak var babyImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setLabel(nameLabel, keyText: "Name: ", valueText: "Molly Smith")
    setLabel(emailLabel, keyText: "Email: ", valueText: "mollys@gmail.com")
    setLabel(babyNameLabel, keyText: "Baby's name: ", valueText: "Lucas")
    setLabel(babyDOBLabel, keyText: "Baby's birthdate: ", valueText: "08/11/2014")
    
    
    // connect image to listen for a tap
    var imageListener = UITapGestureRecognizer(target: self, action: "onImageTap")
    // define taps for the listener
    imageListener.numberOfTapsRequired = 1
    imageListener.numberOfTouchesRequired = 1
    // attach listener to image
    babyImageView.addGestureRecognizer(imageListener)
    // user interaction must be enabled in order to listen for events
    babyImageView.userInteractionEnabled = true
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
  
  // MARK: - Listen to taps on baby's face
  func onImageTap(){
    println("TEST")
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
