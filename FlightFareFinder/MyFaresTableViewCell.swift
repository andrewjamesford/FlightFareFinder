//
//  MyFaresTableViewCell.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 5/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import UIKit


class MyFaresTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureWithMyFare(fare: JSON) {
        let price: String = fare["@farePrice"].string ?? ""
        let priceInt: Int? = Int(price)
        let fareDate = fare["@outboundDate"].string ?? ""
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fareDateFormatted = dateFormatter.dateFromString(fareDate)
        let settings = loadUserSettings()
        backgroundColor = UIColor.whiteColor()
        
        if (settings.notificationsEnabled) {
            print(priceInt)
            print(settings.alertAmount)
            if (priceInt < settings.alertAmount) {
                print(fareDateFormatted)
                print(settings.dateFrom)
                print(fareDateFormatted!.timeIntervalSinceDate(settings.dateFrom!))
                if (fareDateFormatted!.timeIntervalSinceDate(settings.dateFrom!).isSignMinus) {
                    backgroundColor = UIColor(red:0.29, green:0.86, blue:0.37, alpha:0.5)
                }
            }
        }
        
        dateLabel.text = stringDateToDate(fareDate, dateType: 1)
        priceLabel.text = "$" + price

    }
}
