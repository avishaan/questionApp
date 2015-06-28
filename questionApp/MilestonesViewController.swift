//
//  MilestonesViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/11/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class MilestonesViewController: UIViewController {
  
  @IBOutlet weak var babyImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // setup image as a circle
    babyImageView.layer.cornerRadius = babyImageView.frame.size.width/5
    babyImageView.clipsToBounds = true
    babyImageView.layer.borderWidth = 4.0
    babyImageView.layer.borderColor = kBlue.CGColor
    
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
