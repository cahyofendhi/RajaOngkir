//
//  ApiService.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation
import Alamofire

class API {
    static let apiKey = Constan.API_KEY
    static let baseUrl = Constan.BASE_URL
    
    enum Endpoint {
        case province
        case city
        case cost
        
        var endpoint: String {
            switch self {
            case .province:
                return "province"
            case .city:
                return "city"
            case .cost:
                return "cost"
          }
        }
    }
    
    static func createUrl(endpoint: Endpoint) -> String {
        return "\(API.baseUrl)\(endpoint.endpoint)"
    }
    
    static func requestHeader() -> HTTPHeaders {
        return ["key": Constan.API_KEY,
                "Content-Type": "application/x-www-form-urlencoded",]
    }
    
}
