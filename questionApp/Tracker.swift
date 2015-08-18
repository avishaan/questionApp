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
  
  enum Action:String {
    case Load = "Load"
    case Dismiss = "Dismiss"
    case Play = "Play Video"
  }
  
  static func createEvent(name:Name, _ action:Action) -> [[String:String]] {
    
    return [["name": name.rawValue, "action": action.rawValue]]
    
  }
}
