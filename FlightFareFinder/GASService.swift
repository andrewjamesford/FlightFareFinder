//
//  GASService.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 2/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import Alamofire

struct GASService {

    private static let baseURL = getConfigProperty("BaseURL")
    
    enum ResourcePath: CustomStringConvertible {
        case SmokingSpecials
        case LowList
        case Specials
        case Prices(origin: String, destination: String)
        
        var description: String {
            switch self {
            case .SmokingSpecials: return "/getSmokingSpecials.json?json"
            case .Prices(let origin, let destination): return "/getPrices?origin=\(origin)&destination=\(destination)&json=y"
            case .LowList: return "/getLowList.json"
            case .Specials: return "/getSpecials.json"
            }
        }
    }
}
