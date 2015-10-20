//
//  BNFacebookButton.swift
//  questionApp
//
//  Created by john bateman on 8/14/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation
import UIKit

class BNFacebookButton: BNButtonNext {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        super.drawRect(rect)
        self.setTitleColor(UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0), forState: .Normal)
    }
}