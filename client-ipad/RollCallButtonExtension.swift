//
//  ExtensionRollCallButton.swift
//  client-ipad
//
//  Created by Alexandre Page on 23/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//


import UIKit

extension StudentButton {
  
  public func rollCall() {
    if let evaluation = self.student.evaluation {
      switch self.buttonState {
      case 0:
        createAbsence(evaluation: evaluation)
      case 1:
        if let absence = self.absence {
          removeAbsence(evaluation: evaluation, absence: absence)
        }
        createDelay(evaluation: evaluation)
      case 2:
        if let delay = self.delay, let evaluation = self.student.evaluation {
          removeDelay(evaluation: evaluation, delay: delay)
        }
      default:
        break
      }
      self.buttonState = self.buttonState + 1
    }
  }
  
  public func createDelay(evaluation: Evaluation) {
    let hour = String(format: "%02d", Calendar.current.component(.hour, from: Date()))
    let min = String(format: "%02d", Calendar.current.component(.minute, from: Date()))
    
    ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(evaluation.id)/delays", method: "POST", parameters: "arrived_at=\(hour):\(min)", completion: { (result: Data?) in
      self.delay = ApiManager.parseDelay(result: result)
      self.finishAnimation()
    })
  }
  
  public func removeDelay(evaluation: Evaluation, delay: Delay) {
    
    ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(evaluation.id)/delays/\(delay.id)", method: "DELETE", completion: { (result: Data?) in
      self.finishAnimation()
    })
  }
  
  public func removeAbsence(evaluation: Evaluation, absence: Absence) {
    ApiManager.sharedInstance.fetch(endPoint: "api/evaluations/\(evaluation.id)/absences/\(absence.id)", method: "DELETE", completion: { (result: Data?) in
      self.finishAnimation()
    })
  }
  
  public func createAbsence(evaluation: Evaluation) {
    ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(evaluation.id)/absences", method: "POST", completion: { (result: Data?) in
      self.absence = ApiManager.parseAbsence(result: result)
      self.finishAnimation()
    })
  }
  
  public func finishAnimation() {
    if (self.buttonState > 2) {
      self.buttonState = 0
    }
    DispatchQueue.main.async() {
      self.activityIndicator.stopAnimating()
      self.isEnabled = true
      if let superview = self.superview as! RollCallUIView? {
        superview.studentState.text = self.studentStates[self.buttonState]
      }
    }
  }
  
}
