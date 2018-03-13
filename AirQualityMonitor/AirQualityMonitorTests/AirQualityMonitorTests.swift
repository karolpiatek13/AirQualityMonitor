//
//  AirQualityMonitorTests.swift
//  AirQualityMonitorTests
//
//  Created by Karol on 13.03.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import XCTest
@testable import AirQualityMonitor

class AirQualityMonitorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStationDisplayAddressNilCase() {
        let station = Station()
        let displayAdress = station.getDisplayAddress()
        XCTAssert(displayAdress == "NoData".localized)
    }
    
    func test() {
        
    }
}
