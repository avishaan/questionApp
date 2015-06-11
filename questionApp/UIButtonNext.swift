//
//  UIButtonNext.swift
//  questionApp
//
//  Created by Brown Magic on 6/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class UIButtonNext: UIButton {

  let background = UIImage(named: "baseButton")
  
    override func drawRect(rect: CGRect) {
      //self.setTitle("save profile", forState: UIControlState.Normal)
      self.titleLabel!.font = omnesFontBold
      self.setTitleColor(orange, forState: UIControlState.Normal)
      // self.setImage(UIImage(named: "startButton"), forState: UIControlState.Normal)
      self.setBackgroundImage(background, forState: UIControlState.Normal)
      //self.frame = CGRect(x: 0, y: 0, width: background!.size.width, height: background!.size.height)
      //self.frame.size = CGSizeMake(311, 67)
      //self.frame = CGRect(x: 0, y: 0, width: 311, height: 67)
      //super.drawRect(rect)
    }

}
