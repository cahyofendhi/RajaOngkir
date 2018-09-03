//
//  ProvinceResponse.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation
import RealmSwift

class Province: Codable {
    var rajaongkir: RajaongkirProv
    
    init(rajaongkir: RajaongkirProv) {
        self.rajaongkir = rajaongkir
    }
}

class RajaongkirProv: Codable {
    let query: [Query]
    let status: Status
    let results: [ProvData]
    
    init(query: Query, status: Status, results: ProvData) {
        self.query = [query]
        self.status = status
        self.results = [results]
    }
}

class Query: Codable {
    let id: String
    
    init(id: String) {
        self.id = id
    }
}

class ProvData: Codable {
    let provinceID: String?
    let province: String?
    
    enum CodingKeys: String, CodingKey {
        case provinceID = "province_id"
        case province
    }
    
    init(provinceID: String, province: String) {
        self.provinceID = provinceID
        self.province = province
    }
}

class Status: Codable {
    let code: Int?
    let description: String?
    
    init(code: Int, description: String) {
        self.code = code
        self.description = description
    }
}

