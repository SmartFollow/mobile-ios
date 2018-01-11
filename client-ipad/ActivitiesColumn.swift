//
//  HoursTable.swift
//  client-ipad
//
//  Created by Alexandre Page on 28/09/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class ActivitiesColumn: UITableViewController {
  var date: Date?
  var reservation: [Reservation]?
  let formatter = DateFormatter()
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return PlanningViewController.hours.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return ((tableView.bounds.size.height) / CGFloat(PlanningViewController.hours.count))
  }
}

