//
//  CrossingEyesMoreInfoViewController.swift
//  questionApp
//
//  Created by john bateman on 7/14/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class CrossingEyesMoreInfoViewController: UIViewController {

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
    
    @IBAction func onHomeButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller: MilestonesViewController = storyboard.instantiateViewControllerWithIdentifier("MilestonesVCStoryboardID") as! MilestonesViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
    
    @IBAction func onLinkButtonTap(sender: AnyObject) {
        if let requestUrl = NSURL(string: "http://www.infantsee.org") {
            UIApplication.sharedApplication().openURL(requestUrl)
        }
    }
}
