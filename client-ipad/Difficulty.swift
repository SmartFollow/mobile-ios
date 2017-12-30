//
//  Difficulty.swift
//  client-ipad
//
//  Created by Alexandre Page on 26/12/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation

class Difficulty: NSObject {
  
  let id: Int
  let week: String
  let year: String
  
  init(id: Int, week: String, year: String) {
    self.id = id
    self.week = week
    self.year = year
  }
}
