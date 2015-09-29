//
//  FacialMimicTimeToTestViewController.swift
//  questionApp
//
//  Created by john bateman on 7/29/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVFoundation

class FacialMimicTimeToTestViewController: UIViewController {

    @IBOutlet weak var step1Label: UILabel!
    @IBOutlet weak var step2Label: UILabel!
    @IBOutlet weak var step3Label: UILabel!
    @IBOutlet weak var labelBackground: UILabel!
    
    let orangeAtrributes = [NSForegroundColorAttributeName: kOrange, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
    
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // analytics
      Tracker.createEvent(.FacialMimic, .Load, .TimeToTest)
        
        // setup rounded corners on label
        labelBackground.layer.cornerRadius = 7
        labelBackground.layer.masksToBounds = true
        
        applyTextAttributesToLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFlashlightButtonTap(sender: BNButtonNext) {
      tryToEnableFlashlight()
    }
  
    @IBAction func onNextButtonTap(sender: BNButtonNext) {
        turnOffLightWithLock()
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        turnOffLightWithLock()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Helper function formats text attributes for multiple substrings in label.
    func applyTextAttributesToLabel() {
        
        // first character of each label should be orange
        let step1AttributedString = NSMutableAttributedString(string: step1Label.text!)
        step1AttributedString.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
        step1Label.attributedText = step1AttributedString
        
        let step2AttributedString = NSMutableAttributedString(string: step2Label.text!)
        step2AttributedString.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
        step2Label.attributedText = step2AttributedString
        
        let step3AttributedString = NSMutableAttributedString(string: step3Label.text!)
        step3AttributedString.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
        step3Label.attributedText = step3AttributedString
    }
}
