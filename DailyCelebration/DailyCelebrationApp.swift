//
//  DailyCelebrationApp.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import FirebaseCore
import FoundationModels
import Playgrounds
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct DailyCelebrationApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
