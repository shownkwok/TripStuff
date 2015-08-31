//
//  TripSettingViewController.swift
//  TripStuff
//
//  Created by SHAWN on 8/21/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class TripSettingViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var newWaypoint: Waypoint?
    
    struct Constant {
        static let showMapSegueID = "showMapAfterEdit"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        observation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let observer = forRemoveObserverNumberOne{
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }
        if let observer = forRemoveObserverNumberTwo{
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var tripTitle: UITextField!{
        didSet{
            tripTitle.delegate = self
            if let waypoint = newWaypoint
                {
                    tripTitle.text = waypoint.name
                }
        }
    }
    
    @IBOutlet weak var tripDetail: UITextView!{
        didSet{
            if let waypoint = newWaypoint{
                tripDetail.text = waypoint.info
            }
            tripDetail.delegate = self
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        tripTitle.resignFirstResponder()
        return true
    }

    
    @IBAction func resignFirstResponder(sender: UITapGestureRecognizer) {
        tripDetail.resignFirstResponder()
        tripTitle.resignFirstResponder()
    }
    
    
    @IBOutlet weak var datePicker: UIDatePicker!{
        didSet{
                datePicker.minuteInterval = 30
            let dateFormatter = NSDateFormatter()
            let maxDate = dateFormatter.dateFromString("2016-08-01 08:00") //temp
            let minDate = dateFormatter.dateFromString("2014-01-01 08:00") //temp
                datePicker.maximumDate = maxDate
                datePicker.minimumDate = minDate
            if let date = newWaypoint?.dateAndTime{
                    datePicker.setDate(date, animated: true)
            }
        }
    }
    
    
    @IBAction func dismissViewController(sender: UIBarButtonItem) {
        newWaypoint?.dateAndTime = datePicker.date
        newWaypoint?.info = tripDetail.text
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: addObserver
    var forRemoveObserverNumberOne: NSObjectProtocol?
    var forRemoveObserverNumberTwo: NSObjectProtocol?

    func  observation(){
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        forRemoveObserverNumberOne = center.addObserverForName(UITextFieldTextDidChangeNotification, object: tripTitle, queue: queue) { (NSNotification) -> Void in
            if let waypoint = self.newWaypoint{
                waypoint.name = self.tripTitle.text!
            }
        }
        
        forRemoveObserverNumberTwo = center.addObserverForName(UITextFieldTextDidChangeNotification, object: tripDetail, queue: queue) { (NSNotification) -> Void in
            if let waypoint = self.newWaypoint{
                waypoint.info = self.tripDetail.text
            }
        }
    }
}
