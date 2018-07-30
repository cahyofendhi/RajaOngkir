//
//  CitiesResponse.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation

class City: Codable {
    let rajaongkir: CityRajaongkir
    
    init(rajaongkir: CityRajaongkir) {
        self.rajaongkir = rajaongkir
    }
}

class CityRajaongkir: Codable {
    let query: CityQuery
    let status: Status
    let results: [CityResult]
    
    init(query: CityQuery, status: Status, results: [CityResult]) {
        self.query = query
        self.status = status
        self.results = results
    }
}

class CityQuery: Codable {
    let province: String
    
    init(province: String) {
        self.province = province
    }
}

class CityResult: Codable {
    let cityID, provinceID, province, type: String
    let cityName, postalCode: String
    
    enum CodingKeys: String, CodingKey {
        case cityID = "city_id"
        case provinceID = "province_id"
        case province, type
        case cityName = "city_name"
        case postalCode = "postal_code"
    }
    
    init(cityID: String,
         provinceID: String,
         province: String,
         type: String,
         cityName: String,
         postalCode: String) {
        
        self.cityID = cityID
        self.provinceID = provinceID
        self.province = province
        self.type = type
        self.cityName = cityName
        self.postalCode = postalCode
    }
}

