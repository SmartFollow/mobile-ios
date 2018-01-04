//
//  Delay.swift
//  client-ipad
//
//  Created by Alexandre Page on 23/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//


import UIKit

class Delay: NSObject {
  
  let id: Int
  let arrivedAt: String
  let evaluationId: Int
  
  init(id: Int, evaluationId: Int, arrivedAt: String) {
    self.id = id
    self.arrivedAt = arrivedAt
    self.evaluationId = evaluationId
  }
}
