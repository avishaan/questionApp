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
      self.font = UIFont(name: kOmnesFontMedium, size: 29)
      self.textAlignment = .Center
      //self.text = "Test"
      //self.font = omnesFontMed
      self.textColor = UIColor.whiteColor()
      // make the actual drawings
      super.drawRect(rect)
    }

}
