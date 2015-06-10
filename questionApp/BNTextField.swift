//
//  BNTextField.swift
//  questionApp
//
//  Created by Brown Magic on 6/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class BNTextField: UITextField {

    override func drawRect(rect: CGRect) {
      self.layer.cornerRadius = 5.0
      self.placeholder = "Your Name"
      self.borderStyle = UITextBorderStyle.RoundedRect
      self.layer.borderColor = UIColor.grayColor().CGColor
      self.layer.borderWidth = 2.0
    }

}
