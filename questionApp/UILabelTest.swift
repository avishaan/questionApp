//
//  UILabelTest.swift
//  questionApp
//
//  Created by Brown Magic on 6/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class UILabelTest: UILabel {

    override func drawRect(rect: CGRect) {
        // Drawing code
      self.textColor = UIColor.whiteColor()
      self.text = "Test"
    }

}
