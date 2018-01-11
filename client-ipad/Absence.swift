//
//  Absence.swift
//  client-ipad
//
//  Created by Alexandre Page on 23/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Absence: NSObject {
  let id: Int
  let evaluationId: Int
  let justifiedAt: Date?
  
  init(id: Int, evaluationId: Int, justifiedAt: Date? = nil) {
    self.id = id
    self.evaluationId = evaluationId
    self.justifiedAt = justifiedAt
  }
}
