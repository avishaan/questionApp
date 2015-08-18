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
    case Milestone = "Milestone"
    case PupilResponse = "Pupil Response"
    case SittingReaching = "Sitting and Reaching"
    case UnassistedSitting = "Unassisted Sitting"
    case PincerGrasp = "Pincer Grasp"
    case SelfRecognition = "Self Recognition"
    case Symmetry = "Symmetry"
    case Hearing = "Hearing"
    case CrossingEyes = "Crossing Eyes"
    case Crawl = "Let's Crawl"
  }
  
  /**
    action(verb) describing what sort of action is taking place for the event
  
  */
  enum Action:String {
    case Load = "Load"
    case Dismiss = "Dismiss"
    case Play = "Played Video"
    case Replay = "Replayed Video"
    case Setup = "Setup"
    case Tapped = "Tapped"
    case Changed = "Changed"
  }
  
  /**
    more detail describing the point of the test the user is in
  */
  enum Progress:String {
    case NA = "" // not applicable when not progressing in a test
    case Why = "why is?"
    case WhatIsNeeded = "what will you need?"
    case Bad = "bad outcome"
    case MoreInfo = "more information"
    case TimeToTest = "time to test"
    case Good = "good outcome"
    case WhatDidSee = "what did you see?"
    case IsReady = "is baby ready?"
    case Overview = "test overview"
    
  }
  
  /**
    creates an event in the underlying analytics framework
  
  */
  static func createEvent(name:Name, _ action:Action, _ progress:Progress = .NA) {
    var event = (name: name.rawValue, action: action.rawValue, progress: progress.rawValue)
    let sentence = "\(event.name) \(event.action) in \(event.progress)"
    
    mixpanel.track(sentence, properties: ["name": event.name, "action": event.action, "progress": event.progress])
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
