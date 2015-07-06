//
//  Helper.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 6/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import Foundation


func stringDateToDate(stringDate: String) -> String {
    
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    if let date = formatter.dateFromString(stringDate) {
        formatter.dateFormat = "dd MMM"
        let dateString = formatter.stringFromDate(date)
        
        return dateString
    }
    else {
        return ""
    }
}