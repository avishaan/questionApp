//
//  PartiallyCoveredToyIsBabyReadyViewController.swift
//  questionApp
//
//  Created by Daniel Hsu on 7/30/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class PartiallyCoveredToyIsBabyReadyViewController: UIViewController {

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
        performSegueWithIdentifier("partiallyCoveredToyIsBabyReadyToTimeToTestSegueID", sender: self)
    }
    
    @IBAction func onDontShowAgainButtonTap(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "dontShowIsBabyReady")
        performSegueWithIdentifier("partiallyCoveredToyIsBabyReadyToTimeToTestSegueID", sender: self)
    }

}
