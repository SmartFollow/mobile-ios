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
    let calendar = Calendar.current
    let activityManager = ActivitiesColumn()
    let hoursManager = HoursColumn()
    var reservations = [Reservation]()
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
        fetchSchedule()
    }
    
    func fetchSchedule() {
        ApiManager.sharedInstance.b(endPoint: "/api/reservations") { (result: Data?) in
            self.reservations = self.parseReservation(result: result)
            DispatchQueue.main.async(execute: {
                self.calendarView.reloadData()
            })
        }
    }
    
    func filterReservation(date: Date) -> [Reservation]? {
        var reservationOfTheDay: [Reservation]?
        for reservation in self.reservations {
            if calendar.isDate(date, inSameDayAs:reservation.timeStart) {
                reservationOfTheDay?.append(reservation)
            }
        }
        return reservationOfTheDay
    }
    
    func configureCell(customCell: JTAppleCell?, cellState: CellState, date: Date) {
        guard let cell = customCell as? DateCell else { return }
        cell.circle.isHidden = true
        cell.dayNumber.textColor = UIColor.black
        
        cell.columnActivity.delegate = activityManager
        cell.columnActivity.dataSource = activityManager
        activityManager.date = cellState.date
        activityManager.reservation = self.filterReservation(date: date)
        
        if calendar.isDateInToday(date) {
            cell.circle.isHidden = false
            cell.dayNumber.textColor = UIColor.white
        }
        
        cell.dayNumber.text = cellState.text
        cell.day.text = self.days[cellState.day.hashValue]
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
    }
    
    func parseReservation(result: Data?) -> [Reservation] {
        var reservations = [Reservation]()
        do {
            if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
                for jsonReservation in json {
                    if let id = jsonReservation["id"], let roomId = jsonReservation["room_id"], let timeStart = jsonReservation["time_start"], let timeEnd =  jsonReservation["time_end"], let dateStart = jsonReservation["date_start"], let dateEnd = jsonReservation["date_end"] {
                        let reservation = Reservation(id: id as! Int, roomId: roomId as! Int, timeStart: "\(dateStart) \(timeStart)" as String, timeEnd: "\(dateEnd) \(timeEnd)" as String)
                        reservations.append(reservation)
                    }
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return reservations
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
        configureCell(customCell: cell, cellState: cellState, date: date)
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

