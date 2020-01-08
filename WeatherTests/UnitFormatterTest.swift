//
//  UnitFormatterTest.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import XCTest
@testable import Weather

class UnitFormatterTest: XCTestCase {

    // MARK: Properties
    
    private var unitFormatter = UnitFormatter()
    
    // MARK: XCTestCase
    
    func testTemperature() {
        let cold = unitFormatter.temperature(-5.5)
        XCTAssertEqual(cold, "-6°")
        let hot = unitFormatter.temperature(54.2)
        XCTAssertEqual(hot, "+54°")
        let nearZero = unitFormatter.temperature(-0.4)
        XCTAssertEqual(nearZero, "0°")
        let zero = unitFormatter.temperature(0.0)
        XCTAssertEqual(zero, "0°")
    }
    
    func testVolume() {
        let rain = unitFormatter.volume(6.6)
        XCTAssertEqual(rain, "7 mm")
        let nearZero = unitFormatter.volume(0.1)
        XCTAssertEqual(nearZero, "0 mm")
        let wrongValue = unitFormatter.volume(-100.0)
        XCTAssertEqual(wrongValue, "0 mm")
    }
    
    func testPressure() {
        let oneHPa = unitFormatter.pressure(1.0)
        XCTAssertEqual(oneHPa, "1 mmHg")
        let fiveHPa = unitFormatter.pressure(5.0)
        XCTAssertEqual(fiveHPa, "4 mmHg")
        let wrongValue = unitFormatter.pressure(-5.0)
        XCTAssertEqual(wrongValue, "0 mmHg")
    }
    
    func testHumidity() {
        let normalHumidity = unitFormatter.humidity(55.6)
        XCTAssertEqual(normalHumidity, "56 %")
        let wrongValue = unitFormatter.humidity(-55.6)
        XCTAssertEqual(wrongValue, "0 %")
    }
    
    func testWind() {
        let littleNorth = unitFormatter.wind(5.0, degrees: 0.0)
        XCTAssertEqual(littleNorth, "5 m/s, N")
        let stormNorthEast = unitFormatter.wind(15.4, degrees: 45.0)
        XCTAssertEqual(stormNorthEast, "15 m/s, NE")
        let calm = unitFormatter.wind(0.2, degrees: 45.0)
        XCTAssertEqual(calm, "Calm")
        let wrongValue = unitFormatter.wind(-40.0, degrees: 780.0)
        XCTAssertEqual(wrongValue, "Calm")
    }
}
