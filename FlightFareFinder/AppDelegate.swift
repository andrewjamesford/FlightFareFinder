//
//  AppDelegate.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 20/06/15.
//  Copyright (c) 2015 Andrew Ford. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        let types = UIUserNotificationType([UIUserNotificationType.Alert, UIUserNotificationType.Sound, UIUserNotificationType.Badge])
        let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        application.registerUserNotificationSettings(settings)

        UIScrollView.appearance().backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        var fares: JSON! = []
        var orig: String = "TRG"
        var dest: String = "AKL"
        var alertAmount = 0
        var dateFrom: NSDate?
        var notificationsEnabled = false
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if ((userDefaults.objectForKey("orig") as? String) != nil)
        {
            orig = (userDefaults.objectForKey("orig") as? String)!
            print(orig)
        }
        if ((userDefaults.objectForKey("dest") as? String) != nil)
        {
            dest = (userDefaults.objectForKey("dest") as? String)!
            print(dest)
        }
        if ((userDefaults.objectForKey("alertAmount") as? NSInteger) != nil)
        {
            alertAmount = (userDefaults.objectForKey("alertAmount") as? NSInteger)!
            print(alertAmount)
        }
        if ((userDefaults.objectForKey("notificationsEnabled") as? Bool) != nil)
        {
            notificationsEnabled = (userDefaults.objectForKey("notificationsEnabled") as? Bool)!
        }
        if ((userDefaults.objectForKey("dateFrom") as? NSDate) != nil)
        {
            dateFrom = (userDefaults.objectForKey("dateFrom") as? NSDate)!
        }
        
        let dateNow = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if (notificationsEnabled) {
            // Do call to get fares
            GASService.getPrices(orig, destination: dest) { (JSON) -> () in
                fares = JSON["PriceAvailability"]
                if (fares != nil) {
                    for (key, subJson) in JSON["PriceAvailability"] {
                        if let farePrice = subJson["@farePrice"].int {
                            let sFarePrice = subJson["@outboundDate"].string
                            let fareDate = dateFormatter.dateFromString(sFarePrice!)
                            
                            // Check matches NSUserDefaults settings
                            if ((farePrice < alertAmount) && (fareDate!.timeIntervalSinceDate(dateFrom!).isSignMinus)) {
                                
                                // Call FareNotifications.addNotification                            
                                FareNotifications.sharedInstance.addNotification("body", title: "my title")
                            }
                        }
                    }
                }
            }
        }
        
        
        completionHandler(UIBackgroundFetchResult.NewData)
        
        //completionHandler(UIBackgroundFetchResult.Failed)

    }
}

