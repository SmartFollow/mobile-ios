//
//  Lesson.swift
//  client-ipad
//
//  Created by Alexandre Page on 08/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Lesson: NSObject, Planning {
  
  let id: Int
  let subjectId: Int
  var subjectName: String
  let reservationId: Int
  let studentClassId: Int
  var timeStart: Date
  var timeEnd: Date
  let formatter = DateFormatter()
  var hourStart: Double
  var hourEnd: Double
  var minuteStart: Double
  var minuteEnd: Double
  var roomIdentifier: String
  var studentClassName: String
  
  init(id: Int, subjectId: Int, reservationId: Int, studentClassId: Int, start: String, end: String,
       subjectName: String, roomIdentifier: String, studentClassName: String) {
    self.id = id
    self.subjectId = subjectId
    self.reservationId = reservationId
    self.studentClassId = studentClassId
    self.subjectName = subjectName
    self.roomIdentifier = roomIdentifier
    self.studentClassName = studentClassName
    
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    self.timeStart = formatter.date(from: start)!
    self.timeEnd = formatter.date(from: end)!
    
    formatter.dateFormat = "HH"
    self.hourStart = Double(formatter.string(from: self.timeStart))!
    self.hourEnd = Double(formatter.string(from: self.timeEnd))!
    
    formatter.dateFormat = "mm"
    self.minuteStart = Double(formatter.string(from: self.timeStart))!
    self.minuteEnd = Double(formatter.string(from: self.timeEnd))!
    
  }
  
  public func getTimeStart() -> String {
    self.formatter.dateFormat = "yyyy-MM-dd HH:mm"
    let date = formatter.string(from: self.timeStart)
    return date
  }
  
}


