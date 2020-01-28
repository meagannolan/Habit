//
//  Date+Helper.swift
//  habitApp
//
//  Created by Meagan Nolan on 1/28/20.
//  Copyright © 2020 Meagan Nolan. All rights reserved.
//

import Foundation

extension Date {
    func isIncludedInDates(_ dates: [NSDate]) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let currentDate = dateFormatter.string(from: self)
        let dates = dates.map { dateFormatter.string(from: $0 as Date) }
        return dates.contains(currentDate)
    }
}
