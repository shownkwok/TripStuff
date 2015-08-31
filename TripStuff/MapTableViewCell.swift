//
//  MapTableViewCell.swift
//  TripStuff
//
//  Created by SHAWN on 8/25/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var time: UILabel!

    @IBOutlet weak var lagitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    
    @IBOutlet weak var info: UILabel!
}
