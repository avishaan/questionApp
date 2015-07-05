//
//  BNBackButton.swift
//  questionApp
//
//  Created by Brown Magic on 7/5/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class BNBackButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.setTitle("", forState: .Normal)
    self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    self.setImage(UIImage(named: "backIcon"), forState: .Normal)
    self.tintColor = UIColor(red: <#CGFloat#>, green: <#CGFloat#>, blue: <#CGFloat#>, alpha: <#CGFloat#>)
  }

}
