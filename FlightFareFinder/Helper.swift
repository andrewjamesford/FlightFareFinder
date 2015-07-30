//
//  Helper.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 6/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import Foundation


func stringDateToDate(stringDate: String, dateType: Int32) -> String {
    
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    if let date = formatter.dateFromString(stringDate) {
        if (dateType == 1) {
            formatter.dateFormat = "EEEE, d MMM"
        }
        else {
            formatter.dateFormat = "d MMM"
        }

        let dateString = formatter.stringFromDate(date)
        
        return dateString
    }
    else {
        return ""
    }
}


func getConfigProperty(configItem: String) -> String {
    
    var myDict: NSDictionary?
    if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist") {
        myDict = NSDictionary(contentsOfFile: path)
    }
    if let dict = myDict {
        // Use your dict here
        let stringValue = (dict[configItem] as! String)
        return stringValue
    }
    else {
        return ""
    }
}
