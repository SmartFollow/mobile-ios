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
  
  public static func saveInformationProfile(result: Data?) -> Void {
    var taughtSubjectsArray = [Dictionary<String, Int>]()
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        if let firstName = json["firstname"], let lastName = json["lastname"], let id = json["id"],
          let email = json["email"] as? String {
          UserDefaults.standard.set(firstName, forKey: "firstName")
          UserDefaults.standard.set(lastName, forKey: "lastName")
          UserDefaults.standard.set(email, forKey: "email")
          UserDefaults.standard.set(id, forKey: "id")
        }
        if let group = json["group"] as? [String: AnyObject] {
          if let groupId = group["id"], let groupName = group["name"] as? String {
            UserDefaults.standard.set(groupId, forKey: "groupId")
            UserDefaults.standard.set(groupName, forKey: "groupName")
          }
        }
        if let taughtSubjects = json["taught_subjects"] as? [[String: Any]] {
          for subject in taughtSubjects {
            if let id = subject["id"] as? Int,
              let levelId = subject["level_id"] as? Int {
              taughtSubjectsArray.append(["id": id, "levelId": levelId])
            }
          }
          UserDefaults.standard.set(taughtSubjectsArray, forKey: "taughtSubjects")
          let a = UserDefaults.standard.object(forKey: "taughtSubjects") as! [Dictionary<String, Int>]
          //                    for b in a {
          //                        print(b["id"]!)
          //                        print(b["levelId"]!)
          //                    }
        }
      }
      
    } catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
  }
  
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
  
  public static func parseClassStudent(result: Data?) -> [Student]? {
    var studentClass = [Student]()
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        guard let student_class = json["student_class"] as? [String: Any] else { return nil }
        guard let students = student_class["students"] as? [[String: Any]] else { return nil }
        for student in students {
          guard let id = student["id"] else { return nil }
          guard let email = student["email"] else { return nil }
          guard let firstName = student["firstname"] else { return nil }
          guard let lastName = student["lastname"] else { return nil }
          guard let classId = student["class_id"] else { return nil }
          guard let groupIpd = student["group_id"] else { return nil }
          guard let avatar = student["avatar"] else { return nil }
          let myStudent = Student(id: id as! Int, email: email as! String, firstName: firstName as! String, lastName: lastName as! String, classId: classId as! Int, groupId: groupIpd as! Int, avatarUrl: avatar as! String)
          
          if let evaluation = student["lesson_evaluation"] as? [String: Any] {
            guard let id = evaluation["id"] else { return nil }
            guard let studentId = evaluation["student_id"] else { return nil }
            guard let lessonId = evaluation["lesson_id"] else { return nil }
            let myEvaluation = Evaluation(id: id as! Int, studentId: studentId as! Int, lessonId: lessonId as! Int)
            
            if let absence = evaluation["absence"] as? [String: Any] {
              guard let id = absence["id"] else { return nil }
              guard let evaluationId = absence["evaluation_id"] else { return nil }
              let myAbsence = Absence(id: id as! Int, evaluationId: evaluationId as! Int)
              myEvaluation.absence = myAbsence
            }
            
            if let delay = evaluation["delay"] as? [String: Any] {
              guard let id = delay["id"] else { return nil }
              guard let evaluationId = delay["evaluation_id"] else { return nil }
              guard let arrivedAt = delay["arrived_at"] else { return nil }
              let myDelay = Delay(id: id as! Int, evaluationId: evaluationId as! Int, arrivedAt: arrivedAt as! String)
              myEvaluation.delay = myDelay
            }
            myStudent.evaluation = myEvaluation
          }
          studentClass.append(myStudent)
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
              if let id = participant["id"], let email = participant["email"], let firstName = participant["firstname"],
                let avatarUrl = participant["avatar"] {
                myParticipants.append(Participant(id: id as! Int, email: email as! String, firstName: firstName as! String, avatarUrl: avatarUrl as! String))
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
          if let firstName = jsonStudent["firstname"], let lastName = jsonStudent["lastname"], let email = jsonStudent["email"], let avatar = jsonStudent["avatar"], let id = jsonStudent["id"] {
            let user = User(id: id as! Int, email: email as! String, firstName: firstName as! String, lastName: lastName as! String, avatarUrl: avatar as! String)
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
  
  public static func parseMessages(result: Data?, conversation: Conversation) {
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        if let messages = json["messages"] as? [[String: Any]] {
          for message in messages {
            let userMessage = Message(content: message["content"] as! String, date: message["created_at"] as! String, creatorId: message["creator_id"] as! Int)
            conversation.messages.append(userMessage)
          }
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    conversation.sortMessageByDate()
  }
  
  public static func parseMessageSent(result: Data?) -> Message? {
    var message: Message?
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        if let id = json["id"], let creatorId = json["creator_id"], let date = json["created_at"], let content = json["content"] {
          message = Message(content: content as! String, date: date as! String, creatorId: creatorId as! Int)
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return message
  }
  
  public static func parseConversation(result: Data?) -> Conversation? {
    var conversation: Conversation?
    
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        if let id = json["id"], let creatorId = json["creator_id"], let subject = json["subject"], let participants = json["participants"] as? [[String: Any]] {
          
          var myParticipants = [Participant]()
          
          for participant in participants {
            if let id = participant["id"], let email = participant["email"], let firstName = participant["firstname"],
              let avatarUrl = participant["avatar"] {
              myParticipants.append(Participant(id: id as! Int, email: email as! String, firstName: firstName as! String, avatarUrl: avatarUrl as! String))
            }
          }
          conversation = Conversation(id: id as! Int, creatorId: creatorId as! Int, subject: subject as! String, participants: myParticipants)
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return conversation
  }
  
  public static func parseDifficulty(result: Data?) -> [Student] {
    var students =  [Student]()
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        if let difficulties = json["self_difficulties"] as? [[String: Any]] {
          for difficulty in difficulties {
            if let student = difficulty["student"] as? [String: Any] {
              if let id = student["id"], let email = student["email"], let firstName = student["firstname"], let lastName = student["lastname"], let avatar = student["avatar"], let classId = student["class_id"], let groupId = student["group_id"] {
                let entityStudent = Student(id: id as! Int, email: email as! String, firstName: firstName as! String, lastName: lastName as! String, classId: classId as! Int, groupId: groupId as! Int, avatarUrl: avatar as! String)
                students.append(entityStudent)
              }
            }
          }
        }
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return students
  }
  
  
}
