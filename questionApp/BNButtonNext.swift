//
//  BNButtonNext.swift
//  questionApp
//
//  Created by Brown Magic on 6/28/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class BNButtonNext: BNButton {
	
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect) {
    // Drawing code
    super.drawRect(rect)
    self.setTitleColor(kOrange, forState: .Normal)
    self.titleLabel?.font = UIFont(name: kOmnesFontSemiBold, size: 20)
  }
	
//	override func layoutSubviews() {
//		super.layoutSubviews()
//		print("layout view")
//		if (UIScreen.mainScreen().bounds.size.height == 480.0){
//			self.frame.origin.y = 480-30;
//		}
//	}
//	
//	func addProperties() {
//		
//	}
	
}
