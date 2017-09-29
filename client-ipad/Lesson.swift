//
//  Lesson.swift
//  client-ipad
//
//  Created by Alexandre Page on 08/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Lesson: NSObject {
    
    let id: Int
    let subjectId: Int
    let reservationId: Int
    let studentClassId: Int
    let start: String
    let end: String
    
    
    init(id: Int, subjectId: Int, reservationId: Int, studentClassId: Int, start: String, end: String) {
        self.id = id
        self.subjectId = subjectId
        self.reservationId = reservationId
        self.studentClassId = studentClassId
        self.start = start
        self.end = end
    }
    
}
