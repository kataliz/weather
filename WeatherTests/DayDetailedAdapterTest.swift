//
//  DayDetailedAdapterTest.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import XCTest
@testable import Weather

class DayDetailedAdapterTest: XCTestCase {

    // MARK: Properties
    
    private var dayDetailedAdapter: DayDetailedAdapter!
    
    // MARK: XCTestCase
    
    override func setUp() {
        super.setUp()
        let locale = Locale(identifier: "en_US")
        let calendar = Calendar(identifier: .gregorian)
        
        let dayFormatter = DayLocalFormatter(locale: locale, calendar: calendar)
        dayDetailedAdapter = DayDetailedAdapter(dayFormatter: dayFormatter, unitFormatter: UnitFormatter())
    }
    
    func testDayName() {
        let dayInfo = DayWeather.mockRainHotDay()
        let city = ForecastCity.mockParis()
        let name = dayDetailedAdapter.dayName(dayInfo: dayInfo, for: city)
        XCTAssertEqual(name, "09 January")
    }
    
    func testTransformRain() {
        let dayInfo = DayWeather.mockRainHotDay()
        let city = ForecastCity.mockParis()
        let detailed = dayDetailedAdapter.transform(dayInfo: dayInfo, for: city)
        XCTAssertNotNil(detailed[0] as? DetailedTemperatureCellInfo)
        XCTAssertEqual((detailed[0] as! DetailedTemperatureCellInfo).relative, .normal)
        XCTAssertEqual((detailed[0] as! DetailedTemperatureCellInfo).feels.day, "+17°")
        XCTAssertTrue(detailed.compactMap { $0 as? DetailedUnitCellInfo }.contains(where: { $0.name == "Rain" }))
        XCTAssertFalse(detailed.compactMap { $0 as? DetailedUnitCellInfo }.contains(where: { $0.name == "Snow" }))
        XCTAssertEqual((detailed.last as! DetailedUnitCellInfo).info, "17:12")
    }
    
    func testTransformCold() {
        let dayInfo = DayWeather.mockVeryColdSnowDay()
        let city = ForecastCity.mockParis()
        let detailed = dayDetailedAdapter.transform(dayInfo: dayInfo, for: city)
        XCTAssertNotNil(detailed[0] as? DetailedTemperatureCellInfo)
        XCTAssertEqual((detailed[0] as! DetailedTemperatureCellInfo).relative, .cold)
        XCTAssertEqual((detailed[0] as! DetailedTemperatureCellInfo).feels.day, "-23°")
        XCTAssertTrue(detailed.compactMap { $0 as? DetailedUnitCellInfo }.contains(where: { $0.name == "Snow" }))
        XCTAssertEqual((detailed.last as! DetailedUnitCellInfo).info, "17:10")
    }
}
