//
//  NativeApiClientSpec.swift
//  RajaOngkirTests
//
//  Created by Rumah Ulya on 03/09/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Quick
import Nimble

@testable import RajaOngkir

class ApiClientSpec : QuickSpec {
    override func spec() {
        super.spec()
        
        describe("request GetData ProvinceAndCity") {
            context("success") {
                it("returns ProvinceData") {
                    var data: Int? = nil
                    ApiRepository.instance.getProvince(result: { response in
                        data = response?.rajaongkir.status.code
                    })
                    expect(data).toEventually(equal(200), timeout: 20)
                    expect(data).toEventuallyNot(beNil(), timeout: 20)
                }
                
                it("returns CityData") {
                    var data: Int? = nil
                    ApiRepository.instance.getCity(provId: "33", result: { response in
                        data = response.rajaongkir.status.code
                    })
                    expect(data).toEventually(equal(200), timeout: 20)
                    expect(data).toEventuallyNot(beNil(), timeout: 20)
                }
            }
        }
        
        describe("requeest Cost"){
            context("success") {
                it("return cost delivery") {
                    var data: Int? = nil
                    ApiRepository.instance.postCost(originId: "256",
                                                    destinationId: "363",
                                                    weight: "1",
                                                    courier: "jne", result: { cost in
                        data    = cost.rajaongkir.status.code
                    }, errorMessage: { error in
                        data    = 422
                    })
                    expect(data).toEventually(equal(200), timeout: 20)
                    expect(data).toEventuallyNot(beNil(), timeout: 20)
                }
            }
        }
        
    }
}
