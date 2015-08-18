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
    var subtitle: String? { return info }
}