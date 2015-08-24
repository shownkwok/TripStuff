//
//  MapViewController.swift
//  TripStuff
//
//  Created by SHAWN on 8/9/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    
    struct Constant {
       static let SegueIDtoTripSettingViewController = "showTripSetting"
    }

    var waypoint = [Waypoint]()
    var waypointForEdit: Waypoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if waypoint.count > 0{
            mapView.addAnnotations(waypoint)
        }
        var t = CLLocationManager()
        t = CLLocationManager.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.showsUserLocation = true
            mapView.delegate = self
        }
    }
    
    

//MARK: setting Map
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure{
            mapView.deselectAnnotation(view.annotation, animated: false)
            if let annotationForEdit = view.annotation{
                for wp in waypoint{
                        if wp.longitude == annotationForEdit.coordinate.longitude{
                        waypointForEdit = wp
                    }
                }
            }
            performSegueWithIdentifier(Constant.SegueIDtoTripSettingViewController, sender: self)
        }
    }
    

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView()

        view.canShowCallout = true
        view.annotation = annotation
        view.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        view.draggable = annotation is EditableWaypoint
        view.pinColor = MKPinAnnotationColor.Red
        return view
    }
    
    @IBAction func addAnnotation(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began{
            let newPoint = sender.locationInView(mapView)
            let newAnnotation = mapView.convertPoint(newPoint, toCoordinateFromView: mapView) as CLLocationCoordinate2D
            let newWaypoint = EditableWaypoint(latitude: newAnnotation.latitude, longitude: newAnnotation.longitude)
            newWaypoint.name = "title"
            let date = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            newWaypoint.dateAndTime = date
            waypoint.append(newWaypoint)
            mapView.addAnnotation(newWaypoint)
            mapView.showAnnotations([newWaypoint], animated: true)
        }
    }
    
// MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constant.SegueIDtoTripSettingViewController{
            if let viewController = segue.destinationViewController.contentViewController as? TripSettingViewController{
                if waypoint.count > 0{
                    viewController.newWaypoint = waypointForEdit
                }
            }
        }
    }
}
extension UIViewController{
    var contentViewController: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController!
        }else{
            return self
        }
    }
}

