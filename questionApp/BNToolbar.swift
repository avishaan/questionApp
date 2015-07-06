//
//  BNToolbar.swift
//  questionApp
//
//  Created by Brown Magic on 6/26/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class BNToolbar: UIToolbar {
  
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect) {
    // Drawing code
    self.setBackgroundImage(UIImage(), forToolbarPosition: .Any, barMetrics: .Default)
    self.setShadowImage(UIImage(), forToolbarPosition: .Any)
    self.tintColor = UIColor.whiteColor()
//    self.tintColor = kBlue
    // self.barTintColor = kOrange
    super.drawRect(rect)
    
  }
//  
//  required init(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//  }
//  
}
