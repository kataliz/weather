//
//  MockDayForecast.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
@testable import Weather

extension DaysForecast {
    static func mockDifferentForecast() -> DaysForecast {
        let paris = ForecastCity.mockParis()
        let days = [DayWeather.mockVeryColdSnowDay(),DayWeather.mockRainHotDay(),DayWeather.mockDryHotDay()]
        return DaysForecast(city: paris, daysWeather: days)
    }
}
