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

    var ddMMMyyyy: String {
        return Date.FormatStyle()
            .day(.defaultDigits)
            .month(.abbreviated)
            .year(.defaultDigits)
            .format(self)
    }
}
