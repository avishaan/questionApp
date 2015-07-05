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
    self.imageView?.contentMode = UIViewContentMode.Center
//    self.setBackgroundImage(UIImage(named: "backIcon"), forState: .Normal)
    self.setImage(UIImage(named: "backIcon"), forState: .Normal)
    self.tintColor = UIColor(red: 169, green: 235, blue: 255, alpha: 0.8)
    
    // add touch event for dismissing the VC
    self.addTarget(self, action: "onButtonTap:", forControlEvents: UIControlEvents.TouchUpInside)
    
  }
  
  func onButtonTap(sender: UIButton!){
    println("button tapped")
//    sender.superview?.backgroundColor = UIColor.blackColor()
  }
  

}
