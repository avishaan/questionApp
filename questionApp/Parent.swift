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
  let kFullName = "FullName"
  let kEmail = "Email"
  let kBabyName = "BabyName"
  let kBabyGender = "BabyGender"
  let kBabyBirthday = "BabyBirthday"
  let kImagePathRelative = "ImagePathRelative"
  
  let store = NSUserDefaults.standardUserDefaults()
  
  var fullName: String?
  var email: String?
  var babyName: String?
  var babyGender: String?
  var babyBirthday: NSDate?
  var imagePathRelative: String?
  var image: UIImage?
  
  var ageInWeeks: Double {
    get {
      let secondsDifference = self.babyBirthday?.timeIntervalSinceNow
      let weekDifference = abs(secondsDifference!/60/60/24/7)
      return weekDifference
    }
  }
  var ageInMonths: Double {
    get {
      return self.ageInWeeks/4
      }
  }
	
	/* TestProfiles: A collection of test histories for each baby profile, where a baby profile is identified by a name: String. */
	var testProfiles = TestProfiles()
  
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
		
		// Get test profiles from disk store.
		getProfiles()
  }
	
	/*
  @brief Convenience initializer. Use if initializing a Parent instance for a new child (so the test profile is created).
	@discussion Initializes the instance from the persistent store using Init(). Creates a test profile for the baby if it does not yet exist.
	@param (in) parentsFullName - name of the parent (Cannot be nil.)
	@param (in) email - parent's email address (Cannot be nil.)
	@param (in) childsName - name of the baby (Cannot be nil.)
	@param (in) babyBirthdate - birth date of the child (Cannot be nil.)
	*/
	convenience init(parentsFullName: String?, parentsEmail: String?, childsName: String?, babyBirthdate: NSDate?, childsGender: String?) {
		
		// initialize instance from persistent stores
		self.init()
	
		// save arguments
		fullName = parentsFullName
		email = parentsEmail
		babyName = childsName
		babyBirthday = babyBirthdate
		babyGender = childsGender
		
		// Create a new test profile for the current baby if one does not already exist.
		addProfile(babyName)
	}
	
  func storeInfo() {
    store.setObject(self.fullName, forKey: kFullName)
    store.setObject(self.email, forKey: kEmail)
    store.setObject(self.babyName, forKey: kBabyName)
    store.setObject(self.babyGender, forKey: kBabyGender)
    store.setObject(self.babyBirthday, forKey: kBabyBirthday)
		
		// Save the test profiles to disk store.
		saveProfiles()
  }
  
  func storeImage(image: UIImage) {
    let imageData = UIImageJPEGRepresentation(image, 1)
    let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate()).jpg"
    let path = self.documentsPathForFilename(relativePath)
    imageData?.writeToFile(path, atomically: true)
    
    self.imagePathRelative = relativePath
    store.setObject(self.imagePathRelative, forKey: kImagePathRelative)
    
  }
  
  func documentsPathForFilename(name: String) -> String {
		let documents = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
		let documentsURL = documents[0]
    let fullPath = documentsURL.URLByAppendingPathComponent(name)
    return fullPath.absoluteString
  }
	
	// MARK: Test Profiles helper functions
	
	/* 
	@brief Initialize this object's collection of profiles from the store on disk.
	*/
	func getProfiles() {
		testProfiles.initProfilesFromPersistentStore()
	}
	
	/*
	@brief Write all profiles from this object's collection to the store on disk.
	*/
	func saveProfiles() {
		testProfiles.save()
	}

	/*
	@brief Create a new profile for baby in memory if one does not already exist.
	@discussion Creates profile by concatenating the parent's full name with the specified babyName. 
	*/
	func addProfile(baby: String?) {
		if let parentName = self.fullName, let babyName = baby {
			let profileName = testProfiles.makeProfileName(parentName: parentName, babyName: babyName)
			testProfiles.addProfile(name: profileName)
		}
	}
	
	/*
	@brief Return the current profile name.
	@discussion The format of the profile name is "<parent_name>.<current_baby_name>".
	@return The profile name if self.fullName and self.babyName are not nil, else returns the empty string.
	TODO: When the Parent class is updated to support multiple baby profiles and the notion of the current baby profile, then the body of this function will need to be updated to return a profile name constructed with the current baby name.
	*/
	func getCurrentProfileName() -> String {
		if let parentName = self.fullName, let babyName = self.babyName {
			let profileName = testProfiles.makeProfileName(parentName: parentName, babyName: babyName)
			return profileName
		} else {
			return String("")
		}
	}
}
