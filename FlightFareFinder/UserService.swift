//
//  UserSettings.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 31/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import Foundation


struct UserService {

    static func loadUserSettings() -> (origin: String?, destination: String?, alertAmount: NSInteger, dateFrom: NSDate?, notificationsEnabled: Bool)
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        var orig: String?
        var dest: String?
        var amount = 0
        var from: NSDate?
        var notify = false
        
        if ((userDefaults.objectForKey("orig") as? String) != nil)
        {
            orig = (userDefaults.objectForKey("orig") as? String)!
        }
        else {
            orig = "TRG"
        }
        if ((userDefaults.objectForKey("dest") as? String) != nil)
        {
            dest = (userDefaults.objectForKey("dest") as? String)!
        }
        else {
            dest = "AKL"
        }
        if ((userDefaults.objectForKey("alertAmount") as? NSInteger) != nil)
        {
            amount = (userDefaults.objectForKey("alertAmount") as? NSInteger)!
        }
        if ((userDefaults.objectForKey("dateFrom") as? NSDate) != nil)
        {
            from = (userDefaults.objectForKey("dateFrom") as? NSDate)!
        }
        if ((userDefaults.objectForKey("notificationsEnabled") as? Bool) != nil)
        {
            notify = (userDefaults.objectForKey("notificationsEnabled") as? Bool)!
        }
        
        return (orig, dest, amount, from, notify)
    }

    static func setUserSettings(origin: String?, destination: String?, alertAmount: NSInteger?, dateFrom: NSDate?, notificationsEnabled: Bool?) {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if (origin != nil) {
            userDefaults.setValue(origin, forKey: "orig")
        }
        if (destination != nil) {
            userDefaults.setValue(destination, forKey: "dest")
        }
        if (alertAmount != nil) {
            userDefaults.setValue(alertAmount, forKey: "alertAmount")
        }
        if (dateFrom != nil) {
            userDefaults.setValue(dateFrom, forKey: "dateFrom")
        }
        if (notificationsEnabled != nil) {
            userDefaults.setValue(notificationsEnabled, forKey: "notificationsEnabled")
        }
    }
}