//
//  FirestoreService.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 15/03/26.
//

import Foundation
import Observation

import FirebaseCore
import FirebaseFirestore

@Observable
@MainActor
final class RemoteDatabase {
    private let firestore = Firestore.firestore()

    func getAvailableYears() -> [String] {
        return ["TODO"]
    }

    func getCelebrations(of year: String) async throws -> Year? {
        let document = try await firestore.document("years/\(year)").getDocument(as: FirestoreDocument.self)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(Year.self, from: document.json)

        print("Fetched document \(result)")
        return result
    }
}

struct FirestoreDocument: Decodable {
    let json: String
}
