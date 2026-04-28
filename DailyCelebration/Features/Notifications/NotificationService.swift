//
//  NotificationService.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 30/03/26.
//

import UserNotifications

class NotificationService {
    var permissionState: UNAuthorizationStatus?
    var showFeedbackMsg: Bool = false

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in

            UNUserNotificationCenter.current().getNotificationSettings { settings in
                DispatchQueue.main.async {
                    self.permissionState = settings.authorizationStatus
                }
            }

            if granted {
                print("Permission granted")
            } else {
                print("Permission denied")
            }
        }
    }

    func scheduleNotification(for day: Day) -> Bool {
        if permissionState != .authorized {
            requestNotificationPermission()
        }

        guard permissionState == .authorized else { return false }

        let content = UNMutableNotificationContent()
        content.title = "Celebre o dia de hoje"
        content.body = "Hoje é \(day.events.first!)"
        content.sound = .default

        // 👇 Create date for tomorrow at 9 a.m.
        var components = DateComponents()
        components.year = 2026 // calendar.component(.year, from: day.date)
        components.month = 3 // calendar.component(.month, from: day.date)
        components.day = 30 // calendar.component(.day, from: day.date)
        components.hour = 9
        components.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
        
        print("Request: \(request) was scheduled to \(components)")

        return true
    }
}
