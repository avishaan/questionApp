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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // set font on segmented controller
    var attr = NSDictionary(object: UIFont(name: "Omnes-Medium", size: 14)!, forKey: NSFontAttributeName)
    genderControl.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
    // give a little bit of tint
    genderControl.tintColor = orange
    // TODO: change color based on which gender is picked
    
    // hide keyboard when typing return
    Tracker.createEvent(.Profile, .Setup)
		
		// initialize text field delegates
		initTextFieldDelegates()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
	
	
	/* Helper function to configure text field delegates */
	func initTextFieldDelegates() {
		nameField.delegate = self
		emailField.delegate = self
		babyNameField.delegate = self
	}
	
	// MARK: Text View Delegate Methods

	func textFieldShouldReturn(textField: UITextField) -> Bool {
			// hide keyboard when Return is selected while editing a text field
			nameField.resignFirstResponder()
			emailField.resignFirstResponder()
			babyNameField.resignFirstResponder()
			
			return true;
	}
    
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    // use this to hide keyboard when tapping outside thetext field
    view.endEditing(true)
    super.touchesBegan(touches, withEvent: event)
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
  @IBAction func onSaveProfileButtonTap(sender: AnyObject) {
    // Init a Parent object with data entered by the user
    let person:Parent = Parent(parentsFullName: nameField.text, parentsEmail: emailField.text, childsName: babyNameField.text, babyBirthdate: babyBirthdayDate.date)
    
    // persist the Parent instance.
    person.storeInfo()
    
    // save user information to analytics platform
    Tracker.registerUser(parentName: nameField.text, parentEmail: emailField.text, babyName:babyNameField.text, babyDOB: babyBirthdayDate.date)
  }
  
  
}
