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

    var waypoint: Waypoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.delegate = self
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        <#code#>
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    }
    @IBAction func addAnnotation(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began{
            let newPoint = sender.locationInView(mapView)
            let newAnnotation = mapView.convertPoint(newPoint, toCoordinateFromView: mapView) as CLLocationCoordinate2D
            waypoint = Waypoint(latitude: newAnnotation.latitude, longitude: newAnnotation.longitude)
            waypoint?.name = "test"
            waypoint?.info = "title"
            mapView.addAnnotation(waypoint!)
            mapView.showAnnotations([waypoint!], animated: true)
        }
    }
    
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
