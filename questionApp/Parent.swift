//
//  Parent.swift
//  questionApp
//
//  Created by Brown Magic on 7/5/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

class Parent {
  var firstName: String?
  var lastName: String?
  let store = NSUserDefaults.standardUserDefaults()
  
  init() {
    // first get info from the defaults incase they already exist
    self.firstName = store.objectForKey("firstName") as? String
    self.lastName = store.objectForKey("lastName") as? String
  }
  
  func saveInfo() {
    store.setObject(self.firstName, forKey: "firstName")
    store.setObject(self.lastName, forKey: "lastName")
  }
  
}
