//
//  TableViewCell.swift
//  PhotoApp
//
//  Created by Kevin Fang on 7/28/15.
//  Copyright (c) 2015 Kevin Fang. All rights reserved.
//

import Foundation
import UIKit



class TableViewCell: UITableViewCell {
    // initialize the date formatter only once, using a static computed property
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
        }()
    
    
    
    var note: Note? {
        didSet {
            if let note = note, titleLabel = titleLabel, dateLabel = dateLabel {
                self.titleLabel.text = note.title
                self.dateLabel.text = TableViewCell.dateFormatter.stringFromDate(note.modificationDate)
            }
        }
    }
}
