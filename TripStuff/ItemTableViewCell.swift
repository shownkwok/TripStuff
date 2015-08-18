//
//  ItemTableViewCell.swift
//  TripStuff
//
//  Created by SHAWN on 7/30/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell, UITextFieldDelegate {
    struct constant {
        static let buttonTitleOn = "Checked"
        static let buttonTitleOff = "Uncheck"
        static let defaultItemNumber: Int = 1
    }

    @IBAction func itemCheck(sender: UIButton) {
            if sender.imageForState(.Normal) == UIImage(named: "check"){
                sender.setImage(UIImage(named: "checked"), forState: UIControlState.Normal)
                itemNumber.text = "\(constant.defaultItemNumber)"
                setData("checked")
            }else{
                sender.setImage(UIImage(named: "check"), forState: UIControlState.Normal)
                itemNumber.text = "0"

                setData("check")
            }
            data?.writeToFile("\(path)\(user!).plist", atomically: true)
    }
    
    @IBOutlet weak var checkOutlet: UIButton!
    @IBOutlet weak var itemName: UILabel!

    @IBOutlet weak var itemNumber: UITextField!{
        didSet{
            itemNumber.delegate = self
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        itemNumber.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        checkOutlet.setImage(UIImage(named: "ckeck"), forState: UIControlState.Normal)
        return true
    }
    func setData(buttonState: String){
        for keys in data?.allKeys as! [String]{
            for i in data?.objectForKey(keys)?.allKeys as! [String]
            {
                if itemName.text == i {
                    if buttonState == "check"{
                    data?.objectForKey(keys)?.setObject("0", forKey: i)
                    }else{
                        data?.objectForKey(keys)?.setObject(itemNumber.text, forKey: i)
                    }
                }
            }
        }
    }
}


