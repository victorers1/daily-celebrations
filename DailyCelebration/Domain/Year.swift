//
//  Year.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Foundation

struct Year: Decodable, CustomStringConvertible, Identifiable {
    let id: Int
    let jan: [Day]
    let feb: [Day]
    let may: [Day]
    let apr: [Day]
    let mar: [Day]
    let jun: [Day]
    let jul: [Day]
    let aug: [Day]
    let sep: [Day]
    let oct: [Day]
    let nov: [Day]
    let dec: [Day]

    init(id: Int, jan: [Day], feb: [Day], may: [Day], apr: [Day], mar: [Day], jun: [Day], jul: [Day], aug: [Day], sep: [Day], oct: [Day], nov: [Day], dec: [Day]) {
        self.id = id
        self.jan = jan
        self.feb = feb
        self.may = may
        self.apr = apr
        self.mar = mar
        self.jun = jun
        self.jul = jul
        self.aug = aug
        self.sep = sep
        self.oct = oct
        self.nov = nov
        self.dec = dec
    }

    init(from days: [Day]) throws {
        id = days.first?.date.year ?? 0

        var monthsMap: [Int: [Day]] = [1: [], 2: [], 3: [], 4: [], 5: [], 6: [], 7: [], 8: [], 9: [], 10: [], 11: [], 12: []]

        days.forEach { day in
            let month = day.date.month
            monthsMap[month]?.append(day)
        }

        jan = monthsMap[1] ?? []
        feb = monthsMap[2] ?? []
        may = monthsMap[3] ?? []
        apr = monthsMap[4] ?? []
        mar = monthsMap[5] ?? []
        jun = monthsMap[6] ?? []
        jul = monthsMap[7] ?? []
        aug = monthsMap[8] ?? []
        sep = monthsMap[9] ?? []
        oct = monthsMap[10] ?? []
        nov = monthsMap[11] ?? []
        dec = monthsMap[12] ?? []
    }

    func getMonths() -> [[String: [Day]]] {
        return [
            ["January": jan],
            ["February": feb],
            ["May": may],
            ["April": apr],
            ["March": mar],
            ["June": jun],
            ["July": jul],
            ["August": aug],
            ["September": sep],
            ["October": oct],
            ["November": nov],
            ["December": dec],
        ]
    }

    static func empty() -> Year {
        Year(
            id: Date().year,
            jan: [],
            feb: [],
            may: [],
            apr: [],
            mar: [],
            jun: [],
            jul: [],
            aug: [],
            sep: [],
            oct: [],
            nov: [],
            dec: [],
        )
    }

    func allDays(indexed: Bool = false) -> [Day] {
        let months = [
            jan, feb, may, apr, mar, jun, jul, aug, sep, oct, nov, dec,
        ]
        var allDays: [Day] = []
        months.forEach { daysOfMonth in
            allDays.append(contentsOf: daysOfMonth)
        }

        return indexed ? allDays.enumerated().map { offset, day in
            Day(id: offset, date: day.date, events: day.events)
        } : allDays
    }

    var description: String {
        return "\(id)"
    }
}
