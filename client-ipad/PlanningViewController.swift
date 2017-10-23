//
//  PlanningViewController.swift
//  CalendarWeekView
//
//  Created by Alexandre Page on 22/09/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit
import JTAppleCalendar

class PlanningViewController: UIViewController, ViewProtocol {
    @IBOutlet weak var columnHours: UITableView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    
    let calendar = Calendar.current
    let activityManager = ActivitiesColumn()
    let hoursManager = HoursColumn()
    var reservations = [Reservation]()
    var lessons = [Lesson]()
    static let hours = ["8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"]
    var days = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"]
    let cellHeight: Double = Double((UIScreen.main.bounds.height - 212.0) / CGFloat(PlanningViewController.hours.count))
    
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        calendarView.scrollToDate(Date())
        calendarView.scrollingMode = .stopAtEachCalendarFrameWidth
        calendarView.scrollDirection = .horizontal
        columnHours.delegate = self.hoursManager
        columnHours.dataSource = self.hoursManager
        fetchSchedule()
        initCaseCalendar()
    }
    
    func performSegueFromView(event: Planning) {
        self.performSegue(withIdentifier: "Course", sender: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Course" {
            if let destinationVC = segue.destination as? LessonViewController {
                destinationVC.lesson = sender as? Lesson
            }
        }
    }
    
    func initCaseCalendar() {
        print(self.cellHeight)
        let width = Double(UIScreen.main.bounds.size.width - 150.0)
        for i in 1..<12 {
            let y = 212 + (Double(i) * self.cellHeight)
            let frame = CGRect(x: 150.0, y: y, width: width, height: 0)
            let line = UIView(frame: frame)
            line.add(border: ViewBorder(rawValue: "bottom")!, color: UIColor.gray, width: 1.0)
            self.view.addSubview(line)
        }
    }
    
    func fetchSchedule() {
        ApiManager.sharedInstance.fetch(endPoint: "/api/reservations") { (result: Data?) in
            self.reservations = ApiManager.parseReservation(result: result)
            ApiManager.sharedInstance.fetch(endPoint: "/api/lessons") { (result: Data?) in
                self.lessons = ApiManager.parseLessons(result: result)
                DispatchQueue.main.async(execute: {
                    self.calendarView.reloadData()
                })
            }
        }
    }
    
    func addReservationOnView(customCell: JTAppleCell?, cellState: CellState?, date: Date) {
        var (lessons, reservations) = self.filterReservationAndLesson(date: date)
        if (reservations.count > 0) {
            for reservation in reservations {
                initView(customCell: customCell, cellState: cellState, event: reservation)
            }
        }
        if (lessons.count > 0) {
            for lesson in lessons {
                initView(customCell: customCell, cellState: cellState, event: lesson)
            }
        }
    }
    
    func initView<T: Planning>(customCell: JTAppleCell?, cellState: CellState?, event: T){
        guard let cell = customCell as? DateCell else { return }
        
        let tmpIdiotXcode: Double = ((event.hourStart - 8.0) * self.cellHeight)
        let tmp2IdiotXcode: Double = ((self.cellHeight / 60) * event.minuteStart)
    
        let y: Double = 150.0 + tmpIdiotXcode + tmp2IdiotXcode
            
        let height = (((event.hourEnd - event.hourStart) * self.cellHeight) + ((44/60) * event.minuteEnd))
        
        let myCase = CasePlanning(frame: CGRect(x: 0.0, y: y, width: Double(cell.bounds.width), height: height), event: event)
        myCase.delegate = self
        cell.viewCell.addSubview(myCase)
    }
    
    func configureCell(customCell: JTAppleCell?, cellState: CellState, date: Date) {
        guard let cell = customCell as? DateCell else { return }
        for view in cell.viewCell.subviews {
            if view.tag == 42 {
                view.removeFromSuperview()
            }
        }
        cell.circle?.isHidden = true
        cell.dayNumber?.textColor = UIColor.black
        
        if (self.reservations.count > 0) || (self.lessons.count > 0) {
            self.addReservationOnView(customCell: customCell, cellState: cellState, date: date)
        }
        
        if calendar.isDateInToday(date) {
            cell.circle?.isHidden = false
            cell.dayNumber?.textColor = UIColor.white
        }
        
        cell.dayNumber?.text = cellState.text
        cell.day?.text = self.days[cellState.day.rawValue - 1]
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
    }

}

extension PlanningViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2017 12 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 1, generateOutDates: OutDateCellGeneration.off, firstDayOfWeek: DaysOfWeek.monday)
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

