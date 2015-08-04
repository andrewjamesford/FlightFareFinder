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
        dateLabel.textColor = UIColor.darkTextColor()
        priceLabel.textColor = UIColor.darkTextColor()
        
        if ((settings.notificationsEnabled) &&
            (priceInt < settings.alertAmount) &&
            (settings.dateFrom!.timeIntervalSinceDate(fareDateFormatted!).isSignMinus)) {
                backgroundColor = getAppColor()
                dateLabel.textColor = UIColor.lightTextColor()
                priceLabel.textColor = UIColor.lightTextColor()

        }
        
        dateLabel.text = stringDateToDate(fareDate, dateType: 1)
        priceLabel.text = "$" + price

    }
}
