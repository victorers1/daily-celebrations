//
//  DailyCelebrationAppViewModel.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 18/03/26.
//

import Combine
import SwiftUI
import Foundation
import Observation

@Observable
/// Global State
class DailyCelebrationAppViewModel {
    var year: Year = Year.empty()
    var visibleYear: Year = Year.empty()

    var allDays: [Day] = []

    // TODO: cache opened days in the global state
    var openedDays: [Day: DayActivities.PartiallyGenerated] = [:]

    var db: RemoteDatabase?
    var notificationService = NotificationService()

    var todayIndex: Int? {
        let index = allDays.firstIndex { day in
            day.date.isEqualsTo(other: Date.now)
        }
        
        return index
    }
    
    func dayIndex(day: Day) -> Int? {
        allDays.firstIndex { d in
            d.date.isEqualsTo(other: day.date)
        }
    }
}

/// Creates environment key and its value
/// TODO: remove
private struct DailyCelebrationAppViewModelKey: EnvironmentKey {
    static var defaultValue: DailyCelebrationAppViewModel = .init()
}

/// Adds key to environment
/// TODO: remove
extension EnvironmentValues {
    var appState: DailyCelebrationAppViewModel {
        get { self[DailyCelebrationAppViewModelKey.self] }
        set { self[DailyCelebrationAppViewModelKey.self] = newValue }
    }
}
