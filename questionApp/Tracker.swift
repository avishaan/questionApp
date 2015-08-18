//
//  Tracker.swift
//  questionApp
//
//  Created by Brown Magic on 8/17/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

struct Tracker {
  enum Name: String {
    case Intro = "Introduction"
  }
  
  enum Event:String {
    case Load = "Load"
    case Dismiss = "Dismiss"
    case Play = "Play Video"
  }
  
  static func createEvent(name:Name, _ event:Event) -> (name:String, event:String) {
    
    return (name.rawValue, event.rawValue)
    
  }
}
