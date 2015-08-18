//
//  ViewController.swift
//  TripStuff
//
//  Created by SHAWN on 7/30/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    struct constant {
        static let PreparationSegueID = "showPerparation"
        static let JournalSegueID = "showJournal"
        static let ButtonAnimationDuration: Double = 0.5
        static let ButtonAnimationDelay: Double = 0
        static let ButtonAnimationDamping: CGFloat = 0.5
        static let ButtonAnimationInitialSpeed: CGFloat = 1
        static let ButtonAnimationSizeZoomIn:CGFloat = 0.9
        static let ButtonAnimationSizeZoomOut:CGFloat = 1
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func knowledge(sender: UIButton) {
    }
    
    @IBAction func preparation(sender: UIButton) {
        buttonZoomAnimation(sender, segueID: constant.PreparationSegueID)
    }

    @IBAction func writejournal(sender: UIButton) {
        buttonZoomAnimation(sender, segueID: constant.JournalSegueID)
    }
    
    func buttonZoomAnimation(button: UIButton, segueID: String){
        button.transform = CGAffineTransformMakeScale(constant.ButtonAnimationSizeZoomIn, constant.ButtonAnimationSizeZoomIn)
        UIView.animateWithDuration(constant.ButtonAnimationDuration, delay: constant.ButtonAnimationDelay, usingSpringWithDamping: constant.ButtonAnimationDamping, initialSpringVelocity: constant.ButtonAnimationInitialSpeed, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            button.transform = CGAffineTransformMakeScale(constant.ButtonAnimationSizeZoomOut, constant.ButtonAnimationSizeZoomOut)
            }) { (Bool) -> Void in
                self.performSegueWithIdentifier(segueID, sender: self)
        }
    }
}

