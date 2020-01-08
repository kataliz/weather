//
//  Forecast+Mock.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
@testable import Weather

extension Forecast {
    static func mockFull() -> Forecast {
        return Forecast(current: CurrentWeather.mockVeryColdMorning(), days: DaysForecast.mockDifferentForecast())
    }
    
    static func mockFullHot() -> Forecast {
        return Forecast(current: CurrentWeather.mockHotDay(), days: DaysForecast.mockDifferentForecast())
    }
}
