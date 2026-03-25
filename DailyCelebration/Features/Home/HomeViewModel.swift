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

            let response = try await db.getCelebrations(of: year)

            appState.allDays = response.allDays(indexed: true)

            appState.year = try Year(from: appState.allDays)

            appState.visibleYear = appState.year

            print("got year: \(appState.year)")
            isLoading = false
        } catch {
            print("Error getting year: \(error)")
            isLoading = false
        }
    }
}
