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
    private let appState: DailyCelebrationAppViewModel
    @Published var dayIndex: Int
    @Published var scheduledNotification: Bool = false
    let planner = CelebrationPlanner()

    var day: Day {
        appState.allDays[dayIndex]
    }

    init(appState: DailyCelebrationAppViewModel, initialDayIndex: Int) {
        self.appState = appState
        dayIndex = initialDayIndex
    }

    func suggestItinerary() async {
        do {
            planner.deleteItinerary()
            try await planner.suggestItinerary(for: day)
        } catch {
            print("Failed to suggest itinerary: \(error)")
        }
    }

    func incrementDay() async {
        if dayIndex < 365 {
            dayIndex += 1
            await suggestItinerary()
        }
    }

    func decrementDay() async {
        if dayIndex > 0 {
            dayIndex -= 1
            await suggestItinerary()
        }
    }

    func goToToday() async {
        let todayIndex = appState.todayIndex
        if dayIndex != todayIndex {
            dayIndex = todayIndex ?? 0
            await suggestItinerary()
        }
    }

    var isFutureDay: Bool {
        return day.date > Date()
    }
}
