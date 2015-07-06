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
        let price = fare["@farePrice"].string ?? ""
        let fareDate = fare["@outboundDate"].string ?? ""
        
        
        dateLabel.text = stringDateToDate(fareDate)
        priceLabel.text = "$" + price
    }
}
