//
//  Message.swift
//  client-ipad
//
//  Created by Alexandre Page on 21/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Message: NSObject {
  
  let text: String
  let date: Date
  let creatorId: Int
  let formatter = DateFormatter()
  
  init(content: String, date: String, creatorId: Int) {
    self.text = content
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    self.date = formatter.date(from: date)!
    self.creatorId = creatorId
  }
  
  
  
  
}
