//
//  Tracker.swift
//  questionApp
//
//  Created by Brown Magic on 8/17/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

struct Tracker {
  
  /**
    name(object) subject the action is taking place on
  */
  enum Name: String {
    case Intro = "Introduction"
    case Profile = "Profile"
    case ProfileSaved = "Saved Profile"
    case ProfileImage = "Profile Image"
  }
  
  /**
    action(verb) describing what sort of action is taking place for the event
  
  */
  enum Action:String {
    case Load = "Load"
    case Dismiss = "Dismiss"
    case Play = "Play Video"
    case Setup = "Setup"
    case Tapped = "Tapped"
    case Changed = "Changed"
  }
  
  /**
    creates an event in the underlying analytics framework
  
  */
  static func createEvent(name:Name, _ action:Action) {
    var event = (name: name.rawValue, action: action.rawValue)
    let sentence = "\(event.name) \(event.action)"
    
    mixpanel.track(sentence, properties: ["name": event.name, "action": event.action])
  }
  
  static func registerUser(#parentName:String, parentEmail:String, babyName:String, babyDOB: NSDate) {
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .ShortStyle
    
    mixpanel.registerSuperProperties([
      "parentName": parentName,
      "parentEmail": parentEmail,
      "babyName": babyName,
      "babyDOB": dateFormatter.stringFromDate(babyDOB)
      ]);
  }
}
