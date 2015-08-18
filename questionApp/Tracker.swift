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
    case Profile = "Profile"
  }
  
  enum Action:String {
    case Load = "Load"
    case Dismiss = "Dismiss"
    case Play = "Play Video"
    case Setup = "Setup"
  }
  
  /**
    creates an event in the underlying analytics framework
  
  */
  static func createEvent(name:Name, _ action:Action) {
    var event = (name: name.rawValue, action: action.rawValue)
    let sentence = "\(event.name) \(event.action)"
    
    mixpanel.track(sentence, properties: ["name": event.name, "action": event.action])
  }
}
