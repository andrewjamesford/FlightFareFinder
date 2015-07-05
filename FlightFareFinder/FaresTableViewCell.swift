//
//  FaresTableViewCell.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 23/06/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import UIKit

class FaresTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fareLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    
    func configureWithFare(fare: JSON) {
        let price = fare["@price"].string ?? ""
        let destination = fare["@destinationIATACode"].string ?? ""
        let origin = fare["@originIATACode"].string ?? ""
        let currency = fare["@currencySymbol"].string ?? ""
        let seatCount = fare["@seatCount"].string ?? "0"
        let bookFrom = fare["@bookFromDate"].string ?? ""
        let bookTo = fare["@bookToDate"].string ?? ""
        
        
        if (seatCount == "0") {

        }
        
        fareLabel.text = currency + price
        destinationLabel.text = destination
        originLabel.text = origin
        fromLabel.text = bookFrom
        toLabel.text = bookTo
        
    }
}

