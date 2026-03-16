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

    func getYear(of year: String) {
        if let url = Bundle.main.url(forResource: "2026", withExtension: "json") {
            do {
                isLoading = true

                Thread.sleep(forTimeInterval: 3)


                self.year = await db.getCelebrations(of: year)

                print("current year: \(String(describing: year))")
                isLoading = false
            } catch {
                print("Error getting year: \(error)")
                isLoading = false
            }
        } else {
            print("URL not found")
            isLoading = false
        }
    }

    func changeYear(to year: String) {
    }
}
