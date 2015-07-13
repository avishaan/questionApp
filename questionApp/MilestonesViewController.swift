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
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var babyNameLabel: UILabel!
  
  var parent = Parent()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // setup image as a circle
    babyImageView.layer.cornerRadius = babyImageView.frame.size.width/2
    babyImageView.clipsToBounds = true
    babyImageView.layer.borderWidth = 4.0
    babyImageView.layer.borderColor = kBlue.CGColor
    
    babyImageView.image = parent.image
    
    // calculations for getting age in weeks
    
    if (parent.babyBirthday != nil){
      let secondsDifference = parent.babyBirthday?.timeIntervalSinceNow
      let weekDifference = abs(secondsDifference!/60/60/24/7)
      
      var weekFormatter = NSNumberFormatter()
      weekFormatter.maximumFractionDigits = 0
      let weeksFormattedString = weekFormatter.stringFromNumber(weekDifference)
      let ageAsString = weeksFormattedString! + " weeks"
      
      ageLabel.text = ageAsString
    
    }
    
    // update baby name
    babyNameLabel.text = parent.babyName
    
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
