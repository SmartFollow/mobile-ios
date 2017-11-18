//
//  User.swift
//  client-ipad
//
//  Created by Alexandre Page on 17/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class User: NSObject {
  
  let email: String
  let firstName: String
  let lastName: String
  let avatar: UIImage
  
  init(email: String, firstName: String, lastName: String, avatarUrl: String) {
    self.email = email
    self.firstName = firstName
    self.lastName = lastName
    self.avatar = UIImage(link: ConnectionSettings.apiBaseUrl + avatarUrl)
  }
  
}
