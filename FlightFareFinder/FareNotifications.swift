//
//  FareNotifications.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 20/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import Foundation
import UIKit

class FareNotifications {
    class var sharedInstance : FareNotifications {
        struct Static {
            static let instance : FareNotifications = FareNotifications()
        }
        return Static.instance
    }
    
    func addNotification(body: String, title: String) {
        
        // create a corresponding local notification
        let notification = UILocalNotification()
        
        UIApplication.sharedApplication().cancelLocalNotification(notification)
        
        notification.alertBody = body // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = NSDate() // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": title] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "FARE_NOTIFY"
        notification.applicationIconBadgeNumber = 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)

        self.setBadgeNumbers(1)
        
    }
    
    func setBadgeNumbers(badgeNumber: Int) {
        
        //var notifications = UIApplication.sharedApplication().scheduledLocalNotifications as [UILocalNotification]! // all scheduled notifications
        print("Set badge number")
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = badgeNumber
    }
    
}