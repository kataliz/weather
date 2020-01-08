//
//  DayWeather+Mock.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
@testable import Weather

extension DayWeather {
    static func mockVeryColdSnowDay() -> DayWeather {
        let date = Date(timeIntervalSince1970: 1578481200)
        let sunrise = Date(timeIntervalSince1970: 1578469364)
        let sunset = Date(timeIntervalSince1970: 1578499853)
        let temperature = DayTemperature(day: -20.0, night: -25.0, evening: -22.0, morning: -19.0)
        let feelsLike = DayTemperature(day: -23.0, night: -29.0, evening: -27.0, morning: -19.0)
        let condition = WeatherCondition(type: .snow, description: "Snowing", iconName: "13d")
        
        return DayWeather(date: date, sunrise: sunrise, sunset: sunset, temperature: temperature, feelsLike: feelsLike, pressure: 1030.0, humidity: 35.0, condition: condition, windSpeed: 10.0, windDegree: 215.0, rainVolume: nil, snowVolume: 9.9)
    }
    
    static func mockRainHotDay() -> DayWeather {
        let date = Date(timeIntervalSince1970: 1578567600)
        let sunrise = Date(timeIntervalSince1970: 1578555741)
        let sunset = Date(timeIntervalSince1970: 1578586326)
        let temperature = DayTemperature(day: 16.0, night: 5.0, evening: 10.0, morning: 11.0)
        let feelsLike = DayTemperature(day: 17.0, night: 5.0, evening: 12.0, morning: 11.0)
        let condition = WeatherCondition(type: .rain, description: "Raining", iconName: "10d")
        
        return DayWeather(date: date, sunrise: sunrise, sunset: sunset, temperature: temperature, feelsLike: feelsLike, pressure: 1060.0, humidity: 66.0, condition: condition, windSpeed: 2.0, windDegree: 10.0, rainVolume: 3.3, snowVolume: nil)
    }
    
    static func mockDryHotDay() -> DayWeather {
        let date = Date(timeIntervalSince1970: 1578654000)
        let sunrise = Date(timeIntervalSince1970: 1578642116)
        let sunset = Date(timeIntervalSince1970: 1578672801)
        let temperature = DayTemperature(day: 25.0, night: 17.0, evening: 22.9, morning: 19.0)
        let feelsLike = DayTemperature(day: 29.0, night: 18.0, evening: 24.0, morning: 22.0)
        let condition = WeatherCondition(type: .dust, description: "Dust", iconName: "50d")
        
        return DayWeather(date: date, sunrise: sunrise, sunset: sunset, temperature: temperature, feelsLike: feelsLike, pressure: 1000.5, humidity: 5.0, condition: condition, windSpeed: 3.0, windDegree: 98.0, rainVolume: nil, snowVolume: nil)
    }
}
