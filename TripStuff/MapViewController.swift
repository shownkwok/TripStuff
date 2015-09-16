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
        static let AnnotationReuseID = "waypoint"
        static let SegueIDtoWaypointTable = "showWaypointTable"
    }

    var waypoint = [Waypoint]()
    
    var waypointForEdit: Waypoint?
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateChanger = NSDateFormatter()
        dateChanger.dateFormat = "yyyy-MM-dd HH:mm"
        for initdataToBeAdded in initData{
            let waypointToBeAdded = Waypoint(latitude: Double.changeToDouble(initdataToBeAdded[3]), longitude: Double.changeToDouble(initdataToBeAdded[4]))
            waypointToBeAdded.dateAndTime = dateChanger.dateFromString(initdataToBeAdded[1])
            waypointToBeAdded.name = initdataToBeAdded[0]
            waypointToBeAdded.info = initdataToBeAdded[2]
            waypoint.append(waypointToBeAdded)
        }
        
        if waypoint.count > 0{
            mapView.addAnnotations(waypoint)
            mapView.showAnnotations(waypoint, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.showsUserLocation = true
            mapView.mapType = MKMapType.Satellite
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
        }
    }
    


//MARK: Setting Map
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure{
            mapView.deselectAnnotation(view.annotation, animated: false)
            if let annotationForEdit = view.annotation{
                for wp in waypoint{
                        if wp.longitude == annotationForEdit.coordinate.longitude && wp.longitude == view.annotation?.coordinate.longitude{
                        waypointForEdit = wp
                    }
                }
            }
            performSegueWithIdentifier(Constant.SegueIDtoTripSettingViewController, sender: self)
        }else if  (control as? UIButton)?.buttonType == UIButtonType.RoundedRect{
            for wp in waypoint{
                if wp.latitude == view.annotation?.coordinate.latitude && wp.longitude == view.annotation?.coordinate.longitude{
                    let indexInWaypoint = waypoint.indexOf(wp)
                    waypoint.removeAtIndex(indexInWaypoint!)
                }
            }
            mapView.removeAnnotation(view.annotation!)
        }
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(Constant.AnnotationReuseID)
        if view == nil{
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constant.AnnotationReuseID)
        }else{
            view?.annotation = annotation
        }
        view!.canShowCallout = true
        view?.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        let leftButton = UIButton(type: UIButtonType.RoundedRect)
        leftButton.setTitle("Delete", forState: UIControlState.Normal)
        leftButton.frame = CGRectMake(0, 0, 60, 40)
        view?.leftCalloutAccessoryView = leftButton
        view?.draggable = annotation is EditableWaypoint
        return view
    }
    
    
//MARK: Add annotation
    @IBAction func addAnnotation(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began{
            let newPoint = sender.locationInView(mapView)
            let newAnnotation = mapView.convertPoint(newPoint, toCoordinateFromView: mapView) as CLLocationCoordinate2D
            let newWaypoint = EditableWaypoint(latitude: newAnnotation.latitude, longitude: newAnnotation.longitude)
            newWaypoint.name = "title"
            let date = NSDate()
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
        }else if segue.identifier == Constant.SegueIDtoWaypointTable{
            if let viewController = segue.destinationViewController.contentViewController as? MapTableViewController{
                viewController.waypointsForTableView = waypoint
            }
        }
    }
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        
    }

}



