//
//  LetsCrawlTimeToTestViewController.swift
//  questionApp
//
//  Created by john bateman on 7/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVFoundation


class LetsCrawlTimeToTestViewController: UIViewController {

    @IBOutlet weak var step1Label: UILabel!
    
    @IBOutlet weak var step2Label: UILabel!
    @IBOutlet weak var step3Label: UILabel!
    @IBOutlet weak var step4Label: UILabel!

    @IBOutlet weak var labelBackground: UILabel!

    let orangeAtrributes = [NSForegroundColorAttributeName: kOrange, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        // does the iPhone have a flashlight?
        if (device != nil && device.hasTorch) {
            device.lockForConfiguration(nil)
            // check if flashlight is on for toggle
            if (device.torchMode == AVCaptureTorchMode.On) {
                device.torchMode = AVCaptureTorchMode.Off
            } else {
                device.setTorchModeOnWithLevel(1.0, error: nil)
            }
            device.unlockForConfiguration()
        }
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Helper function formats text attributes for multiple substrings in label.
    func applyTextAttributesToLabel() {
        
        // first character of each label should be orange
        var step1AttributedString = NSMutableAttributedString(string: step1Label.text!)
        step1AttributedString.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
        step1Label.attributedText = step1AttributedString
        
        var step2AttributedString = NSMutableAttributedString(string: step2Label.text!)
        step2AttributedString.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
        step2Label.attributedText = step2AttributedString
        
        var step3AttributedString = NSMutableAttributedString(string: step3Label.text!)
        step3AttributedString.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
        step3Label.attributedText = step3AttributedString
        
        //        var step4AttributedString = NSMutableAttributedString(string: step4Label.text!)
        //        step4AttributedString.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
        //        step4Label.attributedText = step4AttributedString
    }
}
