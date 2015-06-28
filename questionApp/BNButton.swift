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
    
    super.drawRect(rect)
    
  }
  
}
