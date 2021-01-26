//
//  NotificationManager.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/01/26.
//

import Foundation
import UserNotifications
import BugfenderSDK

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    
    override private init() {}
    
    let notificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    
    func requestForPersmission() {
        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            if (!didAllow) {
                BFLog(K.Notifications.didNotAllowNotificationsLog)
            }
        }
    }
    
    func scheduleNotification(notificationTitle: String, notificationBody: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = notificationTitle
        if !notificationBody.isEmpty {
            content.body = notificationBody
        }
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                BFLog(error.localizedDescription)
            }
        }
    }
    
    // Allow to send notification even in foreground state
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
