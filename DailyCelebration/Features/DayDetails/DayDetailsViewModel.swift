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
    let planner = CelebrationPlanner()

    var day: Day {
        appState.allDays[dayIndex]
    }

    var todayIndex: Int? {
        return appState.allDays.firstIndex { day in
            return day.date.isEqualsTo(other: Date.now)
        }
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
        dayIndex = todayIndex ?? 0
        await suggestItinerary()
    }
}
