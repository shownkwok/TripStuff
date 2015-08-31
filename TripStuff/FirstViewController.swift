//
//  ViewController.swift
//  TripStuff
//
//  Created by SHAWN on 7/30/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    struct Constant {
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
    }
    
    @IBAction func knowledge(sender: UIButton) {
    }
    
    @IBAction func preparation(sender: UIButton) {
        buttonZoomAnimation(sender, segueID: Constant.PreparationSegueID)
    }

    @IBAction func writejournal(sender: UIButton) {
        buttonZoomAnimation(sender, segueID: Constant.JournalSegueID)
    }
    
    func buttonZoomAnimation(button: UIButton, segueID: String){
        button.transform = CGAffineTransformMakeScale(Constant.ButtonAnimationSizeZoomIn, Constant.ButtonAnimationSizeZoomIn)
        UIView.animateWithDuration(Constant.ButtonAnimationDuration, delay: Constant.ButtonAnimationDelay, usingSpringWithDamping: Constant.ButtonAnimationDamping, initialSpringVelocity: Constant.ButtonAnimationInitialSpeed, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            button.transform = CGAffineTransformMakeScale(Constant.ButtonAnimationSizeZoomOut, Constant.ButtonAnimationSizeZoomOut)
            }) { (Bool) -> Void in
                self.performSegueWithIdentifier(segueID, sender: self)
        }
    }
}

