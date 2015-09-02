//: Playground - noun: a place where people can play

import UIKit
class Waypoint {
    var dateAndTime = NSDate()
}


var s1 = Waypoint()
s1.dateAndTime = NSDate()
var s2 = Waypoint()
s1.dateAndTime = NSDate.distantFuture()
var s3 = Waypoint()
s1.dateAndTime = NSDate.distantPast()
let waypoint = [s2,s1,s3]


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
        print(waypoints[0].dateAndTime)
    }
    return waypoints
}
sortByDateAndTime(waypoint)
print(waypoint)
