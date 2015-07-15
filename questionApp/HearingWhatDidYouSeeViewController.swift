//
//  HearingWhatDidYouSeeViewController.swift
//  questionApp
//
//  Created by john bateman on 7/15/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class HearingWhatDidYouSeeViewController: UIViewController {

    @IBOutlet weak var goodOutcomeButton: BNButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: center align text not working with BNButton class. Tried to move to drawText in BNButton but it didn't work.
        goodOutcomeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
