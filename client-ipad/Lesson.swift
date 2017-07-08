//
//  Lesson.swift
//  client-ipad
//
//  Created by Alexandre Page on 08/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Lesson: NSObject, NSCoding {
    
    var id: Int
    var subjectId: Int
    var reservationId: Int
    var studentClassId: Int
    var start: String
    var end: String
    
    
    init(id: Int, subjectId: Int, reservationId: Int, studentClassId: Int, start: String, end: String) {
        self.id = id
        self.subjectId = subjectId
        self.reservationId = reservationId
        self.studentClassId = studentClassId
        self.start = start
        self.end = end
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let subjectId = aDecoder.decodeInteger(forKey: "subjectId")
        let reservationId = aDecoder.decodeInteger(forKey: "reservationId")
        let studentClassId = aDecoder.decodeInteger(forKey: "studentClassId")
        let start = aDecoder.decodeObject(forKey: "start") as! String
        let end = aDecoder.decodeObject(forKey: "end") as! String
        self.init(id: id, subjectId: subjectId, reservationId: reservationId, studentClassId: studentClassId, start: start, end: end)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(subjectId, forKey: "subjectId")
        aCoder.encode(reservationId, forKey: "reservationId")
        aCoder.encode(studentClassId, forKey: "studentClassId")
        aCoder.encode(start, forKey: "start")
        aCoder.encode(end, forKey: "end")
    }
}
