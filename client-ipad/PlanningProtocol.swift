//
//  PlanningProtocol.swift
//  client-ipad
//
//  Created by Alexandre Page on 11/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation

protocol Planning {
  var timeStart: Date { get }
  var timeEnd: Date { get set }
  var hourStart: Double { get set }
  var hourEnd: Double { get set }
  var minuteStart: Double { get set }
  var minuteEnd: Double { get set }
  var subjectName: String { get }
  var roomIdentifier: String { get }
}
