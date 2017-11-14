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
  
  init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
