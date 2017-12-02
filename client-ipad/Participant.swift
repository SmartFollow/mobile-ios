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
  let picture: UIImage
  
  init(id: Int, email: String, firstName: String, avatarUrl: String) {
    self.id = id
    self.email = email
    self.firstName = firstName
    self.picture = UIImage(link: ConnectionSettings.apiBaseUrl + avatarUrl)
  }
}
