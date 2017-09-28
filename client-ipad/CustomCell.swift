//
//  CustomCell.swift
//  CalendarWeekView
//
//  Created by Alexandre Page on 22/09/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CustomCell: JTAppleCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var columnDay: UITableView!
}
