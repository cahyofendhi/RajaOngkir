//
//  ApiRepository.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation
import Alamofire

class ApiRepository {
    
    static var instance = ApiRepository()
    
    func getProvince(result: @escaping(_ data: Province) -> ()) {
        let apiUrl = API.createUrl(endpoint: .province)
        print("URL \(apiUrl)")
        APIManager.getFrom(apiUrl,
                           method: .get,
                           parameters: [ : ],
                           encoding: URLEncoding.default,
                           headers: API.requestHeader(),
                           completion: { data in
                            
                        let province = try? JSONDecoder().decode(Province.self, from: data)
                        result(province!)
                            
        },
                           failure: { error in
                        print("Error \(error)")
        })
    }
    
    func getCity(provId: String, result: @escaping(_ data: City) -> ()) {
        let apiUrl = API.createUrl(endpoint: .city)
        print("URL \(apiUrl)")
        let parameter: Parameters = ["province" : provId]
        APIManager.getFrom(apiUrl,
                           method: .get,
                           parameters: parameter,
                           encoding: URLEncoding.default,
                           headers: API.requestHeader(),
                           completion: { data in
                            
                            let city = try? JSONDecoder().decode(City.self, from: data)
                            result(city!)
                            
        },
                           failure: { error in
                            print("Error \(error)")
        })
    }
    
    func postCost(originId: String,
                  destinationId : String,
                  weight: String,
                  courier: String,
                  result: @escaping(_ data: CostOngkir) -> (),
                  errorMessage: @escaping(_ error: String) -> ()) {
        
        let apiUrl = API.createUrl(endpoint: .cost)
        print("URL \(apiUrl)")
        print("Param \(originId) - \(destinationId) - \(weight) - \(courier)")
        let parameter: Parameters = ["origin" : originId,
                                     "destination" : destinationId,
                                     "weight" : weight,
                                     "courier" : courier]
        APIManager.getFrom(apiUrl,
                           method: .post,
                           parameters: parameter,
                           encoding: URLEncoding.default,
                           headers: API.requestHeader(),
                           completion: { data in
                            
                            let cost = try? JSONDecoder().decode(CostOngkir.self, from: data)
                            result(cost!)
                            
        },
                           failure: { error in
                            errorMessage(error)
                            print("Error \(error)")
        })
    }
    
}
