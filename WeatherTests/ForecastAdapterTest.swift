//
//  ForecastAdapterTest.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import XCTest
@testable import Weather

class ForecastAdapterTest: XCTestCase {

    // MARK: Properties
    
    private var forecastAdapter: ForecastAdapter!
    
    // MARK: XCTestCase
    
    override func setUp() {
        super.setUp()
        let locale = Locale(identifier: "en_US")
        let calendar = Calendar(identifier: .gregorian)
        
        let dayFormatter = DayLocalFormatter(locale: locale, calendar: calendar)
        forecastAdapter = ForecastAdapter(dayFormatter: dayFormatter, unitFormatter: UnitFormatter())
    }
    
    func testTransform() {
        let forecast = Forecast.mockFull()
        let transformed = forecastAdapter.transformDaysWeather(from: forecast)
        
        XCTAssertEqual(transformed.days.count,forecast.days.daysWeather.count)
        XCTAssertEqual(transformed.days[0].date,"08 January")
        XCTAssertEqual(transformed.days[0].nightTemperature,"-25°")
        XCTAssertEqual(transformed.days[1].dayTemperature,"+16°")
        XCTAssertEqual(transformed.days[2].date,"10 January")
        XCTAssertEqual(transformed.current.feelsLike,"Feels like -19°")
        XCTAssertEqual(transformed.current.temperature,"-14°")
    }
}
