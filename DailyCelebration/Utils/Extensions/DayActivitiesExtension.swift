//
//  DayActivitiesExtension.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 13/03/26.
//

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
                title: "Convidative title for an event #3",
                description: "You deserve to do this activity."
            )],
    )
}
