//
//  JournalTableViewController.swift
//  TripStuff
//
//  Created by SHAWN on 8/5/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

private var journalForShow = [JournalClass]()

class JournalTableViewController: UITableViewController {
    struct Constant {
        static let CellID = "journalTable"
        static let EditID = "showEditor"
    }

    var journalForDetail: JournalClass?
    var journalChanged: JournalClass?{
        didSet{
            var isChange = true
            var number = 0
            if journalForShow.count != 0{
                for data in journalForShow{
                    number++
                    if journalChanged?.journalTitle == data.journalTitle{
                        isChange = false
                        journalForShow[number - 1] = journalChanged!
                    }
                }
            }
            if isChange == true{
                journalForShow.append(journalChanged!)
            }
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func editor(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showEditor", sender: self)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalForShow.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constant.CellID, forIndexPath: indexPath) as! JournalDetailTableViewCell
            cell.title.text = journalForShow[indexPath.row].journalTitle
        cell.brifeDetail.text = journalForShow[indexPath.row].journalDetail
        return cell
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(Constant.EditID, sender: self)
        journalForDetail = journalForShow[indexPath.row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! JournalEditorViewController
        if segue.identifier == Constant.EditID{
            viewController.journal = journalForDetail
        }
    }
}
