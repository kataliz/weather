//
//  Forecast.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    var current: CurrentWeather
    var days: DaysForecast
}
