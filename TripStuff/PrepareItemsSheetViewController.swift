//
//  PrepareItemsSheetViewController.swift
//  TripStuff
//
//  Created by SHAWN on 7/30/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class PrepareItemsSheetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    struct constant {
        static let ItemID = "Item"
        static let HeightForHeaderInSection:CGFloat = 30
        static let TableViewAnimationDuration: Double = 2
        static let TableViewAnimationDelay: Double = 0
        static let TableViewAnimationDamping: CGFloat = 0.5
        static let TableViewAnimationInitialSpeed: CGFloat = 5

        
    }
    var buttonForChange = false
    var name = [[String]]()
    var number = [[String]]()
    var sectionName = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataForShow()
    }

    @IBOutlet weak var itemTableView: UITableView!
    
    @IBOutlet weak var instructionImage: UIImageView!
    @IBAction func updateTableView(sender: UIBarButtonItem) {
        buttonForChange = !buttonForChange
        if buttonForChange == true{
            sender.title = "List"
            UIView.animateWithDuration(constant.TableViewAnimationDuration, delay: constant.TableViewAnimationDelay, usingSpringWithDamping: constant.TableViewAnimationDamping, initialSpringVelocity: constant.TableViewAnimationInitialSpeed, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.itemTable.frame = CGRectMake(0, 220, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
                self.instructionImage.alpha = 1
                }, completion: { (Bool) -> Void in
            })
            self.getData(data!)
            self.itemTableView.reloadData()
        }else{
            sender.title = "Change"
            UIView.animateWithDuration(constant.TableViewAnimationDuration, delay: constant.TableViewAnimationDelay, usingSpringWithDamping: constant.TableViewAnimationDamping, initialSpringVelocity: constant.TableViewAnimationInitialSpeed, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.itemTable.frame = CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
                self.instructionImage.alpha = 0
                }, completion: { (Bool) -> Void in
            })
            getDataForShow()
            itemTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var itemTable: UITableView!{
        didSet{
            itemTable.delegate = self
        }
    }
    
    
//MARK:sitting tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return name.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return constant.HeightForHeaderInSection
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if buttonForChange == false{
            return 30
        }else{
            return 40
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]
      
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return name[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellIdentifier = constant.ItemID
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ItemTableViewCell
        if buttonForChange == false{
            cell.checkOutlet.hidden = true
            cell.itemNumber.borderStyle = UITextBorderStyle.None
            cell.itemNumber.enabled = false
        }
        else{
            cell.checkOutlet.hidden = false
            cell.itemNumber.borderStyle = UITextBorderStyle.RoundedRect
            cell.itemNumber.enabled = true
            if cell.itemNumber.text == "0"{
                cell.checkOutlet.setImage(UIImage(named: "check"), forState: .Normal)
            }else{
                cell.checkOutlet.setImage(UIImage(named: "checked"), forState: .Normal)
            }
        }
        cell.itemName.text = name[indexPath.section][indexPath.row]
        cell.itemNumber.text = number[indexPath.section][indexPath.row]
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
//MARK:functions
    func getData(datas: NSMutableDictionary){
        //get data for editing
        name.removeAll(keepCapacity: true)
        number.removeAll(keepCapacity: true)
        sectionName.removeAll(keepCapacity: true)
        sectionName = datas.allKeys as! [String]
        for i in datas.allKeys{
            let j = datas.objectForKey(i)?.allKeys as! [String]
            name.append(j)
        }
        for i in datas.allKeys{
            let j = datas.objectForKey(i)?.allValues as! [String]
            number.append(j)
        }
    }

    func getDataForShow(){
        //get data for show
        let dataForShow = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(data!)) as! NSMutableDictionary
        for keys in dataForShow.allKeys as! [String]{
            for i in dataForShow.objectForKey(keys)?.allKeys as! [String]
            {
                if dataForShow.objectForKey(keys)?.objectForKey(i) as! String == "0"
                {
                    dataForShow.objectForKey(keys)?.removeObjectForKey(i)
                }
            }
        }
        getData(dataForShow)
    }
}
