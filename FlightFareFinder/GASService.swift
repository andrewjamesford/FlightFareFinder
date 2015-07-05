//
//  GASService.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 2/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import Alamofire

struct GASService {
    // Doc: http://www.grabaseat.co.nz
    private static let baseURL = "http://grabaseat.co.nz"
    // https://grabaseat.co.nz/getPrices?origin=TRG&destination=AKL&json=y
    // https://grabaseat.co.nz/getSmokingSpecials.json?json
    // http://grabaseat.co.nz/getLowList.json
    // http://grabaseat.co.nz/getSpecials.json
    
    private enum ResourcePath: CustomStringConvertible {
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
    
    
    static func getSpecials(response: (JSON) -> ()) {
        
        let urlString = baseURL + ResourcePath.Specials.description

        Alamofire.request(.GET, URLString: urlString).responseJSON { (_, _, data, _) in
            let specials = JSON(data ?? [])
           
            response(specials)
        }
        
    }
    
    static func getPrices(origin: String, destination: String, response: (JSON) -> ()) {
        
        let urlString = baseURL + ResourcePath.Prices(origin: origin, destination: destination).description

        Alamofire.request(.GET, URLString: urlString).responseJSON { (_, _, data, _) in
            let prices = JSON(data ?? [])
            response(prices)
        }
    }
}
