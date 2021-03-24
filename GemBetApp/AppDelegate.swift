//
//  AppDelegate.swift
//  GemBetApp
//
//  Created by user on 16.03.2021.
//

import UIKit
import FBSDKCoreKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
    let notifications = Notifications()
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    
    notifications.requestAutorization()
    notifications.notificationCenter.delegate = notifications
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    print("-----------===========-----------")
    UIApplication.shared.applicationIconBadgeNumber = 0
  }
  
  // FB autorisation
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
          
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
      
        return true
    }
          
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
}
