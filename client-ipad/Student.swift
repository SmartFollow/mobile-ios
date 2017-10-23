//
//  Student.swift
//  client-ipad
//
//  Created by Alexandre Page on 16/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation

class Student: NSObject {
    
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let classId: Int
    let groupId: Int
    var evaluation: Evaluation?
    
    
    init(id: Int, email: String, firstName: String, lastName: String, classId: Int, groupId: Int, evaluation: Evaluation? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.classId = classId
        self.groupId = groupId
        self.evaluation = evaluation
    }

}
