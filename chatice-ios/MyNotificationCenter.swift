//
//  NotificationCenter.swift
//  chatice-ios
//
//  Created by admin on 3/6/22.
//

import Foundation
import UserNotifications


class MyNotificationCenter {
    var isGranted: Bool = false
    let center = UNUserNotificationCenter.current()
    
    func askAndLoadPermission() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if let e = error {
                print("There was an issue getting notification request. \(e)")
            } else {
                if granted {
                    self.isGranted = true
                } else {
                    self.isGranted = false
                }
            }
        }
    }
    
    
    
    func loadPermissionStatus() {
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                
            } else {
                
            }
        }
    }
}
