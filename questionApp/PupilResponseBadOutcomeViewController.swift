//
//  PupilResponseBadOutcomeViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/29/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import Charts

class PupilResponseBadOutcomeViewController: UIViewController {
  @IBOutlet weak var rangeChartView: BNTestRangeChartView!
  
  var parent = Parent()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    rangeChartView.config(startMonth: 0, endMonth: 12, successAgeInMonths: 0.2, babyAgeInMonths: parent.ageInMonths, babyName: parent.babyName!)
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
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}
