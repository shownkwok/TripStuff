//
//  ItemTableViewCell.swift
//  TripStuff
//
//  Created by SHAWN on 7/30/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell, UITextFieldDelegate {
    struct Constant {
        static let ButtonTitleOn = "checked"
        static let ButtonTitleOff = "check"
        static let DefaultItemNumber: Int = 1
    }

    @IBAction func itemCheck(sender: UIButton) {
            if sender.imageForState(.Normal) == UIImage(named: Constant.ButtonTitleOff){
                sender.setImage(UIImage(named: Constant.ButtonTitleOn), forState: UIControlState.Normal)
                itemNumber.text = "\(Constant.DefaultItemNumber)"
                setData(Constant.ButtonTitleOn)
            }else{
                sender.setImage(UIImage(named: Constant.ButtonTitleOff), forState: UIControlState.Normal)
                itemNumber.text = "0"

                setData(Constant.ButtonTitleOff)
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
        checkOutlet.setImage(UIImage(named: Constant.ButtonTitleOff), forState: UIControlState.Normal)
        return true
    }
    func setData(buttonState: String){
        for keys in data?.allKeys as! [String]{
            for i in data?.objectForKey(keys)?.allKeys as! [String]
            {
                if itemName.text == i {
                    if buttonState == Constant.ButtonTitleOff{
                    data?.objectForKey(keys)?.setObject("0", forKey: i)
                    }else{
                        data?.objectForKey(keys)?.setObject(itemNumber.text, forKey: i)
                    }
                }
            }
        }
    }
}


