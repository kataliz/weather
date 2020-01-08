//
//  CurrentWeather+Mock.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
@testable import Weather

extension CurrentWeather {
    static func mockVeryColdMorning() -> CurrentWeather {
        let weather = WeatherCondition(type: .fog, description: "Fog", iconName: "50d")
        return CurrentWeather(temperature: -14.0, feelsLike: -19.0, condition: weather)
    }
    
    static func mockHotDay() -> CurrentWeather {
        let weather = WeatherCondition(type: .clear, description: "Sun", iconName: "01d")
        return CurrentWeather(temperature: 22.0, feelsLike: 25.0, condition: weather)
    }
}
