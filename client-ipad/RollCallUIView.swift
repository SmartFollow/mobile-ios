//
//  RollCallUIView.swift
//  client-ipad
//
//  Created by Alexandre Page on 22/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class RollCallUIView: UIView {
  
  static let tagView: Int = 1
  var studentState: UILabel!

  required init(frame: CGRect, student: Student, lesson: Lesson) {
    super.init(frame: frame)
    self.tag = RollCallUIView.tagView
    let button = StudentButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200), student: student, lesson: lesson)
    let studentName = UILabel(frame: CGRect(x: 0, y: button.frame.size.height + 10, width: 200, height: 25))
    self.studentState = UILabel(frame: CGRect(x: 0, y: button.frame.size.height + 40, width: 200, height: 25))
    studentName.text = "\(student.firstName) \(student.lastName)"
    studentName.textAlignment = .center
    studentName.textColor = UIColor.black
    studentState.text = "Présent"
    studentState.textColor = UIColor.black
    studentState.textAlignment = .center
    self.addSubview(studentState)
    self.addSubview(studentName)
    self.addSubview(button)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
