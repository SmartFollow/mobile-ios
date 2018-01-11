//
//  PlanningExtension.swift
//  client-ipad
//
//  Created by Alexandre Page on 07/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation

extension PlanningViewController {
  
  func filterReservationAndLesson(date: Date) -> ([Lesson], [Reservation]) {
    var reservationOfTheDay = [Reservation]()
    var lessonOfTheDay = [Lesson]()
    for reservation in self.reservations {
      if calendar.isDate(date, inSameDayAs:reservation.timeStart) {
        reservationOfTheDay.append(reservation)
      }
    }
    
    for lesson in self.lessons {
      if calendar.isDate(date, inSameDayAs: lesson.timeStart) {
        lessonOfTheDay.append(lesson)
      }
    }
    
    return (lessonOfTheDay, reservationOfTheDay)
  }
  
}
