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
  var difficulty: [Difficulty]
  var criteria: [Criterion]
  
  init(id: Int, email: String, firstName: String, lastName: String, classId: Int, groupId: Int, evaluation: Evaluation? = nil,
       avatarUrl: String, difficulty: [Difficulty] = [Difficulty](), criteria: [Criterion] = [Criterion]()) {
    self.id = id
    self.email = email
    self.firstName = firstName
    self.lastName = lastName
    self.classId = classId
    self.groupId = groupId
    self.evaluation = evaluation
    self.avatar = UIImage(link: ConnectionSettings.apiBaseUrl + avatarUrl)
    self.difficulty = difficulty
    self.criteria = criteria
  }
  
  public func getCriteria(id: Int) -> Int? {
    if let crit = self.criteria.filter({ $0.id == id }).first {
      return crit.value
    }
    return 0
  }
  
  public func incCriteria(id: Int) {
    let criteria = self.criteria.filter { $0.id == id }.first
    criteria?.value += 1
  }
}
