//
//  Reservation.swift
//  client-ipad
//
//  Created by Alexandre Page on 28/09/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Reservation: NSObject {
    
    var id: Int
    var roomId: Int
    var timeStart: Date
    var timeEnd: Date
    let formatter = DateFormatter()
    var hourStart: Double
    var hourEnd: Double
    var minuteStart: Double
    var minuteEnd: Double
    
    init(id: Int, roomId: Int, timeStart: String, timeEnd: String) {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.id = id
        self.roomId = roomId
        self.timeStart = formatter.date(from: timeStart)!
        self.timeEnd = formatter.date(from: timeEnd)!
        
        formatter.dateFormat = "HH"
        self.hourStart = Double(formatter.string(from: self.timeStart))!
        self.hourEnd = Double(formatter.string(from: self.timeEnd))!
        
        formatter.dateFormat = "mm"
        self.minuteStart = Double(formatter.string(from: self.timeStart))!
        self.minuteEnd = Double(formatter.string(from: self.timeEnd))!
    }
}
