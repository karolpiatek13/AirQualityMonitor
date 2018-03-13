//
//  StationTests.swift
//  AirQualityMonitorTests
//
//  Created by Karol on 13.03.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import XCTest
@testable import AirQualityMonitor

class StationTests: XCTestCase {
    
    var station: Station!
    let cityNameValue = "City"
    let streetNameValue = "Street"
    let expectedAddress = "Street, City"
    
    override func setUp() {
        super.setUp()
        station = Station()
    }
    
    override func tearDown() {
        station = nil
        super.tearDown()
    }
    
    func testDisplayAddressNilCase() {
        let displayAdress = station.getDisplayAddress()
        XCTAssert(displayAdress == "NoData".localized)
    }
    
    func testDisplayAddressCityNameCase() {
        citySetup()
        let displayAdress = station.getDisplayAddress()
        XCTAssert(displayAdress == cityNameValue)
    }
    
    func citySetup() {
        let cityName = cityNameValue
        var city = City()
        city.name = cityName
        station.city = city
    }
    
    func testDisplayAddressFullNameCase() {
        citySetup()
        streetSetup()
        let displayAdress = station.getDisplayAddress()
        XCTAssert(displayAdress == expectedAddress)
    }
    
    func streetSetup() {
        station.addressStreet = streetNameValue
    }
}
