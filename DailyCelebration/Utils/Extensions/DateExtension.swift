//
//  DateExtension.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 13/02/26.
//

import Foundation

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// Returns a Date without Time and Timezone information.
    var ddMMMyyyy: String {
        let dateFormatter = DateFormatter()

        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: self)
    }
}
