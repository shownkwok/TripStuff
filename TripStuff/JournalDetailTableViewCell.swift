//
//  JournalDetailTableViewCell.swift
//  TripStuff
//
//  Created by SHAWN on 8/5/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class JournalDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBOutlet weak var thumbnail: UIImageView!

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var brifeDetail: UILabel!
}
