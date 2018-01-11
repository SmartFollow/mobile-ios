//
//  CaseCalendar.swift
//  client-ipad
//
//  Created by Alexandre Page on 01/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

protocol ViewProtocol {
  func performSegueFromView(event: Planning)
}

class CasePlanning: UIView {
  
  var delegate : ViewProtocol?
  var event: Planning?
  
  init<T:Planning>(frame: CGRect, event: T) {
    super.init(frame: frame)
    self.tag = 42
    self.event = event
    
    let gesture = UITapGestureRecognizer(target:self, action:#selector(CasePlanning.handleTap(_:)))
    self.addGestureRecognizer(gesture)
    
    let subject: UILabel = UILabel()
    let roomIdentifier: UILabel = UILabel()
    let timeStart: UILabel = UILabel()
    subject.translatesAutoresizingMaskIntoConstraints = false
    roomIdentifier.translatesAutoresizingMaskIntoConstraints = false
    timeStart.translatesAutoresizingMaskIntoConstraints = false
    
    let hour = String(format: "%02d", Int(event.hourStart))
    let minute = String(format: "%02d", Int(event.minuteStart))
    timeStart.text = "\(hour):\(minute)"
    
    if event is Lesson {
      subject.text = "\(event.subjectName)"
      roomIdentifier.text = "\(event.roomIdentifier)"
      self.backgroundColor = UIColor(red: 214/255, green: 48/255, blue: 58/255, alpha: 1.0)
    } else if event is Reservation {
      subject.text = "Réservation"
      roomIdentifier.text = "\(event.roomIdentifier)"
      self.backgroundColor = UIColor.gray
    }
    
    setupLabel(label: subject)
    setupLabel(label: roomIdentifier)
    setupLabel(label: timeStart)
    
    self.addSubview(timeStart)
    self.addSubview(subject)
    self.addSubview(roomIdentifier)
    
    setupConstraint(subject: subject, roomIdentifier: roomIdentifier, timeStart: timeStart)
  }
  
  func setupLabel( label: UILabel) {
    label.textColor = UIColor.white
    label.numberOfLines = 1
    label.minimumScaleFactor = 0.7
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
  }
  
  func setupConstraint(subject: UILabel, roomIdentifier: UILabel, timeStart: UILabel) {
    let xConstraint = NSLayoutConstraint(item: subject, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
    let yConstraint = NSLayoutConstraint(item: subject, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
    
    let bottomConstraint = NSLayoutConstraint(item: roomIdentifier, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10.0)
    let trailingConstraint = NSLayoutConstraint(item: roomIdentifier, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10.0)
    
    let timeTopConstraint = NSLayoutConstraint(item: timeStart, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0)
    let timeLeadingConstraint = NSLayoutConstraint(item: timeStart, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10.0)
    
    
    self.addConstraint(timeTopConstraint)
    self.addConstraint(timeLeadingConstraint)
    self.addConstraint(bottomConstraint)
    self.addConstraint(trailingConstraint)
    self.addConstraint(xConstraint)
    self.addConstraint(yConstraint)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func handleTap(_ sender: UITapGestureRecognizer) {
    if let myEvent = self.event as? Lesson {
      self.delegate?.performSegueFromView(event: myEvent)
    }
  }
  
}
