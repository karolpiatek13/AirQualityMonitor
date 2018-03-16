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
    var measurements: [AirQualityMonitor.Measurement] = []
    
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
    
    func testOneValueArray() {
        let measurement = Measurement()
        measurement.indexLevelEnum = IndexNameEnum.veryGood
        let lowest = vm.getLowestMeasurement(measurements: [measurement])
        XCTAssert(lowest.indexLevelEnum == IndexNameEnum.veryGood)
    }
    
    func testReversedSortedArray() {
        for index in (1..<6).reversed() {
            let measurement = AirQualityMonitor.Measurement()
            measurement.indexLevelEnum = IndexNameEnum(rawValue: index)
            measurements.append(measurement)
        }
        let lowest = vm.getLowestMeasurement(measurements: measurements)
        XCTAssert(lowest.indexLevelEnum == IndexNameEnum.veryBad)
    }
    
    func testSortedArray() {
        for index in 1..<6 {
            let measurement = AirQualityMonitor.Measurement()
            measurement.indexLevelEnum = IndexNameEnum(rawValue: index)
            measurements.append(measurement)
        }
        let lowest = vm.getLowestMeasurement(measurements: measurements)
        XCTAssert(lowest.indexLevelEnum == IndexNameEnum.veryBad)
    }
    
    func testDefaultValueAtLastPosition() {
        for index in 1..<7 {
            let measurement = AirQualityMonitor.Measurement()
            measurement.indexLevelEnum = IndexNameEnum(rawValue: index)
            measurements.append(measurement)
        }
        let lowest = vm.getLowestMeasurement(measurements: measurements)
        XCTAssert(lowest.indexLevelEnum == IndexNameEnum.veryBad)
    }
    
    func testDefaultValueAtFirstPosition() {
        measurements.append(AirQualityMonitor.Measurement())
        for index in 1..<6 {
            let measurement = AirQualityMonitor.Measurement()
            measurement.indexLevelEnum = IndexNameEnum(rawValue: index)
            measurements.append(measurement)
        }
        let lowest = vm.getLowestMeasurement(measurements: measurements)
        XCTAssert(lowest.indexLevelEnum == IndexNameEnum.veryBad)
    }
    
    func testDefaultValueAtMiddlePosition() {
        for index in 1..<6 {
            let measurement = AirQualityMonitor.Measurement()
            measurement.indexLevelEnum = IndexNameEnum(rawValue: index)
            measurements.append(measurement)
        }
        measurements.insert(AirQualityMonitor.Measurement(), at: 3)
        let lowest = vm.getLowestMeasurement(measurements: measurements)
        XCTAssert(lowest.indexLevelEnum == IndexNameEnum.veryBad)
    }
}
