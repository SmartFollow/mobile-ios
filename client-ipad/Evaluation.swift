//
//  Evaluation.swift
//  client-ipad
//
//  Created by Alexandre Page on 22/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation

class Evaluation: NSObject {
    
    let id: Int
    let studentId: Int
    let lessonId: Int
    let comment: String?
    
    
    init(id: Int, studentId: Int, lessonId: Int, comment: String? = nil) {
        self.id = id
        self.studentId = studentId
        self.lessonId = lessonId
        self.comment = comment
    }

}
