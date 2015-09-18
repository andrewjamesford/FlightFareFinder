//
//  AppDelegate.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 20/06/15.
//  Copyright (c) 2015 Andrew Ford. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Fabric
import Crashlytics


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
        
        UITabBar.appearance().tintColor = getAppColor()
        UINavigationBar.appearance().tintColor = getAppColor()
        UISegmentedControl.appearance().tintColor = getAppColor()
        UITableView.appearance().tintColor = getAppColor()
        UISwitch.appearance().onTintColor = getAppColor()
        UIRefreshControl.appearance().tintColor = getAppColor()
        
        
        Fabric.with([Crashlytics()])

        
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
        let userSettings = UserService.loadUserSettings()
        var bNotificationSent = false
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        print("performFetch")

        let baseURL = getConfigProperty("BaseURL")
        let urlString = baseURL + GASService.ResourcePath.Prices(origin: userSettings.origin!, destination: userSettings.destination!).description
        print("urlstring=" + urlString)
        
        // Do call to get fares
        Alamofire.request(.GET, urlString)
            .responseJSON { request, response, result in
                print(result)
                debugPrint(result)
                
                switch result {
                case .Success(let data):
                    let json = JSON(data)
                    fares = json["PriceAvailability"]
                    if (fares != nil) {
                        let prevJson = userDefaults.objectForKey("prevJson") as? String
                        
                        if (prevJson != fares.stringValue) {
                            print("No match")
                            
                            for (_, subJson) in json["PriceAvailability"] {
                                let price: String = subJson["@farePrice"].string ?? ""
                                let priceInt: Int? = Int(price)
                                let fareDate = subJson["@outboundDate"].string ?? ""
                                let dateFormatter = NSDateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                let fareDateFormatted = dateFormatter.dateFromString(fareDate)
        
                                if ((userSettings.notificationsEnabled) &&
                                    (priceInt < userSettings.alertAmount) &&
                                    (userSettings.dateFrom!.timeIntervalSinceDate(fareDateFormatted!).isSignMinus)) {
        
                                    if (!bNotificationSent) {
        
                                        print("add Notification")
                                        print(price)
                                        // Call FareNotifications.addNotification
                                        FareNotifications.sharedInstance.addNotification("Flight fares availble for $" + price, title: "Flight for " + fareDate)
                                        bNotificationSent = true
                                        
                                    }
                                }
                            }
                            
                            if (bNotificationSent) {
                                print("set prev JSON")
                                userDefaults.setValue(fares.stringValue, forKey: "prevJson")
                            }
                        }
                    }
                    
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                }
        }
        
        
//        GASService.getPrices(userSettings.origin!, destination: userSettings.destination!) { (JSON) -> () in fares = JSON["PriceAvailability"]
//            
//            if (fares != nil) {
//                let prevJson = userDefaults.objectForKey("prevJson") as? String
//                
//                if (prevJson != fares.stringValue) {
//                    
//                    print("No match")
//                    for (_, subJson) in JSON["PriceAvailability"] {
//                        let price: String = subJson["@farePrice"].string ?? ""
//                        let priceInt: Int? = Int(price)
//                        let fareDate = subJson["@outboundDate"].string ?? ""
//                        let dateFormatter = NSDateFormatter()
//                        dateFormatter.dateFormat = "yyyy-MM-dd"
//                        let fareDateFormatted = dateFormatter.dateFromString(fareDate)
//                        
//                        if ((userSettings.notificationsEnabled) &&
//                            (priceInt < userSettings.alertAmount) &&
//                            (userSettings.dateFrom!.timeIntervalSinceDate(fareDateFormatted!).isSignMinus)) {
//
//                            if (!bNotificationSent) {
//                                
//                                print("add Notification")
//                                print(price)
//                                // Call FareNotifications.addNotification
//                                FareNotifications.sharedInstance.addNotification("Flight fares availble for $" + price, title: "Flight for " + fareDate)
//                                bNotificationSent = true
//                                
//                            }
//                        }
//                    }
//                    
//                    if (bNotificationSent) {
//                        print("set prev JSON")
//                        userDefaults.setValue(fares.stringValue, forKey: "prevJson")
//                    }
//                }
//                
//            }
//        }
        
        completionHandler(UIBackgroundFetchResult.NewData)
    }
}

