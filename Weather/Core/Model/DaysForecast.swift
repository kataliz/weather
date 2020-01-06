//
//  DaysForecast.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 05/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

struct DaysForecast: Codable {
    var city: ForecastCity
    var daysWeather: [DayWeather]
    
    // MARK: Computed
    
    var cityName: String {
        return city.name
    }
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case city
        case daysWeather = "list"
    }
}

typealias GMTTimeZone = Int

struct ForecastCity: Codable {
    var id: UInt
    var name: String
    var timezone: GMTTimeZone
}
