//
//  JointAttentionActivityReminderViewController.swift
//  questionApp
//
//  Created by Michael Leung on 8/17/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class JointAttentionActivityReminderViewController: ActivityReminderViewController {
    
    @IBAction func onHomeButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
}