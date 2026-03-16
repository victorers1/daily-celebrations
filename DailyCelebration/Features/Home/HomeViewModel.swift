//
//  HomeViewModel.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Combine
import Foundation

@MainActor // prevents the calling of DispatchQueue.main.async {}
class HomeViewModel: ObservableObject {
    init() {}

    @Published var year: Year = Year.empty()
    @Published var isLoading: Bool = true

    let db = RemoteDatabase()

    func getYear(of year: String) async {
        do {
            isLoading = true

            self.year = try await db.getCelebrations(of: year)

            print("current year: \(self.year)")
            isLoading = false
        } catch {
            print("Error getting year: \(error)")
            isLoading = false
        }
    }

    func changeYear(to year: String) async {
        await getYear(of: year)
    }
}
