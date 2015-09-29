//
//  SavedProfileViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import MobileCoreServices

class SavedProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var babyNameLabel: UILabel!
  @IBOutlet weak var babyDOBLabel: UILabel!
  @IBOutlet weak var babyImageView: UIImageView!
  
  var parent = Parent()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // setup date format
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    
    // Do any additional setup after loading the view.
    setLabel(nameLabel, keyText: "Name: ", valueText: parent.fullName!)
    setLabel(emailLabel, keyText: "Email: ", valueText: parent.email!)
    setLabel(babyNameLabel, keyText: "Baby's name: ", valueText: parent.babyName!)
    setLabel(babyDOBLabel, keyText: "Baby's birthdate: ", valueText: dateFormatter.stringFromDate(parent.babyBirthday!))
    
    
    // connect image to listen for a tap
    var imageListener = UITapGestureRecognizer(target: self, action: "onImageTap")
    // define taps for the listener
    imageListener.numberOfTapsRequired = 1
    imageListener.numberOfTouchesRequired = 1
    // attach listener to image
    babyImageView.addGestureRecognizer(imageListener)
    // user interaction must be enabled in order to listen for events
    babyImageView.userInteractionEnabled = true
    
    // setup image as a circle
    babyImageView.layer.cornerRadius = babyImageView.frame.size.width/2
    babyImageView.clipsToBounds = true
    babyImageView.layer.borderWidth = 7.0
    babyImageView.layer.borderColor = kBlue.CGColor
    
    // replace image in baby view from NSUserDefaults
    babyImageView.image = parent.image
    
    // analytics
    Tracker.createEvent(.ProfileSaved, .Load)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setLabel(label:UILabel, keyText:String, valueText:String){
    // label is the uiLabel, keyText is first part of text, valueText is second part
    let attrKey = [
      NSFontAttributeName: UIFont(name: kOmnesFontSemiBold, size: 19)!,
      NSForegroundColorAttributeName: kGrey
    ]
    let attrValue = [
      NSFontAttributeName: UIFont(name: kOmnesFontMedium, size: 19)!, NSForegroundColorAttributeName: kBlue]
    // full label text
    let fullText = keyText + valueText
    let fullTextMutableString = NSMutableAttributedString(string: fullText, attributes: attrKey)
    
    // don't use range of string incase someone repeats a string
    fullTextMutableString.addAttributes(attrValue, range: NSMakeRange(keyText.characters.count, valueText.characters.count))
    //Apply to the label
    label.attributedText = fullTextMutableString
  }
  
  // MARK: - Listen to taps on baby's face then open photo library
  func onImageTap(){
    // when image is tapped, go ahead and open up the photo library view
    if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
      let imagePicker = UIImagePickerController()
      
      imagePicker.delegate = self
      imagePicker.sourceType = .PhotoLibrary
      imagePicker.mediaTypes = [kUTTypeImage as String!]
      imagePicker.allowsEditing = false
      
      Tracker.createEvent(.ProfileImage, .Tapped)
      
      self.presentViewController(imagePicker, animated: true, completion: { () -> Void in
        return
      })
    }
  }
  
  // MARK: - UIImagePickerControllerDelegate Functions
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    // work with the media here
    // check the media type is an image
    let mediaType = info[UIImagePickerControllerMediaType] as! String
    if mediaType == kUTTypeImage as String! {
      // media is an image
      // get the unedited version, different for edited version
      let origImage = info[UIImagePickerControllerOriginalImage] as! UIImage
      // not sure if the edited image exists when no edit occured
//      let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
      
      // replace our image in the imageView
      babyImageView.image = origImage
      // save the image
      parent.storeImage(origImage)
      
      Tracker.createEvent(.ProfileImage, .Changed)
      
    }
    self.dismissViewControllerAnimated(true, completion: nil)
    
    
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
