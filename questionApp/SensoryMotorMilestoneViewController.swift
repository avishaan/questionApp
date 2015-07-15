//
//  SensoryMotorMilestoneViewController.swift
//  questionApp
//
//  Created by Brown Magic on 6/27/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SensoryMotorMilestoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCrossingEyesButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "CrossingEyes", bundle: nil)
        var controller: WhyIsCrossingEyesViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCrossingEyesStoryboardID") as! WhyIsCrossingEyesViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
}
