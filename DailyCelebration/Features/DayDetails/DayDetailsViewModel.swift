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
    
    @Published private var day: Day
    @Published private var celebrationPlanner: CelebrationPlanner?
    
    init (initialDay: Day) {
        self.day = initialDay
    }
}
