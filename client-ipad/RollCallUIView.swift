//
//  RollCallUIView.swift
//  client-ipad
//
//  Created by Alexandre Page on 22/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class RollCallUIView: UIView {
    
    required init(frame: CGRect, student: Student) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        
        let button = RollCallButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200), student: student)
        let studentName = UILabel(frame: CGRect(x: 0, y: button.frame.size.height + 10, width: 200, height: 25))
        studentName.text = "\(student.firstName!) \(student.lastName!)"
        studentName.textAlignment = .center
        studentName.textColor = UIColor.white
        self.addSubview(studentName)
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
