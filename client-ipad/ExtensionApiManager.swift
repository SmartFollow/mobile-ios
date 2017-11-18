//
//  ExtensionApiManager.swift
//  client-ipad
//
//  Created by Alexandre Page on 07/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation
import UIKit


extension ApiManager {
  
  public static func parseLessons(result: Data?) -> [Lesson] {
    var lessons = [Lesson]()
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
        for jsonLesson in json {
          if let id = jsonLesson["id"], let subjectId = jsonLesson["subject_id"], let reservationId = jsonLesson["reservation_id"], let studentClassId = jsonLesson["student_class_id"], let start = jsonLesson["start"], let end = jsonLesson["end"],
            let studentClass = jsonLesson["student_class"] as? [String: Any], let studentClassName = studentClass["name"],
            let subject = jsonLesson["subject"] as? [String: Any], let subjectName = subject["name"],
            let reservation = jsonLesson["reservation"] as? [String: Any], let room = reservation["room"] as? [String: Any],
            let roomIdentifier = room["identifier"] {
            let lesson = Lesson(id: id as! Int, subjectId: subjectId as! Int, reservationId: reservationId as! Int, studentClassId: studentClassId as! Int, start: start as! String, end: end as! String, subjectName: subjectName as! String, roomIdentifier: roomIdentifier as! String, studentClassName: studentClassName as! String)
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
  
  public static func parseClassStudent(result: Data?) -> [Student] {
    var studentClass = [Student]()
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
        for jsonStudent in json {
          if let id = jsonStudent["id"], let email = jsonStudent["email"], let firstName = jsonStudent["firstname"], let lastName = jsonStudent["lastname"], let classId = jsonStudent["class_id"], let groupId = jsonStudent["group_id"],
            let avatar = jsonStudent["avatar"]{
            let student = Student(id: id as! Int, email: email as! String, firstName: firstName as! String, lastName: lastName as! String, classId: classId as! Int, groupId: groupId as! Int, avatarUrl: avatar as! String)
            studentClass.append(student)
          }
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return studentClass
  }
  
  public static func parseEvaluation(result: Data?) -> Evaluation? {
    var evaluation: Evaluation?
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        if let id = json["id"], let studentId = json["student_id"], let lessonId = json["lesson_id"], let comment = json["comment"] {
          evaluation = Evaluation(id: Int(id as! Int), studentId: Int((studentId as! NSString).intValue), lessonId: Int((lessonId as! NSString).intValue), comment: comment as? String)
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return evaluation
  }
  
  public static func parseDelay(result: Data?) -> Delay? {
    var delay: Delay?
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        if let id = json["id"], let evaluationId = json["evaluation_id"], let arrivedAt = json["arrived_at"] {
          delay = Delay(id: id as! Int, evaluationId: Int((evaluationId as! NSString).intValue), arrivedAt: arrivedAt as! String)
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return delay
  }
  
  public static func parseAbsence(result: Data?) -> Absence? {
    var absence: Absence?
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        if let id = json["id"], let evaluationId = json["evaluation_id"] {
          absence = Absence(id: id as! Int, evaluationId:  Int((evaluationId as! NSString).intValue))
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return absence
  }
  
  public static func parseListConversation(result: Data?) -> [Conversation]? {
    var conversations = [Conversation]()
    
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
        for conversation in json {
          if let id = conversation["id"], let creatorId = conversation["creator_id"], let subject = conversation["subject"], let participants = conversation["participants"] as? [[String: Any]] {
            
            var myParticipants = [Participant]()
            
            for participant in participants {
              if let id = participant["id"], let email = participant["email"], let firstName = participant["firstname"] {
                myParticipants.append(Participant(id: id as! Int, email: email as! String, firstName: firstName as! String))
              }
            }
            conversations.append(Conversation(id: id as! Int, creatorId: creatorId as! Int, subject: subject as! String, participants: myParticipants))
          }
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return conversations
  }
  
  public static func parseAllUsers(result: Data?) -> [User] {
    var users = [User]()
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
        for jsonStudent in json {
          if let firstName = jsonStudent["firstname"], let lastName = jsonStudent["lastname"], let email = jsonStudent["email"],
          let avatar = jsonStudent["avatar"] {
            let user = User(email: email as! String, firstName: firstName as! String, lastName: lastName as! String, avatarUrl: avatar as! String)
            users.append(user)
          }
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return users
  }
}
