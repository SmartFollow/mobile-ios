//
//  ExtensionApiManager.swift
//  client-ipad
//
//  Created by Alexandre Page on 07/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation


extension ApiManager {
    
    public static func parseLessons(result: Data?) -> [Lesson] {
        var lessons = [Lesson]()
        do {
            if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
                for jsonLesson in json {
                    if let id = jsonLesson["id"], let subjectId = jsonLesson["subject_id"], let reservationId = jsonLesson["reservation_id"], let studentClassId = jsonLesson["student_class_id"], let start = jsonLesson["start"], let end = jsonLesson["end"],
                        let subject = jsonLesson["subject"] as? [String: Any], let subjectName = subject["name"],
                        let reservation = jsonLesson["reservation"] as? [String: Any], let room = reservation["room"] as? [String: Any],
                        let roomIdentifier = room["identifier"] {
                        let lesson = Lesson(id: id as! Int, subjectId: subjectId as! Int, reservationId: reservationId as! Int, studentClassId: studentClassId as! Int, start: start as! String, end: end as! String, subjectName: subjectName as! String, roomIdentifier: roomIdentifier as! String )
                        lessons.append(lesson)
                    }
                }
            }
        }
        catch let error as NSError {
            print("Failed to lead: \(error.localizedDescription)")
        }
        return lessons
    }
    
    public static func parseReservation(result: Data?) -> [Reservation] {
        var reservations = [Reservation]()
        do {
            if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
                for jsonReservation in json {
                    if let id = jsonReservation["id"], let roomId = jsonReservation["room_id"], let timeStart = jsonReservation["time_start"], let timeEnd =  jsonReservation["time_end"], let dateStart = jsonReservation["date_start"], let dateEnd = jsonReservation["date_end"], let room = jsonReservation["room"] as? [String: Any], let roomIdentifier = room["identifier"] {
                        let reservation = Reservation(id: id as! Int, roomId: roomId as! Int, timeStart: "\(dateStart) \(timeStart)" as String, timeEnd: "\(dateEnd) \(timeEnd)" as String, roomIdentifier: roomIdentifier as! String)
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
