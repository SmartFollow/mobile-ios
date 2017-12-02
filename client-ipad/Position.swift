//
//  Enum.swift
//  client-ipad
//
//  Created by Alexandre Page on 13/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

enum Position : Int {
  case Left
  case Middle
  case Right
  
  static postfix func ++(state: inout Position) {
    if let newValue = Position(rawValue: state.rawValue + 1) {
      state = newValue
    } else {
      state = .Left
    }
  }
}
