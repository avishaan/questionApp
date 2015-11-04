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
  @IBOutlet weak var feedbackText: BNTextView!
  @IBOutlet weak var submit: UIButtonNext!
  @IBOutlet weak var cancel: UIButtonNext!
  @IBOutlet weak var topDistanceConstraint: NSLayoutConstraint!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // allow the user to dismiss the keyboard if they tap the main view
    let tap = UITapGestureRecognizer(target: self, action: "userTappedMainView")
    tap.numberOfTapsRequired = 1
    self.view.addGestureRecognizer(tap)
    
    // Do any additional setup after loading the view.
    Tracker.createEvent(.FeedbackDialog, .Load, .NA)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func userTappedMainView () {
    self.feedbackText.resignFirstResponder()
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
    // save into user defaults that we showed the feedback view controller
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: kHasFeedbackDialogShown)
    
    // submit analytics data
		// setFeedbackInfo in the analytics for future review
		Tracker.setFeedbackInfo(Int(ratingSlider!.value), text: feedbackText.text, finishedSubmit: true)
		

    let messageString = "We'd appreciate it if you would take a moment to leave a review for us on the App Store!"
    let alert: UIAlertController = UIAlertController(title: "Thank you!", message: messageString, preferredStyle: UIAlertControllerStyle.Alert);
    let cancelAction = UIAlertAction(title: "No thanks", style: UIAlertActionStyle.Destructive) { (action) -> Void in
      self.dismissViewControllerAnimated(true, completion: nil)
    }
    let confirmAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
      self.dismissViewControllerAnimated(false, completion: nil)
      self.openInAppStore();
    }
    alert.addAction(cancelAction);
    alert.addAction(confirmAction);
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  func openInAppStore() {
    let appId = "1017013541"
    let urlString = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&id=\(appId)"
    let url = NSURL(string: urlString)!
    UIApplication.sharedApplication().openURL(url)
  }

  @IBAction func onCancelTap(sender: UIButton) {
    self.dismissViewControllerAnimated(false, completion: nil)
    // save into user defaults that we showed the feedback view controller
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: kHasFeedbackDialogShown)
    // submit analytics data
		Tracker.setFeedbackInfo(Int(ratingSlider!.value), text: feedbackText.text, finishedSubmit: false)
  }
  
}
