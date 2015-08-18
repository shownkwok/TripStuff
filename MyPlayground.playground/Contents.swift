//: Playground - noun: a place where people can play

import UIKit
var d: NSMutableDictionary = ["a":["b":1]]
//let dataForShow = d as NSMutableDictionary
let dataForShow = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(d))
var x : NSMutableDictionary{
return dataForShow as! NSMutableDictionary
}
print(x)
