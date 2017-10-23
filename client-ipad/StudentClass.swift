//
//  StudentClass.swift
//  client-ipad
//
//  Created by Alexandre Page on 16/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation

class StudentClass: NSObject {
    public var students = [Student]()
    
    init(students: [Student]) {
        self.students = students
    }
    
    override init() {
    }

}
