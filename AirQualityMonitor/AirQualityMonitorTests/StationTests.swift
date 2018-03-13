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
    
    override func setUp() {
        super.setUp()
        station = Station()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStationDisplayAddressNilCase() {
        let displayAdress = station.getDisplayAddress()
        XCTAssert(displayAdress == "NoData".localized)
    }
}
