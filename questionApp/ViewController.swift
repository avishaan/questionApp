//
//  ViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import Charts


class ViewController: BNUIViewController {

  @IBOutlet weak var subView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //check all fonts
    for family in UIFont.familyNames() {
      println(family)
      for name in UIFont.fontNamesForFamilyName(family as! String) {
        println(name)
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

}

