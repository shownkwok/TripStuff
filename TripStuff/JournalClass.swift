
//
//  JournalClass.swift
//  TripStuff
//
//  Created by SHAWN on 8/5/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit
class JournalClass {
    var journalTitle: String!
    var journalDetail: String?
    var journalImageSet: [UIImage]?
    var journalTime: NSTimer?
    init(journalTitle: String){
        self.journalTitle = journalTitle
    }
}