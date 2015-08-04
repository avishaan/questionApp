//
//  SensoryMotorMilestoneViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/27/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SensoryMotorMilestoneViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onCrossingEyesButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "CrossingEyes", bundle: nil)
    var controller: WhyIsCrossingEyesViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCrossingEyesStoryboardID") as! WhyIsCrossingEyesViewController
    self.presentViewController(controller, animated: true, completion: nil);
  }
  
  @IBAction func onHearingButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "Hearing", bundle: nil)
    var controller: WhyIsHearingViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsHearingStoryboardID") as! WhyIsHearingViewController
    self.presentViewController(controller, animated: true, completion: nil);
  }
  
  @IBAction func onSymmetryButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "Symmetry", bundle: nil)
    var controller: WhyIsSymmetryViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsSymmetryStoryboardID") as! WhyIsSymmetryViewController
    self.presentViewController(controller, animated: true, completion: nil);
  }
  @IBAction func onPincerButtonTap(sender: AnyObject) {
    var storyboard = UIStoryboard (name: "Pincer", bundle: nil)
    var controller: WhyIsPincerViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPincerStoryboardID") as! WhyIsPincerViewController
    self.presentViewController(controller, animated: true, completion: nil);
  }
  
}
