//
//  ProfileSetupViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class ProfileSetupViewController: UIViewController {
  
  @IBOutlet weak var genderControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // set font on segmented controller
    var attr = NSDictionary(object: UIFont(name: "Omnes-Medium", size: 14)!, forKey: NSFontAttributeName)
    genderControl.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
    // give a little bit of tint
    genderControl.tintColor = orange
    // TODO: change color based on which gender is picked
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
