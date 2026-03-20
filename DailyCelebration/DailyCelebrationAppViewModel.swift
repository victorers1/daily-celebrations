//
//  DailyCelebrationAppViewModel.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 18/03/26.
//

import Combine
import Observation

@Observable
class DailyCelebrationAppViewModel { // Global State
    var year: Year = Year.empty()
    var visibleYear: Year = Year.empty()
    
    var allDays: [Day] = []
    
    // TODO: cache opened days in the global state
    var openedDays: [Day: DayActivities.PartiallyGenerated] = [:]

    var db: RemoteDatabase?
}
