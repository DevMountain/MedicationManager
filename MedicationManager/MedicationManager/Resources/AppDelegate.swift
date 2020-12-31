//
//  AppDelegate.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/20/20.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { authorized, error in
            if let error = error {
                print("There was an error requesting authorization to use notifications. Error: \(error)")
            }

            if authorized {
                UNUserNotificationCenter.current().delegate = self
                self.setNotificationCategories()
                print("✅ The user authorized notifications.")
            } else {
                print("🛑 The user declined the use of notifications")
            }
        }

        return true
    }

    private func setNotificationCategories() {
        let markTakenAction = UNNotificationAction(identifier: Strings.markTakenNotificationActionIdentifier,
                                                   title: Strings.accept,
                                                   options: UNNotificationActionOptions(rawValue: 0))
        let ignoreAction = UNNotificationAction(identifier: Strings.ignoreNotificationActionIdentifier,
                                                title: Strings.ignore,
                                                options: UNNotificationActionOptions(rawValue: 0))

        let meetingInviteCategory =
            UNNotificationCategory(identifier: Strings.notificationCategoryIdentifier,
                                   actions: [markTakenAction, ignoreAction],
                                   intentIdentifiers: [],
                                   hiddenPreviewsBodyPlaceholder: "",
                                   options: .customDismissAction)

        UNUserNotificationCenter.current().setNotificationCategories([meetingInviteCategory])
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == Strings.markTakenNotificationActionIdentifier,
           let medicationID = response.notification.request.content.userInfo[Strings.medicationID] as? String {
            MedicationController.shared.markMedicationAsTaken(withID: medicationID)
            completionHandler()
        }
    }

}
