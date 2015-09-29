//
//  BNUIViewController.swift
//  questionApp
//
//  Created by Brown Magic on 7/5/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class BNUIViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
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
  
  func dismissViewControllerFromBackButton(){
    // allows us to dismiss the view controller from backbutton
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}
