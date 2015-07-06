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
  let store = NSUserDefaults.standardUserDefaults()
  
  init() {
    // first get info from the defaults incase they already exist
    self.fullName = store.objectForKey("fullName") as? String
    self.email = store.objectForKey("email") as? String
  }
  
  func storeInfo() {
    store.setObject(self.fullName, forKey: "fullName")
    store.setObject(self.email, forKey: "email")
  }
  
}
