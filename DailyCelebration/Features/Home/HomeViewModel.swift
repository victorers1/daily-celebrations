//
//  HomeViewModel.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Combine
import Foundation
import SwiftUI

@MainActor // prevents the calling of DispatchQueue.main.async {}
class HomeViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    private let appState: DailyCelebrationAppViewModel

    init(appState: DailyCelebrationAppViewModel) {
        self.appState = appState
    }

    func getYear(of year: String) async {
        guard let db = appState.db else { return }
        
        do {
            isLoading = true

            appState.year = try await db.getCelebrations(of: year)

            let months = [
                appState.year.jan,
                appState.year.feb,
                appState.year.mar,
                appState.year.apr,
                appState.year.may,
                appState.year.jun,
                appState.year.jul,
                appState.year.aug,
                appState.year.sep,
                appState.year.oct,
                appState.year.nov,
                appState.year.dec,
            ]

            months.forEach { daysOfMonth in
                appState.allDays.append(contentsOf: daysOfMonth)
            }

            print("current year: \(appState.year)")
            isLoading = false
        } catch {
            print("Error getting year: \(error)")
            isLoading = false
        }
    }
}
