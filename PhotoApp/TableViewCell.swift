//
//  TableViewCell.swift
//  PhotoApp
//
//  Created by Kevin Fang on 7/28/15.
//  Copyright (c) 2015 Kevin Fang. All rights reserved.
//

import UIKit


import Foundation
import UIKit

class TableViewCell: UITableViewCell {

    // initialize the date formatter only once, using a static computed property
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
        }()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextField!
    
    var note: Note? {
        didSet {
            if let note = note, dateLabel = dateLabel, titleLabel = titleLabel{
                self.dateLabel.text = TableViewCell.dateFormatter.stringFromDate(note.modificationDate)
                self.titleLabel.text = note.title
            }
        }
    }
}

