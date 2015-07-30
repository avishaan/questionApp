//
//  SocialSmilingIsBabyReadyViewController.swift
//  questionApp
//
//  Created by john bateman on 7/13/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SocialSmilingIsBabyReadyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onNextStepButtonTap(sender: AnyObject) {
        performSegueWithIdentifier("socialSmilingIsBabyReadyToTimeToTestSegueID", sender: self)
    }
    
    @IBAction func onDontShowAgainButtonTap(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "dontShowIsBabyReady")
        performSegueWithIdentifier("socialSmilingIsBabyReadyToTimeToTestSegueID", sender: self)
    }

}
