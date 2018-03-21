//
//  AirQualityMonitorUITests.swift
//  AirQualityMonitorUITests
//
//  Created by Karol on 20.03.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import XCTest

class AirQualityMonitorUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testBackButtonClicked() {
        
        let app = XCUIApplication()
        let wrocAwBartniczaStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Wrocław - Bartnicza"]/*[[".cells.staticTexts[\"Wrocław - Bartnicza\"]",".staticTexts[\"Wrocław - Bartnicza\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        wrocAwBartniczaStaticText.tap()
        app.navigationBars["AirQualityMonitor.AirQualityIndexView"].buttons["Back"].tap()
        wrocAwBartniczaStaticText.tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.children(matching: .button).element(boundBy: 1).tap()
        app.navigationBars["AirQualityMonitor.ChartsView"].buttons["Back"].tap()
        wrocAwBartniczaStaticText.tap()
        tabBarsQuery.children(matching: .button).element(boundBy: 2).tap()
        app.navigationBars["AirQualityMonitor.StationDetailsView"].buttons["Back"].tap()
    }
}
