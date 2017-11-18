//
//  Student.swift
//  client-ipad
//
//  Created by Alexandre Page on 16/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Student: NSObject {
  
  let id: Int
  let email: String
  let firstName: String
  let lastName: String
  let classId: Int
  let groupId: Int
  var avatar: UIImage
  var evaluation: Evaluation?
  
  init(id: Int, email: String, firstName: String, lastName: String, classId: Int, groupId: Int, evaluation: Evaluation? = nil,
       avatarUrl: String) {
    self.id = id
    self.email = email
    self.firstName = firstName
    self.lastName = lastName
    self.classId = classId
    self.groupId = groupId
    self.evaluation = evaluation
    self.avatar = UIImage(link: ConnectionSettings.apiBaseUrl + avatarUrl)
  }
}
