//
//  PlanningViewController.swift
//  CalendarWeekView
//
//  Created by Alexandre Page on 22/09/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit
import JTAppleCalendar

class PlanningViewController: UIViewController {
    @IBOutlet weak var columnHours: UITableView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    let activityManager = ActivitiesColumn()
    let hoursManager = HoursColumn()
    static let hours = ["8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"]
    var days = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
    
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        calendarView.scrollToDate(Date())
        calendarView.scrollDirection = .horizontal
        columnHours.delegate = self.hoursManager
        columnHours.dataSource = self.hoursManager
    }

}

extension PlanningViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2017 12 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 1)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        cell.circle.isHidden = true
        cell.dayNumber.textColor = UIColor.black
        
        cell.columnActivity.delegate = activityManager
        cell.columnActivity.dataSource = activityManager
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            cell.circle.isHidden = false
            cell.dayNumber.textColor = UIColor.white
        }
        cell.dayNumber.text = cellState.text
        cell.day.text = self.days[cellState.day.hashValue]
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }

}

extension PlanningViewController:JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        if let date = visibleDates.monthDates.first?.date {
            formatter.dateFormat = "MMMM"
            month.text = formatter.string(from: date)
            
            formatter.dateFormat = "yyyy"
            year.text = formatter.string(from: date)
        }
    }
        
}

