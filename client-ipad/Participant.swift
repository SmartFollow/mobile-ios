//
//  Participant.swift
//  client-ipad
//
//  Created by Alexandre Page on 16/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Participant: NSObject {
  let id: Int
  let email: String
  let firstName: String
  
  init(id: Int, email: String, firstName: String) {
    self.id = id
    self.email = email
    self.firstName = firstName
  }
}
