//
//  UITableViewLessonController.swift
//  client-ipad
//
//  Created by Alexandre Page on 25/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

extension LessonViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = self.students?.count {
      return count
    } else {
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
    if let student: Student = self.students?[indexPath.row] {
      cell.studentName.text = "\(student.firstName) \(student.lastName)"
      cell.studentPicture.image = self.students?[indexPath.row].avatar
      cell.studentPicture.asCircle()
      cell.presence.text = "Présence : 1"
      cell.activity.text = "Activités : 1"
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
}
