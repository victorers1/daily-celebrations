//
//  Comemoration.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Foundation

struct Day: Hashable, Decodable {
    let date: Date
    let events: [String]

    private enum CodingKeys: String, CodingKey {
        case date
        case events
    }

    init(date: Date, events: [String]) {
        self.date = date
        self.events = events
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode date as string
        let dateString = try container.decode(String.self, forKey: .date)
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let parsedDate: Date = formatter.date(from: dateString) else {
            fatalError("Invalid date string format: \(dateString)")
        }
        
        self.date = parsedDate

        self.events = try container.decode([String].self, forKey: .events)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
