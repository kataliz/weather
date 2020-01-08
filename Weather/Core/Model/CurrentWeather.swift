//
//  CurrentWeather.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    let temperature: Float
    let feelsLike: Float
    let condition: WeatherCondition
    
    // MARK: Lifecycle
    
    init(temperature: Float, feelsLike: Float, condition: WeatherCondition) {
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.condition = condition
    }
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case main
        case temperature = "temp"
        case feelsLike = "feels_like"
        case condition = "weather"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let main = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        self.temperature = try main.decode(Float.self, forKey: .temperature)
        self.feelsLike = try main.decode(Float.self, forKey: .feelsLike)
        let conditions = try container.decode([WeatherCondition].self, forKey: .condition)
        if let first = conditions.first {
            self.condition = first
        } else {
            throw NetworkError.parsingFailed
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var main = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        try container.encode([condition], forKey: .condition)
        try main.encode(temperature, forKey: .temperature)
        try main.encode(feelsLike, forKey: .feelsLike)
    }
}
