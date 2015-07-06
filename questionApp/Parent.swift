//
//  Parent.swift
//  questionApp
//
//  Created by Brown Magic on 7/5/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

class Parent {
  var fullName: String?
  var email: String?
  var babyName: String?
  var babyGender: String?
  var babyBirthday: NSDate?
  
  let kFullName = "FullName"
  let kEmail = "Email"
  let kBabyName = "BabyName"
  let kBabyGender = "BabyGender"
  let kBabyBirthday = "BabyBirthday"
  
  let store = NSUserDefaults.standardUserDefaults()
  
  init() {
    // first get info from the defaults incase they already exist
    self.fullName = store.objectForKey(kFullName) as? String
    self.email = store.objectForKey(kEmail) as? String
    self.babyName = store.objectForKey(kBabyName) as? String
    self.babyGender = store.objectForKey(kBabyGender) as? String
    self.babyBirthday = store.objectForKey(kBabyBirthday) as? NSDate
  }
  
  func storeInfo() {
    store.setObject(self.fullName, forKey: kFullName)
    store.setObject(self.email, forKey: kEmail)
    store.setObject(self.babyName, forKey: kBabyName)
    store.setObject(self.babyGender, forKey: kBabyGender)
    store.setObject(self.babyBirthday, forKey: kBabyBirthday)
  }
  
}
