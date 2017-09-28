//
//  TableView.swift
//  CalendarWeekView
//
//  Created by Alexandre Page on 27/09/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

let hours = ["8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"]

extension PlanningViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == hoursTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HoursCell", for: indexPath) as! HoursOfDayCell
            cell.time.text = hours[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            return cell
        }   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ((tableView.bounds.size.height) / CGFloat(hours.count))
    }
}
