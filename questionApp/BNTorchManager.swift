//
//  BNTorchManager.swift
//  questionApp
//
//  Created by Michael Lo on 2015-09-28.
//  Copyright © 2015 codeHatcher. All rights reserved.
//

import Foundation
import AVFoundation

func tryToEnableFlashlight() {
  let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
  if (isFlashlightAvailable(device)) {
    do {
      try device.lockForConfiguration()
      // check if flashlight is on for toggle
      if (device.torchMode == AVCaptureTorchMode.On) {
        device.torchMode = AVCaptureTorchMode.Off
      } else {
        try device.setTorchModeOnWithLevel(1.0)
      }
      defer {
        device.unlockForConfiguration()
      }
    }
    catch {
      
    }
  }
}

func turnOffLightWithLock() {
  let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
  if let device = device {
    //check if light is even on first
    if isFlashlightAvailable(device) {
      if (device.torchMode == AVCaptureTorchMode.On) {
        // if on, turn off
        do {
          try device.lockForConfiguration()
          device.torchMode = AVCaptureTorchMode.Off
          device.unlockForConfiguration()
        }
        catch {}
      }
    }
  }
}

func isFlashlightAvailable(device: AVCaptureDevice) -> Bool {
  if (device.hasTorch) {
    return true
  } else {
    return false
  }
}
