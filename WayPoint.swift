//
//  WayPoint.swift
//  TripStuff
//
//  Created by SHAWN on 8/17/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit
import MapKit
class Waypoint: NSObject{
    var latitude: Double?
    var longitude: Double?
    var name: String?
    var info: String?
    var dateAndTime: NSDate?
    init(latitude: Double, longitude: Double){
        self.longitude = longitude
        self.latitude = latitude
    }
}

extension Waypoint: MKAnnotation {
    var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    }
    var title: String! { return name }
    var subtitle: String? { return "\(dateAndTime)" }
}

class EditableWaypoint: Waypoint {
    override var coordinate: CLLocationCoordinate2D{
        get {return super.coordinate }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
            print("newLatidude is \(newValue.latitude)")
        }
    }
}