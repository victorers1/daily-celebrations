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
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let parsedDate: Date? = formatter.date(from: dateString)
        
        guard let finalDate = parsedDate else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath + [CodingKeys.date],
                    debugDescription: "Invalid date string: \(dateString)"
                )
            )
        }
        self.date = finalDate

        self.events = try container.decode([String].self, forKey: .events)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
