//
//  CostResponse.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation

struct CostOngkir: Codable {
    let rajaongkir: CostRajaongkir
}

struct CostRajaongkir: Codable {
    let query: CostQuery
    let status: CostStatus
    let originDetails, destinationDetails: NDetails
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case query, status
        case originDetails = "origin_details"
        case destinationDetails = "destination_details"
        case results
    }
}

struct NDetails: Codable {
    let cityID, provinceID, province, type: String
    let cityName, postalCode: String
    
    enum CodingKeys: String, CodingKey {
        case cityID = "city_id"
        case provinceID = "province_id"
        case province, type
        case cityName = "city_name"
        case postalCode = "postal_code"
    }
}

struct CostQuery: Codable {
    let origin, destination: String
    let weight: Int
    let courier: String
}

struct Result: Codable {
    let code, name: String
    let costs: [ResultCost]
}

struct ResultCost: Codable {
    let service, description: String
    let cost: [CostCost]
}

struct CostCost: Codable {
    let value: Int
    let etd, note: String
}

struct CostStatus: Codable {
    let code: Int
    let description: String
}
