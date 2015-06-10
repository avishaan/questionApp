//
//  UIButtonNext.swift
//  questionApp
//
//  Created by Brown Magic on 6/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class UIButtonNext: UIButton {

    override func drawRect(rect: CGRect) {
      self.setTitle("save profile", forState: UIControlState.Normal)
      self.titleLabel!.font = omnesFontBold
      self.setTitleColor(orange, forState: UIControlState.Normal)
      // self.setImage(UIImage(named: "startButton"), forState: UIControlState.Normal)
      self.setBackgroundImage(UIImage(named: "baseButton"), forState: UIControlState.Normal)
    }

}
