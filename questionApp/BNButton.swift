//
//  BNButton.swift
//  questionApp
//
//  Created by Brown Magic on 6/27/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class BNButton: UIButton {
  
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    // Drawing code
    self.layer.cornerRadius = 7
    self.clipsToBounds = true
    self.titleLabel?.font = UIFont(name: kOmnesFontMedium, size: 20)
    self.backgroundColor = UIColor.whiteColor()
    self.setTitleColor(kGrey, forState: .Normal)
    
  }
  
  // following func used for locked tests that haven't been unlocked via facebook
  func facebookDisabled() {
    self.enabled = false
    self.setTitle("share to unlock test", forState: .Normal)
    self.alpha = 0.5
  }
  
  // Change button title to the test name
  func changeButtonTitle(testName:String) {
    self.alpha = 0.7
    self.setTitle(testName, forState: .Normal)
  }
}
