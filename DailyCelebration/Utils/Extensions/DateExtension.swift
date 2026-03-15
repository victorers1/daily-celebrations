//
//  DateExtension.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 13/02/26.
//

import Foundation

extension Date {
    var dateComponents: DateComponents {
        return Calendar(identifier: .gregorian)
            .dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: self)
    }

    var year: Int {
        return dateComponents.year ?? 0
    }

    var month: Int {
        return dateComponents.month ?? 0
    }

    var day: Int {
        return dateComponents.day ?? 0
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

    var ddMMM: String {
        return ddMMMyyyy.replacingOccurrences(of: "\(year)", with: "")
            .trimmingCharacters(in: [" "])
    }
}
