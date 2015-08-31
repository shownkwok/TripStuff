//: Playground - noun: a place where people can play

import UIKit
var time = NSDate()
var timer = NSDateFormatter()
timer.dateFormat = "yy-MM-dd HH:mm"
var s = timer.stringFromDate(time)
print(s)
var c = "2015-08-22 08:00"
var d = timer.dateFromString(c)
print(d)

