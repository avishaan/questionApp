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
  @IBOutlet weak var sensoryAndMotorPieChartView: BNMilestonePieChartView!
  @IBOutlet weak var languageAndCognitivePieChartView: BNMilestonePieChartView!
  @IBOutlet weak var socialAndEmotionalPieChartView: BNMilestonePieChartView!
  @IBOutlet weak var sensoryAndMotorLabel: UILabel!
  var parent = Parent()
  @IBOutlet weak var languageAndCognitiveLabel: UILabel!
  @IBOutlet weak var socialAndEmotionalLabel: UILabel!
  
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
    
    // update pie charts for each category
    sensoryAndMotorPieChartView.config(["test","test","test","",""], values: [0.2,0.2,0.2,0.2,0.2])
    languageAndCognitivePieChartView.config(["test","test",""], values: [0.33,0.33,0.33])
    socialAndEmotionalPieChartView.config(["test","test","test",""], values: [0.25,0.25,0.25,0.25])
    applyTextAttributesToLabels()
    
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
  
    // Helper function formats text attributes for substrings in labels.
    func applyTextAttributesToLabels() {
        
        let blueAtrributes = [NSForegroundColorAttributeName: kBlue, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 13)!]
        
        // label 1
        var attributedString1 = NSMutableAttributedString(string: sensoryAndMotorLabel.text!)
        attributedString1.addAttributes(blueAtrributes, range: NSMakeRange(0, 15))
        sensoryAndMotorLabel.attributedText = attributedString1
        
        // label 2
        var attributedString2 = NSMutableAttributedString(string: languageAndCognitiveLabel.text!)
        attributedString2.addAttributes(blueAtrributes, range: NSMakeRange(0, 21))
        languageAndCognitiveLabel.attributedText = attributedString2
        
        // label 3
        var attributedString3 = NSMutableAttributedString(string: socialAndEmotionalLabel.text!)
        attributedString3.addAttributes(blueAtrributes, range: NSMakeRange(0, 34))
        socialAndEmotionalLabel.attributedText = attributedString3
    }

  
}
