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
  override func drawRect(rect: CGRect) {
    // Drawing code
    self.layer.cornerRadius = 7
    self.clipsToBounds = true
    self.titleLabel?.font = UIFont(name: kOmnesFontMedium, size: 20)
    self.backgroundColor = UIColor.whiteColor()
    self.setTitleColor(kGrey, forState: .Normal)
    
    // TODO: set icon alignment inline with label instead of a separate UIImage
    
    super.drawRect(rect)
    
  }
  
}
