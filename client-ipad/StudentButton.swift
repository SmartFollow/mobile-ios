//
//  StudentButton.swift
//  client-ipad
//
//  Created by Alexandre Page on 17/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class StudentButton: UIButton {
    
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
        self.segmentState = 0
        self.buttonState = 0
        
        super.init(frame: frame)
        initActivityMonitor()
        self.tag = 2
        self.addTarget(self, action:#selector(self.changeState(sender:)), for: .touchUpInside)
        DispatchQueue.main.async {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.frame.width / 2
            self.setBackgroundImage(UIImage(named: "bechad.png"), for: .normal)
        }
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
            case 0:
                postAbsence()
            case 1:
                postChatting()
            default:
                break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func postChatting() {
        
    }
    
    public func postAbsence() {
        
        if self.student.evaluation == nil {
            print("student_id=\(self.student.id)&lesson_id=\(self.lesson.id)&comment=NO")
            ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations", method: "POST", parameters: "student_id=\(self.student.id)&lesson_id=\(self.lesson.id)&comment=NO") { (result: Data?) in
                self.student.evaluation = ApiManager.parseEvaluation(result: result)
                self.rollCall()
            }
        } else {
            self.rollCall()
        }
        
    }
    
}


