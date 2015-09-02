//
//  MapTableViewController.swift
//  TripStuff
//
//  Created by SHAWN on 8/25/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class MapTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var waypointsForTableView = [Waypoint]()
    struct Constant {
        static let cellID = "waypoint"
        static let segueIDToEditViewController = "showEditFromTable"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        waypointsForTableView = sortByDateAndTime(waypointsForTableView)
        tableView.reloadData()
    }
    

//MARK: Setting table
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return waypointsForTableView.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(Constant.cellID, forIndexPath: indexPath) as! MapTableViewCell
        let row = indexPath.row
        cell.title.text = waypointsForTableView[row].title
        cell.time.text = String.changeToString(timeChange(waypointsForTableView[row].dateAndTime))
        cell.longitude.text = String.changeToString(waypointsForTableView[row].longitude!)
        cell.lagitude.text = String.changeToString(waypointsForTableView[row].latitude!)
        cell.info.text = String.changeToString(waypointsForTableView[row].info)
        return cell
    }
    
    var selectedWaypoint: Waypoint!
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedWaypoint = waypointsForTableView[indexPath.row]

        if selectedWaypoint != nil{
            performSegueWithIdentifier(Constant.segueIDToEditViewController, sender: self)
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constant.segueIDToEditViewController{
            if let viewController = segue.destinationViewController.contentViewController as? TripSettingViewController{
                viewController.newWaypoint = selectedWaypoint
            }
        }
    }
}

