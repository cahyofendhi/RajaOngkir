//
//  CityRealm.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 30/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation
import RealmSwift

class CityRealm: Object {
    @objc dynamic var cityID = ""
    @objc dynamic var provinceID = ""
    @objc dynamic var province = ""
    @objc dynamic var cityName = ""
}
