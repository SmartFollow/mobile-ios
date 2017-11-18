//
//  StudentButton.swift
//  client-ipad
//
//  Created by Alexandre Page on 17/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class StudentButton: UIButton {
  
  static let viewTag: Int = 2
  
  var iconTab = ["present.png", "late.png", "absent.png"]
  let studentStates = ["Présent", "Absent", "En retard"]
  var activityIndicator: UIActivityIndicatorView
  var segmentState: Int!
  var buttonState: Int!
  var student: Student
  var lesson: Lesson
  var delay: Delay?
  var absence: Absence?
  
  required init(frame: CGRect, student: Student, lesson: Lesson) {
    self.activityIndicator = UIActivityIndicatorView()
    self.student = student
    self.lesson = lesson
    self.segmentState = 1
    self.buttonState = 0
    
    super.init(frame: frame)
    initActivityMonitor()
    self.tag = StudentButton.viewTag
    self.addTarget(self, action:#selector(self.changeState(sender:)), for: .touchUpInside)
    self.layer.masksToBounds = true
    self.layer.cornerRadius = self.frame.width / 2
    self.setBackgroundImage(self.student.avatar, for: .normal)
  }
  
  func initActivityMonitor() {
    let buttonHeight = self.bounds.size.height
    let buttonWidth = self.bounds.size.width
    self.activityIndicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
    self.activityIndicator.alpha = 0.5
    self.addSubview(self.activityIndicator)
  }
  
  func changeState(sender: UIButton) {
    self.activityIndicator.startAnimating()
    self.activityIndicator.hidesWhenStopped = true
    self.isEnabled = false
    switch self.segmentState {
    case 1:
      postAbsence()
    case 2:
      postChatting()
    default:
      break
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func postChatting() {
    if self.student.evaluation == nil {
      ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations", method: "POST", parameters: "student_id=\(self.student.id)&lesson_id=\(self.lesson.id)&comment=NO") { (result: Data?) in
        self.student.evaluation = ApiManager.parseEvaluation(result: result)
        self.gossip()
      }
    } else {
      self.gossip()
    }
  }
  
  public func postAbsence() {
    
    if self.student.evaluation == nil {
      ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations", method: "POST", parameters: "student_id=\(self.student.id)&lesson_id=\(self.lesson.id)&comment=NO") { (result: Data?) in
        self.student.evaluation = ApiManager.parseEvaluation(result: result)
        self.rollCall()
      }
    } else {
      self.rollCall()
    }
    
  }
  
}


