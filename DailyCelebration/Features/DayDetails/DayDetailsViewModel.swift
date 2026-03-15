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
    
    @Published var day: Day
    @Published var planner: CelebrationPlanner
    
    init (initialDay: Day) {
        self.day = initialDay
        self.planner = CelebrationPlanner(day: initialDay)
    }
    
    func suggestItinerary() async  throws {
        try await planner.suggestItinerary()
    }
}
