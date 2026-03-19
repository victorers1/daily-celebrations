//
//  DayDetailsViewModel.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 12/03/26.
//

import Combine
import Foundation

@MainActor
class DayDetailsViewModel: ObservableObject {
    
    private let allDays: [Day]
    @Published var dayIndex: Int
    let planner = CelebrationPlanner()
    
    var day: Day {
        allDays[dayIndex]
    }

    init(allDays: [Day], initialDayIndex: Int) {
        self.allDays = allDays
        dayIndex = initialDayIndex
    }
    

    func suggestItinerary() async throws {
        try await planner.suggestItinerary(for: day)
    }

    func incrementDay() async throws {
        dayIndex += 1
        try await suggestItinerary()
    }

    func decrementDay() async throws {
        dayIndex -= 1
        try await suggestItinerary()
    }
}
