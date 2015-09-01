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
    }
  
  @IBAction func onSubmitTap(sender: UIButton) {
    self.dismissViewControllerAnimated(false, completion: nil)
  }
 
    
}
