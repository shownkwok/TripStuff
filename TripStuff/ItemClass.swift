//
//  ItemClass.swift
//  TripStuff
//
//  Created by SHAWN on 7/31/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class ItemClass {
    var itemName: String!
    var itemNumber: String!
    var itemImage: UIImageView?
    init (itemName: String, itemNumber: String){
        self.itemName = itemName
        self.itemNumber = itemNumber
    }
}
