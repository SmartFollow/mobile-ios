//
//  Criterion.swift
//  client-ipad
//
//  Created by Alexandre Page on 23/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Criterion: NSObject {
  
  let id: Int
  let name: String
  var value: Int
  
  init(id: Int, name: String, value: Int) {
    self.id = id
    self.name = name
    self.value = value
  }
}
