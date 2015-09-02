//
//  OverAllFuncs.swift
//  TripStuff
//
//  Created by SHAWN on 8/26/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

var data: NSMutableDictionary?
var user: String?{
didSet{
    data = NSMutableDictionary(contentsOfFile: "\(path)\(user!).plist")
}
}

//if change the mac, "guojian" needs to be changed into new macs name
let path = "/Users//Users/guojian/Desktop/Desktop/TripStuff/"
let userPath = "/Users//Users/guojian/Desktop/Desktop/TripStuff/user/user.plist"

//TODO: temp data , will be deleted
let initData = [["init1","2015-08-21 08:00","this info","20","30","this is image url"],["init2","2015-08-22 08:00","this info2","20.0001","30","this is image url num 2"]]


extension UIViewController{
    var contentViewController: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController!
        }else{
            return self
        }
    }
}

extension String{
    static func changeToString<T> (a: T) -> String {
        return "\(a)"
    }
}
extension Double{
    static func changeToDouble (a: String) -> Double {
        let manager = NSNumberFormatter()
        let newNum = manager.numberFromString(a)
        return Double(newNum!)
    }
}

//MARK: New Functions
func timeChange(time: NSDate) -> String{
    let timer = NSDateFormatter()
    timer.dateFormat = "yyyy-MM-dd HH:mm"
    return timer.stringFromDate(time)
}

func sortByDateAndTime(var waypoints:[Waypoint])->[Waypoint]{
    if waypoints.count > 1{
        for var i = 0; i<waypoints.count; ++i{
            for var j = i; j<waypoints.count; ++j{
                let earlyOne = waypoints[i].dateAndTime.earlierDate(waypoints[j].dateAndTime)
                if waypoints[i].dateAndTime != earlyOne{
                    let temp = waypoints[j]
                    waypoints[j] = waypoints[i]
                    waypoints[i] = temp
                }
            }
        }
    }
    return waypoints
}

