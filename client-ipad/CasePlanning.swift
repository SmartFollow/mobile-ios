//
//  CaseCalendar.swift
//  client-ipad
//
//  Created by Alexandre Page on 01/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class CasePlanning: UIView {
    
    //@IBOutlet weak var subject: UILabel!
    @IBOutlet weak var roomIdentifier: UILabel!
    
    init<T:Planning>(frame: CGRect, event: T) {
        super.init(frame: frame)
        self.tag = 42
        let subject: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        
        if event is Lesson {
            subject.text = "\(event.subjectName)"
            //roomIdentifier.text = "\(event.roomIdentifier)"
            self.backgroundColor = UIColor.red
        } else if event is Reservation {
            subject.text = "Réservation"
            //roomIdentifier.text = "\(event.roomIdentifier)"
            self.backgroundColor = UIColor.gray
        }
        subject.textColor = UIColor.white
        subject.numberOfLines = 1
        subject.minimumScaleFactor = 0.7
        subject.adjustsFontSizeToFitWidth = true
        subject.textAlignment = .center
        
        self.addSubview(subject)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
