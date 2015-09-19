//
//  BNTextView.swift
//  questionApp
//
//  Created by Brown Magic on 9/18/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class BNTextView: UITextView {
  override func drawRect(rect: CGRect) {
    self.layer.cornerRadius = 5.0
//    self.borderStyle = UITextBorderStyle.RoundedRect
    self.layer.borderColor = UIColor.grayColor().CGColor
    self.layer.borderWidth = 2.0
    self.font = omnesFontMed
  }

}
