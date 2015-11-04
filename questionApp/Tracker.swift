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
    case FacialMimic = "Facial Mimic"
    case SocialSmiling = "Social Smiling"
    case PointFollowing = "Point Following"
    case CompletelyCovered = "Completely Covered"
    case PartiallyCovered = "Partially Covered"
    case AttentionAtDistance = "Attention At Distance"
    case FallingToy = "Falling Toy"
    case SensoryMotorMilestone = "Sensory Motor Milestone"
    case SocialEmotionalMilestone = "Social Emotional Milestone"
    case LanguageCognitiveMilestone = "Language Cognitive Milestone"
    case FeedbackDialog = "Feedback Dialog"
    case RollingBackToFront = "RollingBackToFront"
    case EmotionalAttachment = "EmotionalAttachment"
    case EmotionalSecurity = "EmotionalSecurity"
    case ReceptiveLanguage = "ReceptiveLanguage"
    case VisualTracking = "VisualTracking"
    case ReachingForToy = "ReachingForToy"
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
    case Submit = "Submit"
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
	Different share methods to track
  
  */
	enum ShareMethod:String {
		case Unknown = "Unknown" // incase we don't know the share type
		case Facebook = "Facebook"
		case SMS = "SMS"
		case Email = "Email"
	}
	
  /**
    creates an event in the underlying analytics framework
  
  */
  static func createEvent(name:Name, _ action:Action, _ progress:Progress = .NA) {
    let event = (name: name.rawValue, action: action.rawValue, progress: progress.rawValue)
    let sentence = "\(event.name) \(event.action) in \(event.progress)"
    
    mixpanel.track(sentence, properties: ["name": event.name, "action": event.action, "progress": event.progress])
  }
	
	// allows us to track the number of times someone has shared as well as their share method
	static func incrementNumShares(shareMethod:ShareMethod = .Unknown) {
		mixpanel.people.increment("numShares", by: 1)
	}
	
	// save the feedback rating, text, and whether or not they finished the submission (vs just canceling)
	static func setFeedbackInfo(rating:Int, text:String, finishedSubmit:Bool) {
		mixpanel.people.set([
			"feedBackRating": rating,
			"feedBackText": text,
			"feedBackDidFinishSubmission": finishedSubmit
		])
    mixpanel.track("Feedback Dialog Data Entered", properties: ["feedBackRating": rating, "feedBackText": text, "feedBackDidFinishSubmission": finishedSubmit])
	}
  
  static func registerUser(parentName parentName:String, parentEmail:String, babyName:String, babyDOB: NSDate, babyGender: String) {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .ShortStyle
		
		// set distinct id before saving any people properties
		mixpanel.identify(mixpanel.distinctId)
    
    mixpanel.registerSuperProperties([
      "parentName": parentName,
      "parentEmail": parentEmail,
      "babyName": babyName,
      "babyDOB": dateFormatter.stringFromDate(babyDOB),
      "babyGender": babyGender
    ]);
		
		mixpanel.people.set([
      "parentName": parentName,
      "parentEmail": parentEmail,
      "babyName": babyName,
      "babyDOB": dateFormatter.stringFromDate(babyDOB),
      "babyGender": babyGender,
			"numShares": 0
		])
  }
}
