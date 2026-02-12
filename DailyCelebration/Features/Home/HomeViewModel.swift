//
//  HomeViewModel.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Foundation

class HomeViewModel {
    var years: [Year] = []

    init() {
        decodeYears()
    }

    func decodeYears() {
        if let url = Bundle.main.url(forResource: "2026", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let year = try decoder.decode(Year.self, from: data)
                years.append(year)

                print("years: \(years)")

            } catch {
                print("Error decoding JSON data: \(error)")
            }
        } else {
            print("URL not found")
        }
    }
}
