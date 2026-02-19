//
//  CelebrationPlanner.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 19/02/26.
//

import Foundation
import FoundationModels
import Observation

@Observable
@MainActor
final class CelebrationPlanner {
    private(set) var dayActivities: DayActivities?
    private let session: LanguageModelSession

    let day: Day

    init(day: Day) {
        self.day = day
                
        session = LanguageModelSession {
            // Instructions
            "You job is to create an itinerary so the user."
            Self.userLocaleInstruction()
            "Here is an example:"
            DayActivities.exampleToTheModel
        }
    }

    func suggestItinerary() async throws {
        let response = try await session.respond(generating: DayActivities.self) {
            // Prompt
            "Today is the day of \(day.events.joined(separator: ", ")). Generate a 3 paragraph text talking about today's celebration. Also, generate some activities so the user can celebrate at least on the these events. Events names will be in the user's language."
        }
        
        self.dayActivities = response.content
        
        print("Planner suggested itinerary: \(dayActivities, default: "")")
    }
    
    /// Forces the response to be in the user's language
    static func userLocaleInstruction(for locale: Locale = Locale.current) -> String {
        if Locale.Language(identifier: "en_US").isEquivalent(to: locale.language) {
            // Skip the locale phrase for U.S. English.
            return ""
        } else {
            // Specify the person's locale with the exact phrase format.
            return "The person's locale is \(locale.identifier). You MUST respond in that language."
        }
    }
}

extension DayActivities {
    static let exampleToTheModel = DayActivities(
        description: "On this date, we celebrate [name of day], dedicated to the people who [explanation]. It's also celebrated the [name of day]. It is a day to reflect about [something related to the date].", activities: [
            Activity(
                type: .sightseeing,
                title: "Convidative title for an event #1",
                description: "How about to go out and do this."
            ),

            Activity(
                type: .foodAndDining,
                title: "Convidative title for an event #2",
                description: "Go and do this event. It is free."
            ),

            Activity(
                type: .shopping,
                title: "Convidative name for an event #3",
                description: "You deserve to do this activity."
            )],
    )
}
