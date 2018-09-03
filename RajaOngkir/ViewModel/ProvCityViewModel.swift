//
//  ProvCityViewModel.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation

class ProvCityViewModel {
    
    static let instance = ProvCityViewModel()
    
    func getProvData(result: @escaping(_ data: [ProvData]) -> ()) {
        let itemDb = DbRepository.instance.getDataProv()
        if itemDb.count > 0 {
            print("from db")
            result(itemDb)
        } else {
            ApiRepository.instance.getProvince { response in
                print("from api")
                if let result = response {
                    let dt = result.rajaongkir.results
                    for it in dt {
                        DbRepository.instance.insertDataProv(data: it)
                    }
                }
            }
        }
    }
    
    func getCityData(provId: String, result: @escaping(_ data: [CityResult]) -> ()) {
        let itemDb = DbRepository.instance.getDataCity(provId: provId)
        if itemDb.count > 0 {
            print("from db")
            result(itemDb)
        } else {
            ApiRepository.instance.getCity(provId: provId) { response in
                print("from api")
                let dt = response.rajaongkir.results
                result(dt)
                for it in dt {
                    DbRepository.instance.insertDataCity(data: it)
                }
                
            }
        }
    }
    
}
