//
//  Notifications.swift
//  GemBetApp
//
//  Created by user on 23.03.2021.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
  
  let notificationCenter = UNUserNotificationCenter.current()

  
  // user notifi autorization
  func requestAutorization() {
    notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { [unowned self] (granted, error) in
      print("Permission graned: \(granted)")
      guard granted else { return }
      self.getNotificationSettings()
    }
  }
  
  func getNotificationSettings() {
    notificationCenter.getNotificationSettings { (settings) in
      print(settings)
    }
  }
  
  func scheduleNotification(notificationTitle: String) {
    let content = UNMutableNotificationContent()
    content.title = notificationTitle
    content.body = "It is test notification"
    content.sound = UNNotificationSound.default
    content.badge = 1
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    let identifire = "Test local notification"
    let request = UNNotificationRequest(identifier: identifire, content: content, trigger: trigger)
    notificationCenter.add(request) { (error) in
      if let error = error {
        print(error)
      }
    }
  }
  
  // UNUserNotificationCenterDelegate
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.sound, .banner])
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    if response.notification.request.identifier == "Test local notification" {
      //например открыть URL
    }
    completionHandler()
  }
}
