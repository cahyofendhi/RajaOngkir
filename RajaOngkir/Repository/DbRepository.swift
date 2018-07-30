//
//  DbRepository.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 30/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation
import RealmSwift

class DbRepository {
    
    static var instance = DbRepository()
    
    var realm : Realm!
    
    func insertDataProv(data: ProvData) {
        realm = try! Realm()
        let province = ProvinceRealm()
        province.provinceID = data.provinceID!
        province.province   = data.province!
        try! self.realm.write({
            self.realm.add(province)
        })
    }
    
    func getDataProv() -> [ProvData] {
        var item = [ProvData]()
        let realm = try! Realm()
        let objects = realm.objects(ProvinceRealm.self)
        for object in objects{
            item.append(ProvData(provinceID: object.provinceID, province: object.province))
        }
        return item
    }
    
    func insertDataCity(data: CityResult) {
        realm   = try! Realm()
        let city = CityRealm()
        city.cityID = data.cityID
        city.cityName = data.cityName
        city.provinceID = data.provinceID
        city.province = data.province
        try! self.realm.write({
            self.realm.add(city)
        })
    }
    
    func getDataCity(provId: String) -> [CityResult] {
        var item = [CityResult]()
        let realm = try! Realm()
        let objects = realm.objects(CityRealm.self).filter("provinceID == '\(provId)'")
        for it in objects{
            item.append(CityResult(cityID: it.cityID, provinceID: it.provinceID, province: it.province, type: "", cityName: it.cityName, postalCode: ""))
        }
        return item
    }
    
}
