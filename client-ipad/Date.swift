//
//  Date.swift
//  client-ipad
//
//  Created by Alexandre Page on 12/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
}

