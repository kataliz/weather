//
//  DayWeather.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 04/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

struct DayWeather: Codable {
    var date: TimeInterval
    var sunrise: TimeInterval
    var sunset: TimeInterval
    var temperature: DayTemperature
    var feelsLike: DayTemperature
    var pressure: Int
    var humidity: Int
    var condition: WeatherCondition
    var windSpeed: Float
    var windDegree: Int
    var clouds: Int
    var rain: Float?
    var snow: Float?

    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunrise
        case sunset
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case condition = "weather"
        case windSpeed = "speed"
        case windDegree = "deg"
        case clouds
        case rain
        case snow
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(TimeInterval.self, forKey: .date)
        self.sunrise = try container.decode(TimeInterval.self, forKey: .sunrise)
        self.sunset = try container.decode(TimeInterval.self, forKey: .sunset)
        self.temperature = try container.decode(DayTemperature.self, forKey: .temperature)
        self.feelsLike = try container.decode(DayTemperature.self, forKey: .feelsLike)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.windSpeed = try container.decode(Float.self, forKey: .windSpeed)
        self.windDegree = try container.decode(Int.self, forKey: .windDegree)
        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.rain = try? container.decode(Float.self, forKey: .rain)
        self.snow = try? container.decode(Float.self, forKey: .snow)
        
        let conditions = try container.decode([WeatherCondition].self, forKey: .condition)
        guard let firstCondition = conditions.first else {
            // TODO: Decide how handle multiply weather Conditions
            throw NetworkError.parsingFailed
        }
        self.condition = firstCondition
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(sunrise, forKey: .sunrise)
        try container.encode(sunset, forKey: .sunset)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(feelsLike, forKey: .feelsLike)
        try container.encode(pressure, forKey: .pressure)
        try container.encode(humidity, forKey: .humidity)
        try container.encode(windSpeed, forKey: .windSpeed)
        try container.encode(windDegree, forKey: .windDegree)
        try container.encode(clouds, forKey: .clouds)
        try container.encode(rain, forKey: .rain)
        try container.encode(snow, forKey: .snow)
        try container.encode([condition], forKey: .condition)
    }
}
