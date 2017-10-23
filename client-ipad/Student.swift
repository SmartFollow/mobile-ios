//
//  Student.swift
//  client-ipad
//
//  Created by Alexandre Page on 16/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation

class Student: NSObject {
    
    let id: Int!
    let email: String!
    let firstName: String!
    let lastName: String!
    let classId: Int!
    let groupId: Int!
    
    
    init(id: Int, email: String, firstName: String, lastName: String, classId: Int, groupId: Int) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.classId = classId
        self.groupId = groupId
    }
    
    override init() {
        self.id = nil
        self.email = nil
        self.firstName = nil
        self.lastName = nil
        self.classId = nil
        self.groupId = nil
    }
}
