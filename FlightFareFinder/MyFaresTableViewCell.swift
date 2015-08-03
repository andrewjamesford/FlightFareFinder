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
        let settings = UserService.loadUserSettings()
        backgroundColor = UIColor.whiteColor()
        
        if ((settings.notificationsEnabled) &&
            (priceInt < settings.alertAmount) &&
            (settings.dateFrom!.timeIntervalSinceDate(fareDateFormatted!).isSignMinus)) {
            backgroundColor = UIColor(red:0.96, green:0.16, blue:0.34, alpha:0.2)
        }
        
        dateLabel.text = stringDateToDate(fareDate, dateType: 1)
        priceLabel.text = "$" + price

    }
}
