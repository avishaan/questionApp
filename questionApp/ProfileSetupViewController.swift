//
//  ProfileSetupViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class ProfileSetupViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var genderControl: UISegmentedControl!
  @IBOutlet weak var nameField: BNTextField!
  @IBOutlet weak var emailField: BNTextField!
  @IBOutlet weak var babyNameField: BNTextField!
  @IBOutlet weak var babyBirthdayDate: UIDatePicker!
  
  var parent = Parent()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // set font on segmented controller
    let attr = NSDictionary(object: UIFont(name: "Omnes-Medium", size: 14)!, forKey: NSFontAttributeName)
    genderControl.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
    // give a little bit of tint
    genderControl.tintColor = orange
    // TODO: change color based on which gender is picked
    
    // hide keyboard when typing return
    Tracker.createEvent(.Profile, .Setup)
		
		// initialize text field delegates
		initTextFieldDelegates()
    
    nameField.text = parent.fullName
    emailField.text = parent.email
    babyNameField.text = parent.babyName
    genderControl.selectedSegmentIndex = indexForGender(parent.babyGender!)
    if let date = parent.babyBirthday {
      babyBirthdayDate.date = date
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func indexForGender(gender: String) -> Int {
    var index = 0
    switch (gender) {
    case "Girl":
      index = 1
    case "Boy":
      fallthrough
    default:
      index = 0
    }
    return index
  }
	
	// MARK: IBActions
	
  @IBAction func onSaveProfileButtonTap(sender: AnyObject) {
    // Init a Parent object with data entered by the user
    var childGender: String
    switch genderControl.selectedSegmentIndex {
    case 0:
      childGender = "Boy"
    case 1:
      childGender = "Girl"
    default:
      childGender = ""
    }
    
    let person:Parent = Parent(parentsFullName: nameField.text, parentsEmail: emailField.text, childsName: babyNameField.text, babyBirthdate: babyBirthdayDate.date, childsGender: childGender)
    
    // persist the Parent instance.
    person.storeInfo()
    
    // save user information to analytics platform
    Tracker.registerUser(parentName: nameField.text!, parentEmail: emailField.text!, babyName:babyNameField.text!, babyDOB: babyBirthdayDate.date, babyGender: childGender)
  }
	
	@IBAction func onDatePickerTap(sender: AnyObject) {
		hideKeyboard()
	}
	
    @IBAction func onGenderTap(sender: AnyObject) {
		hideKeyboard()
	}
	
	
	// MARK: Text View Delegate Methods
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		// hide keyboard when Return is selected while editing a text field
		hideKeyboard()
		return true;
	}
	
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		// use this to hide keyboard when tapping outside thetext field
		view.endEditing(true)
		super.touchesBegan(touches, withEvent: event)
	}

	
	// MARK: helper functions
	
	/* Configure text field delegates */
	func initTextFieldDelegates() {
		nameField.delegate = self
		emailField.delegate = self
		babyNameField.delegate = self
	}
	
	/* Ends editting by resigning first responder for all text fields */
	func hideKeyboard() {
		nameField.resignFirstResponder()
		emailField.resignFirstResponder()
		babyNameField.resignFirstResponder()
	}
	
}
