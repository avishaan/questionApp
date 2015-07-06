//
//  Parent.swift
//  questionApp
//
//  Created by Brown Magic on 7/5/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation
import UIKit

class Parent {
  var fullName: String?
  var email: String?
  var babyName: String?
  var babyGender: String?
  var babyBirthday: NSDate?
  var imagePathRelative: String?
  var image: UIImage?
  
  let kFullName = "FullName"
  let kEmail = "Email"
  let kBabyName = "BabyName"
  let kBabyGender = "BabyGender"
  let kBabyBirthday = "BabyBirthday"
  let kImagePathRelative = "ImagePathRelative"
  
  let store = NSUserDefaults.standardUserDefaults()
  
  init() {
    // first get info from the defaults incase they already exist
    self.fullName = store.objectForKey(kFullName) as? String
    self.email = store.objectForKey(kEmail) as? String
    self.babyName = store.objectForKey(kBabyName) as? String
    self.babyGender = store.objectForKey(kBabyGender) as? String
    self.babyBirthday = store.objectForKey(kBabyBirthday) as? NSDate
    
    // Get image
    self.imagePathRelative = store.objectForKey(kImagePathRelative) as? String
    
    if let oldImagePath = self.imagePathRelative {
      let oldFullPath = self.documentsPathForFilename(oldImagePath)
      let oldImageData = NSData(contentsOfFile: oldFullPath)
      // here is your saved image:
      self.image = UIImage(data: oldImageData!)
    }
    
  }
  
  func storeInfo() {
    store.setObject(self.fullName, forKey: kFullName)
    store.setObject(self.email, forKey: kEmail)
    store.setObject(self.babyName, forKey: kBabyName)
    store.setObject(self.babyGender, forKey: kBabyGender)
    store.setObject(self.babyBirthday, forKey: kBabyBirthday)
  }
  
  func storeImage(image: UIImage) {
    let imageData = UIImageJPEGRepresentation(image, 1)
    let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate()).jpg"
    let path = self.documentsPathForFilename(relativePath)
    imageData.writeToFile(path, atomically: true)
    
    self.imagePathRelative = relativePath
    store.setObject(self.imagePathRelative, forKey: kImagePathRelative)
    
  }
  
  func documentsPathForFilename(name: String) -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
    let path = paths[0] as! String;
    let fullPath = path.stringByAppendingPathComponent(name)
    
    return fullPath
  }
  
}
