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
      // analytics
      Tracker.createEvent(.LanguageCognitiveMilestone, .Load)

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
    
    @IBAction func attentionAtADistanceButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "AttentionAtDistance", bundle: nil)
        var controller: WhyIsAttentionAtDistanceViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsAttentionAtDistanceStoryboardID") as! WhyIsAttentionAtDistanceViewController
        self.presentViewController(controller, animated: true, completion: nil);

    }
    @IBAction func partiallyCoveredToyButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "PartiallyCoveredToy", bundle: nil)
        var controller: WhyIsPartiallyCoveredToyViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPartiallyCoveredToyStoryboardID") as! WhyIsPartiallyCoveredToyViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
    @IBAction func completelyCoveredToyButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "CompletelyCoveredToy", bundle: nil)
        var controller: WhyIsCompletelyCoveredToyViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsCompletelyCoveredToyStoryboardID") as! WhyIsCompletelyCoveredToyViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
    @IBAction func plasticJarButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "PlasticJar", bundle: nil)
        var controller: WhyIsPlasticJarViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsPlasticJarStoryboardID") as! WhyIsPlasticJarViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
    @IBAction func bookPresentationButtonTap(sender: AnyObject) {
        var storyboard = UIStoryboard (name: "BookPresentation", bundle: nil)
        var controller: WhyIsBookPresentationViewController = storyboard.instantiateViewControllerWithIdentifier("WhyIsBookPresentationStoryboardID") as! WhyIsBookPresentationViewController
        self.presentViewController(controller, animated: true, completion: nil);
    }
}
