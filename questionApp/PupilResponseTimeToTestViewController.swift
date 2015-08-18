//
//  PupilResponseTimeToTestViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/29/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import AVFoundation

class PupilResponseTimeToTestViewController: UIViewController {
  
  @IBOutlet weak var step1Label: UILabel!
  @IBOutlet weak var step2Label: UILabel!
  @IBOutlet weak var step3Label: UILabel!
  @IBOutlet weak var step4Label: UILabel!
  
  @IBOutlet weak var labelBackground: UILabel!
  
  
  let orangeAtrributes = [NSForegroundColorAttributeName: kOrange, NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 22)!]
  
  let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
  
  override func viewDidLoad() {
    super.viewDidLoad()
	Tracker.createEvent(.PupilResponse, .Load, .TimeToTest)
    
    // Do any additional setup after loading the view.
    labelBackground.layer.cornerRadius = 7
    labelBackground.layer.masksToBounds = true
    
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
    
    var step4AttributedString = NSMutableAttributedString(string: step4Label.text!)
    step4AttributedString.addAttributes(orangeAtrributes, range: NSMakeRange(0, 2))
    step4Label.attributedText = step4AttributedString
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onBackButtonTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  @IBAction func onFlashlightButtonTap(sender: BNButtonNext) {
    // does the iPhone have a flashlight?
    if (isFlashlightAvailable()) {
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
    
  @IBAction func onNextButtonTap(sender: BNButtonNext) {
    turnOffLightWithLock()
  }
  
  func turnOffLightWithLock() {
    // does the iPhone have a flashlight?
    if (isFlashlightAvailable()) {
    //check if light is even on first
      if (device.torchMode == AVCaptureTorchMode.On) {
        // if on, turn off
        device.lockForConfiguration(nil)
        device.torchMode = AVCaptureTorchMode.Off
        device.unlockForConfiguration()
      }
    }
  }
  
  func isFlashlightAvailable() -> Bool {
    if (device != nil && device.hasTorch) {
      return true
    } else {
      return false
    }
  }
  
}
