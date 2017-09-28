//
//  ColumnHours.swift
//  client-ipad
//
//  Created by Alexandre Page on 28/09/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class HoursColumn: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlanningViewController.hours.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoursCell", for: indexPath) as! HoursCell
        cell.time.text = PlanningViewController.hours[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ((tableView.bounds.size.height) / CGFloat(PlanningViewController.hours.count))
    }

}
