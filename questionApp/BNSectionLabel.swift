//
//  BNSectionLabel.swift
//  questionApp
//
//  Created by Brown Magic on 6/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class BNSectionLabel: UILabel {

    override func drawRect(rect: CGRect) {
      // make sure it is wide enough to prevent it from being cut off
      self.layer.frame = CGRect(
        x: 53,
        y: 20,
        width: 215, // 215
        height: 38
      )
//      self.bounds = CGRect(
//        x: 0,
//        y: 0,
//        width: 215,
//        height: 38
//      )
//      self.frame = CGRect(
//        x: self.frame.origin.x,
//        y: self.frame.origin.y,
//        width: self.frame.size.width,
//        height: self.frame.size.height
//      )
//      self.center = CGPoint(x: 160.5, y: 39)
//      
//      self.layer.borderColor = UIColor.blackColor().CGColor
//      self.layer.borderWidth = 5.0
//      
//      //self.text = "Test"
//      //self.font = omnesFontMed
      self.font = UIFont(name: kOmnesFontMedium, size: 21) // needed to reduce from 26 to fit "attention at distance" & "language & cognitive & emotional attachment"
      self.textAlignment = .Center
      self.textColor = UIColor.whiteColor()
      // make the actual drawings
      super.drawRect(rect)
    }

}
