//
//  HTTPClient.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 27/04/26.
//

import Foundation
import SwiftUI

struct HTTPClient {
    
}


/// Declares Environment key and its value
private struct HTTPClientKey: EnvironmentKey {
    static let defaultValue: HTTPClient = HTTPClient()
}

/// Adds key to environment values
extension EnvironmentValues {
    var httpClient: HTTPClient {
        get { self[HTTPClientKey.self] }
        set { self[HTTPClientKey.self] = newValue }
    }
}
