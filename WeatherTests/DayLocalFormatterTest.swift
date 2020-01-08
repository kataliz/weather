//
//  DayLocalFormatterTest.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import XCTest
@testable import Weather

class DayLocalFormatterTest: XCTestCase {

    // MARK: Properties
    
    private var dayLocalFormatter: DayLocalFormatter!
    
    // MARK: XCTestCase
    
    override func setUp() {
        super.setUp()
        dayLocalFormatter = DayLocalFormatter(locale: Locale(identifier: "en_US"), calendar: Calendar(identifier: .gregorian))
    }

    func testRelativeNames() {
        let today = Date()
        let toDayName = dayLocalFormatter.relativeDay(from: today)
        XCTAssertEqual(toDayName, "Today")
        let tommorow = Date(timeIntervalSinceNow: 24.0*60.0*60.0)
        let name = dayLocalFormatter.relativeDay(from: tommorow)
        XCTAssertEqual(name, "Tomorrow")
    }
    
    func testZonedDate() {
        let dateInParis = Date(timeIntervalSince1970: 1578567600)
        dayLocalFormatter.configure(timezone: 3600)
        let date = dayLocalFormatter.formattedDay(from: dateInParis)
        XCTAssertEqual(date, "09 January")
        
        let timeSunset = Date(timeIntervalSince1970: 1578586326)
        dayLocalFormatter.configure(timezone: 3600)
        let time = dayLocalFormatter.formattedTime(from: timeSunset)
        XCTAssertEqual(time, "17:12")
    }
}
