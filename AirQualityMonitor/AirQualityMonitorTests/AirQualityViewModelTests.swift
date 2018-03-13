//
//  AirQualityViewModelTests.swift
//  AirQualityMonitorTests
//
//  Created by Karol on 13.03.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import XCTest
@testable import AirQualityMonitor

class AirQualityViewModelTests: XCTestCase {
    
    var vm: AirQualityViewModel!
    let sampleArray = [Measurement()]
    
    override func setUp() {
        super.setUp()
        vm = AirQualityViewModel(flowDelegate: AirQualityCoordinator(station: Station()), station: Station())
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    func testEmptyArray() {
        let lowest = vm.getLowestMeasurement(measurements: [])
        XCTAssertNotNil(lowest)
        XCTAssertNil(lowest.indexLevelEnum)
    }
}
