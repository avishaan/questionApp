//
//  LanguageCognitiveMilestoneViewController.swift
//  questionApp
//
//  Created by john bateman on 7/7/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class LanguageCognitiveMilestoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "milestonesSegueID" {
            // Dismiss this view controller before modally presenting the milestones VC.
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func onMilestonesBarButtonItem(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
