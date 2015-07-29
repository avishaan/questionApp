//
//  LetsCrawlBadOutcomeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/10/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class LetsCrawlBadOutcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "letsCrawlToActivityReminderSegue" {
            let controller = segue.destinationViewController as! ActivityReminderViewController
            controller.testName = TestNamesPresentable.letsCrawl
        }
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
