//
//  BNAuxiliaryButtonNext.swift
//  questionApp
//
//  Created by john bateman on 7/8/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//
//  Use for the class of any secondary action button in a view controller with a primary BNButtonNext.

import UIKit

class BNAuxiliaryButtonNext: BNButtonNext {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        super.drawRect(rect)
        self.setTitleColor(kBlue, forState: .Normal)
    }
}
