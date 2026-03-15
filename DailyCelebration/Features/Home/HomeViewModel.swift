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

    func decodeYear() {
        if let url = Bundle.main.url(forResource: "2026", withExtension: "json") {
            do {
                isLoading = true
                
                Thread.sleep(forTimeInterval: 3)

                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                year = try decoder
                    .decode(Year.self, from: data)

                print("current year: \(String(describing: year))")
                isLoading = false
            } catch {
                print("Error decoding JSON data: \(error)")
                isLoading = false
            }
        } else {
            print("URL not found")
            isLoading = false
        }
    }
}
