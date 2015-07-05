//
//  FaresModel.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 22/06/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import Foundation

class FareModel: NSObject {
    let destination: String
    let origin: String
    let lowestPrice: Int
    let outboundDate: String
    
    
    
    
    init(destination: String?, origin: String?, lowestPrice: Int?, outboundDate: String?) {
        self.destination = destination ?? ""
        self.origin = origin ?? ""
        self.lowestPrice = lowestPrice ?? 0
        self.outboundDate = outboundDate ?? ""
    }
}