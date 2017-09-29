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
    
    init(id: Int, roomId: Int, timeStart: String, timeEnd: String) {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print("BINGO \(timeStart)")
        self.id = id
        self.roomId = roomId
        self.timeStart = formatter.date(from: timeStart)!
        self.timeEnd = formatter.date(from: timeEnd)!
    }
}
