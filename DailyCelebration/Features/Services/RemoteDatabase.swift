//
//  FirestoreService.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 15/03/26.
//

import Foundation
import Observation
import SwiftUI

import FirebaseCore
import FirebaseFirestore

@Observable
@MainActor
final class RemoteDatabase {
    private let firestore = Firestore.firestore()

    func getAvailableYears() -> [String] {
        return ["TODO"]
    }

    func getCelebrations(of year: String) async throws -> Year {
        print("Getting year: \(year)")
        
        let document = try await firestore.document("years/\(year)").getDocument(as: FirestoreDocument.self)

        guard !document.json.isEmpty else {
            throw NSError(domain: "RemoteDatabase", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty JSON for year \(year)"])
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = Data(document.json.utf8)
        let result = try decoder.decode(Year.self, from: data)

        print("Fetched document \(result)")
        return result
    }
}

struct FirestoreDocument: Decodable {
    let json: String
}


/// Creates Environment key nad its value
private struct RemoteDatabaseKey: EnvironmentKey {
    static let defaultValue: RemoteDatabase = .init()
}

/// Adds key to environment values
extension EnvironmentValues {
    var remoteDatabase: RemoteDatabase {
        get { self[RemoteDatabaseKey.self] }
        set { self[RemoteDatabaseKey.self] = newValue }
    }
}
