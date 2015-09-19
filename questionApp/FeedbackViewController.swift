//
//  FeedbackViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 8/15/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {
  
  @IBOutlet weak var ratingSlider: UISlider!
  @IBOutlet weak var ratingNumber: UILabel!
  @IBOutlet weak var feedbackText: UITextView!
  @IBOutlet weak var submit: UIButton!
  @IBOutlet weak var cancel: UIButton!
  @IBOutlet weak var topDistanceConstraint: NSLayoutConstraint!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func sliderValueChanged(sender: AnyObject) {
    // convert to int
    var currentValue = Int(ratingSlider!.value)
    ratingNumber.text = "\(currentValue)"
    
    // check the current slider value
    if (currentValue < 8) {
      // if number is too low show the text field and cancel button
      feedbackText.hidden = false
      cancel.hidden = false
      topDistanceConstraint.constant = 453
    } else {
      // else if the number is high, remove those fields
      feedbackText.hidden = true
      cancel.hidden = true
      topDistanceConstraint.constant = 453 - 187
    }
    
  }
  
  @IBAction func onSubmitTap(sender: UIButton) {
    self.dismissViewControllerAnimated(false, completion: nil)
    // save into user defaults that we showed the feedback view controller
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: kHasFeedbackDialogShown)
  }
  
  @IBAction func onCancelTap(sender: UIButton) {
    self.dismissViewControllerAnimated(false, completion: nil)
    // save into user defaults that we showed the feedback view controller
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: kHasFeedbackDialogShown)
  }
  
}
