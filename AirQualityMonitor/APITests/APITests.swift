//
//  APITests.swift
//  APITests
//
//  Created by Karol on 19.03.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import XCTest
import Moya
import RxSwift
@testable import AirQualityMonitor

class APITests: XCTestCase {
    
    var provider: NetworkProvider<AirQualityService>!
    var stationId = 114
    var sensorId = 642
    
    override func setUp() {
        super.setUp()
        provider = NetworkProvider<AirQualityService>()
    }
    
    override func tearDown() {
        provider = nil
        super.tearDown()
    }
    
    func testFetchAllStatons() {
        let expectation = self.expectation(description: "Status code: 200")
        provider.request(.allStations) { response in
            switch response {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let stations = try response.map([Station].self)
                        XCTAssertTrue(stations.count > 0)
                    } catch {
                        XCTFail("Decoding failed")
                    }
                    expectation.fulfill()
                    return
                }
                XCTFail("Status code: \(response.statusCode)")
            case .failure(let statusCode):
                XCTFail("Status code: \(statusCode)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchStationSensors() {
        let expectation = self.expectation(description: "Status code: 200")
        provider.request(.stationSensors(id: stationId)) { response in
            switch response {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let sensors = try response.map([Sensor].self)
                        XCTAssertTrue(sensors.count > 0)
                    } catch {
                        XCTFail("Decoding failed")
                    }
                    expectation.fulfill()
                    return
                }
                XCTFail("Status code: \(response.statusCode)")
            case .failure(let statusCode):
                XCTFail("Status code: \(statusCode)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchSensorData() {
        let expectation = self.expectation(description: "Status code: 200")
        provider.request(.sensorData(id: sensorId)) { response in
            switch response {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let sensorData = try response.map(SensorData.self)
                        XCTAssertNotNil(sensorData)
                    } catch {
                        XCTFail("Decoding failed")
                    }
                    expectation.fulfill()
                    return
                }
                XCTFail("Status code: \(response.statusCode)")
            case .failure(let statusCode):
                XCTFail("Status code: \(statusCode)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchStationData() {
        let expectation = self.expectation(description: "Status code: 200")
        provider.request(.stationData(id: stationId)) { response in
            switch response {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let index = try response.map(AirQualityIndex.self)
                        XCTAssertNotNil(index)
                    } catch {
                        XCTFail("Decoding failed")
                    }
                    expectation.fulfill()
                    return
                }
                XCTFail("Status code: \(response.statusCode)")
            case .failure(let statusCode):
                XCTFail("Status code: \(statusCode)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
