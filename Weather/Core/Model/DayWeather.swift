//
//  DayWeather.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 04/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

struct DayWeather: Codable {
    var date: Date
    var sunrise: Date
    var sunset: Date
    var temperature: DayTemperature
    var feelsLike: DayTemperature
    var pressure: Float
    var humidity: Float
    var condition: WeatherCondition
    var windSpeed: Float
    var windDegree: Float
    var rainVolume: Float?
    var snowVolume: Float?

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
        case rainVolume = "rain"
        case snowVolume = "snow"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        self.sunrise = try container.decode(Date.self, forKey: .sunrise)
        self.sunset = try container.decode(Date.self, forKey: .sunset)
        self.temperature = try container.decode(DayTemperature.self, forKey: .temperature)
        self.feelsLike = try container.decode(DayTemperature.self, forKey: .feelsLike)
        self.pressure = try container.decode(Float.self, forKey: .pressure)
        self.humidity = try container.decode(Float.self, forKey: .humidity)
        self.windSpeed = try container.decode(Float.self, forKey: .windSpeed)
        self.windDegree = try container.decode(Float.self, forKey: .windDegree)
        self.rainVolume = try? container.decode(Float.self, forKey: .rainVolume)
        self.snowVolume = try? container.decode(Float.self, forKey: .snowVolume)
        
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
        try container.encode(rainVolume, forKey: .rainVolume)
        try container.encode(snowVolume, forKey: .snowVolume)
        try container.encode([condition], forKey: .condition)
    }
}
