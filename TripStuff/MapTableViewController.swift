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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return waypointsForTableView.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(Constant.cellID, forIndexPath: indexPath) as! MapTableViewCell
        let row = indexPath.row
        cell.title.text = waypointsForTableView[row].title
      //  cell.time.text = String.changeToString(timeChange(waypointsForTableView[row].dateAndTime))
        cell.longitude.text = String.changeToString(waypointsForTableView[row].longitude!)
        cell.lagitude.text = String.changeToString(waypointsForTableView[row].latitude!)
        cell.info.text = String.changeToString(waypointsForTableView[row].info)
        return cell
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

