//
//  NotificationScheduler.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/28/20.
//

import UserNotifications

class NotificationScheduler {

    func scheduleNotifications(for medication: Medication) {
        guard let timeOfDay = medication.timeOfDay,
              let identifier = medication.id?.uuidString
        else { return }

        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "It's time to take your \(medication.name ?? "medication")"
        content.sound = .default

        let fireDateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeOfDay)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notification request, \(error.localizedDescription)")
            }
        }
    }

    func clearNotifications(for medication: Medication) {
        guard let identifier = medication.id?.uuidString
        else { return }

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }

}
